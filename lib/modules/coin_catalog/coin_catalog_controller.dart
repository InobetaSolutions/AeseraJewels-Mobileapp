import 'dart:convert';
import 'package:aesera_jewels/modules/investment_details/investment_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../Api/base_url.dart';
import '../../models/catalog_model.dart';
import '../../models/Addresses_model.dart';
import '../../modules/dashboard/dashboard_view.dart';
import '../../modules/address/address_screen.dart';
import '../../modules/summary/summary_screen.dart';
import '../../services/storage_service.dart';

class CoinCatalogController extends GetxController {
  var isLoading = true.obs;
  var productList = <ProductModel>[].obs;

  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final productAmountController = TextEditingController();

  var selectedProduct = Rxn<ProductModel>();
  var taxPercentage = 0.0.obs;
  var deliveryCharge = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchTax();
    fetchDeliveryCharge();
  }

  /// Fetch products
  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse("${BaseUrl.baseUrl}get-products"));
      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body);
        productList.value = decoded.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        Get.snackbar("Error", "Failed to fetch products",
            backgroundColor:const Color(0xFF09243D) , colorText: Colors.white);
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
      var request = http.Request('GET', Uri.parse('${BaseUrl.baseUrl}getDeliveryCharge'));
      final response = await request.send();
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(await response.stream.bytesToString());
        deliveryCharge.value = (jsonData["data"]["amount"] ?? 0).toDouble();
      }
    } catch (_) {}
  }

  /// Payment selection dialog
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
              openAddressBottomSheet(item); // New Payment flow
            },
            child: const Text("New Payment"),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 45),
              backgroundColor: Colors.amber
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.to(() =>InvestmentDetailScreen(initialTabIndex: 2)); // Revert Payment
            },
            child: const Text("Revert Payment"),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 45),
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void openAddressBottomSheet(ProductModel product) async {
    selectedProduct.value = product;

    // Pre-fill Product Amount (non-editable)
    productAmountController.text =
        "₹ ${product.price}   (${product.grams ?? 0} gm)";

    // Fetch delivery addresses
    List<AddressModel> addresses = [];
    try {
      final userId = await StorageService.getUserId();
      if (userId != null) {
        final headers = await StorageService().getAuthHeaders();
        final uri =
            Uri.parse("${BaseUrl.baseUrl}getDeliveryAddress");
        final body = json.encode({"userid": userId});
        final response = await http.post(uri, headers: headers, body: body);

        if (response.statusCode == 200) {
          final jsonData = jsonDecode(await response.body);
          if (jsonData["status"] == "true") {
            final List data = jsonData["data"];
            addresses = data.map((e) => AddressModel.fromJson(e)).toList();
          }
        }
      }
    } catch (e) {
      Get.snackbar("Error",  " please check your internet connection",
          backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
    }

    var selectedAddressIndex = 0.obs;

    // Show BottomSheet
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          double price = product.price?.toDouble() ?? 0.0;
          double tax = (price * taxPercentage.value) / 100;
          double total = price + tax + deliveryCharge.value;

          return SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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

                  // 👉 Price Card
                  _buildPriceCard(price, tax, deliveryCharge.value, total),

                  const SizedBox(height: 10),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text("Select Delivary Location",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0D0F1C),
                          ),),),

                    ),
                      
                  // 👉 If no addresses found, just show message
                  if (addresses.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text("Please update the delivery address",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700])),
                      ),
                    ),
                   
                  // 👉 Show only name with radio button
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
                          // 👉 No addresses → go to AddAddressScreen
                          Get.back();
                          Get.to(() => AddressScreen());
                        } else {
                          // 👉 Normal flow
                          final selected = addresses[selectedAddressIndex.value];
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

  /// Card Widget for showing Price + Tax + Delivery + Total
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
          _buildRow("Tax (${taxPercentage.value.toStringAsFixed(0)}%)",
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

  /// Submit Catalog Payment API
  Future<void> submitCatalogPayment() async {
    final product = selectedProduct.value;
    if (product == null) return;

    final address = addressController.text.trim();
    final city = cityController.text.trim();
    final postal = postalCodeController.text.trim();

    if (address.isEmpty || city.isEmpty || postal.isEmpty) {
      Get.snackbar("Validation", "Please select a delivery address",
          backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
      return;
    }

    final mobile = StorageService().getMobile() ?? "Unknown";

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
        final responseData = jsonDecode(await response.stream.bytesToString());
        CatalogPaymentModel payment =
            CatalogPaymentModel.fromJson(responseData["data"]);

        Get.back();
        Get.snackbar("Success", "Catalog Payment Created Successfully",
            backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
        Get.offAll(() => DashboardScreen());

        print("✅ Catalog Payment ID: ${payment.id}");
      } else {
        Get.snackbar("Error", response.reasonPhrase ?? "Failed",
            backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error",  " please check your internet connection",
          backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
    }
  }
}
