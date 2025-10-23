
import 'dart:convert';
import 'package:aesera_jewels/modules/address/address_screen.dart';
import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
import 'package:aesera_jewels/modules/investment_details/investment_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../Api/base_url.dart';
import '../../models/catalog_model.dart';
import '../../models/Addresses_model.dart';
import '../../services/storage_service.dart';

class CoinCatalogController extends GetxController {
  var isLoading = true.obs;
  var productList = <ProductModel>[].obs;

  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final productAmountController = TextEditingController();
  final revertAmountController = TextEditingController();

  var selectedProduct = Rxn<ProductModel>();
  var taxPercentage = 0.0.obs;
  var deliveryCharge = 0.0.obs;

  var totalInvestment = 0.0.obs;
  var remainingAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchTax();
    fetchDeliveryCharge();
    fetchTotalInvestment();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final response =
          await http.get(Uri.parse("${BaseUrl.baseUrl}get-products"));
      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body);
        productList.value =
            decoded.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        Get.snackbar("Error", "Failed to fetch products",
            backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
      }
    } catch (_) {
      Get.snackbar("Error", "Please check your internet connection",
          backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchTax() async {
    try {
      var request = http.Request('GET', Uri.parse('${BaseUrl.baseUrl}getTax'));
      final response = await request.send();
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(await response.stream.bytesToString());
        taxPercentage.value = (jsonData["data"]["percentage"] ?? 0).toDouble();
      }
    } catch (_) {}
  }

  Future<void> fetchDeliveryCharge() async {
    try {
      var request =
          http.Request('GET', Uri.parse('${BaseUrl.baseUrl}getDeliveryCharge'));
      final response = await request.send();
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(await response.stream.bytesToString());
        deliveryCharge.value = (jsonData["data"]["amount"] ?? 0).toDouble();
      }
    } catch (_) {}
  }

  Future<void> fetchTotalInvestment() async {
    try {
      final mobile = await StorageService.getMobileAsync();
      if (mobile != null) {
        final headers = await StorageService().getAuthHeaders();
        final response = await http.post(
          Uri.parse("${BaseUrl.baseUrl}getpaymenthistory"),
          headers: headers,
          body: jsonEncode({"mobile": mobile}),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          totalInvestment.value = (data["totalAmount"] ?? 0).toDouble();
        }
      }
    } catch (_) {}
  }

  void showPaymentMethodDialog(ProductModel item) {
    Get.defaultDialog(
      title: "Select Payment Type",
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      radius: 12,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Choose your payment method for this purchase.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.back();
              openAddressBottomSheet(item);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 45),
              backgroundColor: const Color(0xFFFFB700),
            ),
            child: const Text(
              "Make a New Payment",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Get.back();
              openRevertPaymentBottomSheet(item);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 45),
              backgroundColor: const Color(0xFF0A2A4D),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: const Text(
                  "Deduct from the Invested Amount",textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openAddressBottomSheet(ProductModel product) async {
    selectedProduct.value = product;
    productAmountController.text =
        "₹ ${product.price}   (${product.grams ?? 0} gm)";

    List<AddressModel> addresses = await _fetchUserAddresses();
    var selectedAddressIndex = 0.obs;

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          double price = product.price?.toDouble() ?? 0.0;
          double tax = (price * taxPercentage.value) / 100;
          double total = price + tax + deliveryCharge.value;

          return SingleChildScrollView(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Order Details",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0D0F1C),
                          )),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.close, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildPriceCard(price, tax, deliveryCharge.value, total),
                  const SizedBox(height: 16),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Select Delivery Location",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0D0F1C),
                        ),
                      ),
                    ),
                  ),
                  if (addresses.isEmpty)
                    const Text("Please add a delivery address."),
                  if (addresses.isNotEmpty)
                    ...List.generate(addresses.length, (index) {
                      final addr = addresses[index];
                      return Obx(() => RadioListTile<int>(
                            value: index,
                            groupValue: selectedAddressIndex.value,
                            title: Text(addr.name ?? ""),
                            onChanged: (val) {
                              selectedAddressIndex.value = val!;
                              final selected = addresses[val];
                              addressController.text = selected.address ?? "";
                              cityController.text = selected.city ?? "";
                              postalCodeController.text =
                                  selected.postalCode ?? "";
                            },
                          ));
                    }),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (addresses.isEmpty) {
                          Get.back();
                          Get.to(() => AddressScreen());
                        } else {
                          final selected =
                              addresses[selectedAddressIndex.value];
                          addressController.text = selected.address ?? "";
                          cityController.text = selected.city ?? "";
                          postalCodeController.text =
                              selected.postalCode ?? "";
                          submitCatalogPayment();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF09243D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        addresses.isEmpty ? "Add Address" : "Submit",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      ),
      isScrollControlled: true,
    );
  }

  void openRevertPaymentBottomSheet(ProductModel product) {
    selectedProduct.value = product;
    revertAmountController.text = "";
    remainingAmount.value = totalInvestment.value;

    Get.bottomSheet(
      
      StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
           
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        "Deduct  from  the Invested  Amount",textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(() => _buildRevertAmountRow()),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          submitRevertPayment();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A2A4D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Center(
                          child: const Text(
                            "Deduct from the Invested Amount",textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      isScrollControlled: true,
    );
  }

  // Widget _buildRevertAmountRow() {
  //   double revert = double.tryParse(revertAmountController.text) ?? 0.0;
  //   remainingAmount.value = totalInvestment.value - revert;

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       TextField(
  //         controller: revertAmountController,
  //         keyboardType: TextInputType.number,
  //         inputFormatters: [
  //           FilteringTextInputFormatter.digitsOnly,
  //           LengthLimitingTextInputFormatter(10),
  //         ],
  //         decoration: const InputDecoration(
  //           labelText: "Revert Amount",
  //           border: OutlineInputBorder(),
  //         ),
  //         onChanged: (val) {
  //           double amount = double.tryParse(val) ?? 0.0;
  //           remainingAmount.value = totalInvestment.value - amount;
  //         },
  //       ),
  //       const SizedBox(height: 12),
  //       Container(
  //         width: double.infinity,
  //         padding: const EdgeInsets.all(20),
  //         decoration: BoxDecoration(
  //           color: const Color(0xFF0A2A4D),
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               "Total Investment Amount: ₹${totalInvestment.value.toStringAsFixed(2)}",
  //               style: const TextStyle(color: Colors.amber, fontSize: 18),
  //             ),
  //             const SizedBox(height: 8),
  //             Text(
  //               "Remaining Balance Amount: ₹${remainingAmount.value.toStringAsFixed(2)}",
  //               style: GoogleFonts.plusJakartaSans(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.w700,
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
  Widget _buildRevertAmountRow() {
  double revert = double.tryParse(revertAmountController.text) ?? 0.0;
  remainingAmount.value = totalInvestment.value - revert;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 4,
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
        child: TextField(
          controller: revertAmountController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.teal,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 8,
                top: 10,
                bottom: 0
              ),
              child: Text(
                "₹",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
            ),
            // hintText: "Enter Revert Amount",
            // hintStyle: const TextStyle(color: Colors.grey
            // ),
          ),
          onChanged: (val) {
            double amount = double.tryParse(val) ?? 0.0;
            remainingAmount.value = totalInvestment.value - amount;
          },
        ),
      ),
      const SizedBox(height: 12),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF0A2A4D),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Investment Amount: ₹${totalInvestment.value.toStringAsFixed(2)}",
              style: GoogleFonts.plusJakartaSans(
               
                fontWeight: FontWeight.w700,
               color: Colors.amber, fontSize: 15),
            ),
            const SizedBox(height: 8),
            Text(
              "Remaining Balance Amount: ₹${remainingAmount.value.toStringAsFixed(2)}",
              style: GoogleFonts.plusJakartaSans(
               
                fontWeight: FontWeight.w700,
               color: Colors.amber, fontSize: 15
              ),
            ),
          ],
        ),
      ),
    ],
  );
}


  Future<List<AddressModel>> _fetchUserAddresses() async {
    List<AddressModel> addresses = [];
    try {
      final userId = await StorageService.getUserId();
      if (userId != null) {
        final headers = await StorageService().getAuthHeaders();
        final uri = Uri.parse("${BaseUrl.baseUrl}getDeliveryAddress");
        final body = json.encode({"userid": userId});
        final response = await http.post(uri, headers: headers, body: body);
        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          if (jsonData["status"] == "true") {
            final List data = jsonData["data"];
            addresses = data.map((e) => AddressModel.fromJson(e)).toList();
          }
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Please check your internet connection",
          backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
    }
    return addresses;
  }

  Future<void> submitCatalogPayment() async {
    final product = selectedProduct.value;
    if (product == null) return;

    final address = addressController.text.trim();
    final city = cityController.text.trim();
    final postal = postalCodeController.text.trim();

    if (address.isEmpty || city.isEmpty || postal.isEmpty) {
      Get.snackbar("Validation", "Please select a delivery address",
          backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
      return;
    }

    final mobile = await StorageService.getMobileAsync() ?? "Unknown";

    final body = {
      "mobileNumber": mobile,
      "tagid": product.tagId,
      "goldType": product.goldtype,
      "description": product.description,
      "amount": product.price,
      "grams": product.grams ?? 0,
      "address": address,
      "city": city,
      "postCode": postal,
      "Paidamount": product.price,
      "Paidgrams": product.grams ?? 0,
    };

    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
        'POST',
        Uri.parse('${BaseUrl.baseUrl}catalogPayment'),
      );
      request.body = json.encode(body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        Get.snackbar("Success", "Catalog Payment Created Successfully",
            backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
        Get.offAll(() => DashboardScreen());
      } else {
        Get.snackbar("Error", response.reasonPhrase ?? "Failed",
            backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Please check your internet connection",
          backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
    }
  }

  Future<void> submitRevertPayment() async {
    final product = selectedProduct.value;
    if (product == null) return;

    double revertAmount = double.tryParse(revertAmountController.text) ?? 0.0;
    if (revertAmount <= 0 || revertAmount > totalInvestment.value) {
      Get.snackbar("Validation", "Enter valid revert amount",
          backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
      return;
    }

    try {
      final mobile = await StorageService.getMobileAsync() ?? "Unknown";

      final body = {
        "mobileNumber": mobile,
        "productId": product.id,
        "revertAmount": revertAmount,
      };

      final headers = await StorageService().getAuthHeaders();
      final response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}revertPayment"),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar("Success", "Payment reverted successfully",
            backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
        fetchTotalInvestment();
      } else {
        Get.snackbar("Error", "Failed to revert payment",
            backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Please check your internet connection",
          backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
    }
  }

  Widget _buildPriceCard(
      double price, double tax, double delivery, double total) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0A2A4D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow("Product Price", "₹ ${price.toStringAsFixed(2)}"),
          const SizedBox(height: 8),
          _buildRow(
              "Tax (${taxPercentage.value.toStringAsFixed(0)}%)",
              "₹ ${tax.toStringAsFixed(2)}"),
          const SizedBox(height: 8),
          _buildRow("Delivery Charges", "₹ ${delivery.toStringAsFixed(2)}"),
          const Divider(color: Colors.white70),
          _buildRow("Total Amount", "₹ ${total.toStringAsFixed(2)}",
              isBold: true),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                color: Colors.amber,
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text(value,
            style: TextStyle(
                color: Colors.amber,
                fontSize: 18,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w600)),
      ],
    );
  }
}
