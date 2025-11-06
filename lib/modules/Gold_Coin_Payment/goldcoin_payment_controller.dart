
import 'dart:convert';
import 'package:aesera_jewels/Api/base_url.dart';
import 'package:aesera_jewels/models/Addresses_model.dart';
import 'package:aesera_jewels/models/catalog_model.dart';
import 'package:aesera_jewels/modules/address/address_screen.dart';
import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class GoldCoinPaymentController extends GetxController {
  var goldRate = 0.0.obs;
  var taxPercent = 0.0.obs;
  var deliveryCharge = 0.0.obs;
  var isLoading = false.obs;
  var productList = <ProductModel>[].obs;
 var addressesList = <AddressModel>[].obs;


 
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final productAmountController = TextEditingController();
  final revertAmountController = TextEditingController();
  final paidAmountController = TextEditingController();
  var selectedProduct = Rxn<ProductModel>();
  var taxPercentage = 0.0.obs;
  

  var totalInvestment = 0.0.obs;
  var remainingAmount = 0.0.obs;
  var deductedAmount = 0.0.obs;
  var paidAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAPIs();
    fetchTax();
    fetchProducts();
    fetchDeliveryCharge();
    fetchTotalInvestment();
     fetchUserAddresses();
  }

  Future<void> fetchAPIs() async {
    await Future.wait([_fetchGoldRate(), _fetchTax(), _fetchDelivery()]);
  }

  Future<void> _fetchGoldRate() async {
    try {
      final res = await http.get(Uri.parse('${BaseUrl.baseUrl}getCurrentRate'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        goldRate.value = (data["price_gram_24k"] ?? 0).toDouble();
      }
    } catch (_) {}
  } 

  Future<void> _fetchTax() async {
    try {
      final res = await http.get(Uri.parse('${BaseUrl.baseUrl}getTax'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data["status"] == true) {
          taxPercent.value = (data["data"]["percentage"] ?? 0).toDouble();
        }
      }
    } catch (_) {}
  }

  Future<void> _fetchDelivery() async {
    try {
      final res =
          await http.get(Uri.parse('${BaseUrl.baseUrl}getDeliveryCharge'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data["status"] == true) {
          deliveryCharge.value = (data["data"]["amount"] ?? 0).toDouble();
        }
      }
    } catch (_) {}
  }


  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse("${BaseUrl.baseUrl}get-products"),
      );
      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body);
        productList.value = decoded
            .map((e) => ProductModel.fromJson(e))
            .toList();
      } else {
        Get.snackbar(
          "Error",
          "Failed to fetch products",
          backgroundColor: const Color(0xFF09243D),
          colorText: Colors.white,
        );
      }
    } catch (_) {
      Get.snackbar(
        "Error",
        "Please check your internet connection",
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white,
      );
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
        taxPercent.value = (jsonData["data"]["percentage"] ?? 0).toDouble();
      }
    } catch (_) {}
  }

  Future<void> fetchDeliveryCharge() async {
    try {
      var request = http.Request(
        'GET',
        Uri.parse('${BaseUrl.baseUrl}getDeliveryCharge'),
      );
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
          remainingAmount.value = totalInvestment.value;
        }
      }
    } catch (_) {}
  }

  Future<void> fetchUserAddresses() async {
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
            addressesList.value = data.map((e) => AddressModel.fromJson(e)).toList();
          } else {
            addressesList.value = [];
          }
        } else {
          addressesList.value = [];
        }
      }
    } catch (e) {
      addressesList.value = [];
      print("Error fetching addresses: $e");
    }
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
                  "Deduct from the Invested Amount",
                  textAlign: TextAlign.center,
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

    // Refresh addresses before showing bottom sheet
    await fetchUserAddresses();
    var selectedAddressIndex = 0.obs;

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          // Dynamic calculations using API data
          double price = product.price?.toDouble() ?? 0.0;
          double tax = (price * taxPercent.value) / 100;
          double total = price + tax + deliveryCharge.value;

          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
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
                      Text(
                        "Order Details",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0D0F1C),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.close, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Dynamic Price Card using API data
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
                        _buildRow("Product Price", "₹ ${price.toStringAsFixed(2)}"),
                        const SizedBox(height: 8),
                        _buildRow(
                          "Tax (${taxPercent.value.toStringAsFixed(0)}%)",
                          "₹ ${tax.toStringAsFixed(2)}",
                        ),
                        const SizedBox(height: 8),
                        _buildRow("Delivery Charges", "₹ ${deliveryCharge.value.toStringAsFixed(2)}"),
                        const Divider(color: Colors.white70),
                        _buildRow(
                          "Total Amount",
                          "₹ ${total.toStringAsFixed(2)}",
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                  
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
                  
                  // Dynamic addresses from API
                  Obx(() {
                    if (addressesList.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "No addresses found. Please add a delivery address.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                    
                    return Column(
                      children: List.generate(addressesList.length, (index) {
                        final addr = addressesList[index];
                        return Obx(
                          () => RadioListTile<int>(
                            value: index,
                            groupValue: selectedAddressIndex.value,
                            title: Text(addr.name ?? ""),
                            onChanged: (val) {
                              selectedAddressIndex.value = val!;
                              final selected = addressesList[val];
                              addressController.text = selected.address ?? "";
                              cityController.text = selected.city ?? "";
                              postalCodeController.text = selected.postalCode ?? "";
                            },
                          ),
                        );
                      }),
                    );
                  }),
                  
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (addressesList.isEmpty) {
                          Get.back();
                          Get.to(() => AddressScreen());
                        } else {
                          final selected = addressesList[selectedAddressIndex.value];
                          addressController.text = selected.address ?? "";
                          cityController.text = selected.city ?? "";
                          postalCodeController.text = selected.postalCode ?? "";
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
                        addressesList.isEmpty ? "Add Address" : "pay",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
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

  void openRevertPaymentBottomSheet(ProductModel product) async {
    selectedProduct.value = product;

    revertAmountController.text = "";
    paidAmountController.clear();

    deductedAmount.value = 0.0;
    paidAmount.value = 0.0;

    // Clear any previous investment controller and fetch fresh data
    await fetchTotalInvestment();
    remainingAmount.value = totalInvestment.value;

    // Refresh addresses before showing bottom sheet
    await fetchUserAddresses();
    var selectedAddressIndex = 0.obs;

    double price = product.price.toDouble();
    double tax = (price * taxPercent.value) / 100;
    double delivery = deliveryCharge.value;
    double totalBeforeDeduction = price + tax + delivery;

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          // Create a local controller that always shows the current investment value
          TextEditingController investmentController = TextEditingController(
            text: totalInvestment.value.toStringAsFixed(2),
          );

          return Obx(() {
            // ✅ Calculate final total
            double finalTotal =
                (price + tax + delivery) - totalInvestment.value;
            if (finalTotal.isNaN || finalTotal < 0) finalTotal = 0.0;

            bool hasInsufficientBalance =
                totalInvestment.value > remainingAmount.value;

            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
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
                    /// ---------- Header ----------
                    Center(
                      child: Text(
                        "Payment Summary",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// ---------- Non-editable Fields ----------
                    _nonEditableField(
                      "Product Price",
                      "₹${price.toStringAsFixed(2)}",
                    ),
                    const SizedBox(height: 10),
                    _nonEditableField(
                      "Tax (${taxPercent.value.toStringAsFixed(0)}%)",
                      "₹${tax.toStringAsFixed(2)}",
                    ),
                    const SizedBox(height: 10),
                    _nonEditableField(
                      "Delivery Charge",
                      "₹${deliveryCharge.value.toStringAsFixed(2)}",
                    ),
                    const SizedBox(height: 10),

                    /// ---------- Editable Investment Field ----------
                    _editableField(
                      "Investment",
                      investmentController,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: (val) {
                        double enteredInvestment =
                            double.tryParse(val.trim()) ?? 0.0;
                        totalInvestment.value = enteredInvestment;
                      },
                    ),

                    /// 🔴 Warning if not enough balance
                    if (hasInsufficientBalance)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "You don't have enough balance to complete this payment.\nYour available balance is ₹${remainingAmount.value.toStringAsFixed(2)}.",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                    const SizedBox(height: 10),
                    const Divider(height: 15, color: Colors.grey),

                    /// ---------- Final Total ----------
                    _nonEditableField(
                      "Final Total",
                      "₹${finalTotal.toStringAsFixed(2)}",
                      isBold: true,
                    ),

                    const SizedBox(height: 15),

                    /// ---------- Address Section ----------
                    Text(
                      "Select Delivery Location",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0D0F1C),
                      ),
                    ),
                    const SizedBox(height: 10),

                    if (addressesList.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text("Please add a delivery address."),
                      ),

                    if (addressesList.isNotEmpty)
                      ...List.generate(addressesList.length, (index) {
                        final addr = addressesList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Obx(
                            () => RadioListTile<int>(
                              value: index,
                              groupValue: selectedAddressIndex.value,
                              title: Text(addr.name ?? ""),
                              subtitle: Text(
                                "${addr.address ?? ""}, ${addr.city ?? ""}",
                              ),
                              onChanged: (val) {
                                selectedAddressIndex.value = val!;
                                final selected = addressesList[val];
                                addressController.text = selected.address ?? "";
                                cityController.text = selected.city ?? "";
                                postalCodeController.text = selected.postalCode ?? "";
                              },
                            ),
                          ),
                        );
                      }),

                    const SizedBox(height: 10),

                    /// ---------- Submit Button ----------
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (addressesList.isEmpty) {
                            Get.back();
                            Get.to(() => AddressScreen());
                          } else {
                            final selected = addressesList[selectedAddressIndex.value];
                            addressController.text = selected.address ?? "";
                            cityController.text = selected.city ?? "";
                            postalCodeController.text = selected.postalCode ?? "";

                            _submitRevertPayment(
                              product,
                              deductedAmount.value,
                              paidAmount.value,
                              totalBeforeDeduction,
                              finalTotal,
                              tax,
                              selected,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A2A4D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          addressesList.isEmpty ? "Add Address" : "pay",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          });
        },
      ),
      isScrollControlled: true,
    );
  }

  /// 🔹 Helper Widget for Non-Editable Field
  Widget _nonEditableField(String label, String value, {bool isBold = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  /// 🔹 Helper Widget for Editable Field (Total Investment)
  Widget _editableField(
    String label,
    TextEditingController controller, {
    void Function(String)? onChanged,
    required TextInputType keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF4F4F4),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  /// Final Revert Payment API Call
  Future<void> _submitRevertPayment(
    ProductModel product,
    double deduct,
    double paidNow,
    double totalBeforeDeduction,
    double finalTotal,
    double tax,
    AddressModel address,
  ) async {
    try {
      final mobile = await StorageService.getMobileAsync() ?? "Unknown";

      // Prepare the request body according to your API
      final body = {
        "mobileNumber": mobile,
       
        "amount": product.price.toString(),
        "paidAmount": finalTotal.toInt(), // This is the final amount to pay
        "investAmount": totalInvestment.value.toInt(), // Investment amount used
        "grams": product.grams ?? 0,
        "address": address.address ?? "",
        "city": address.city ?? "",
        "postCode": address.postalCode ?? "",
        "taxAmount": tax.toInt(),
        "deliveryCharge": deliveryCharge.value.toInt(),
      };

      // Call the catalog payment API
      final catalogPaymentResponse = await _submitCatalogPaymentAPI(body);

      if (catalogPaymentResponse != null &&
          catalogPaymentResponse.status == true) {
        Get.back();
        Get.offAll(() => DashboardScreen());
        Get.snackbar(
          "Success",
          catalogPaymentResponse.message ?? "Payment successful",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          catalogPaymentResponse?.message ?? "Payment failed",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Please check your internet connection: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// New Catalog Payment API Integration
  Future<CatalogPaymentResponse?> _submitCatalogPaymentAPI(
    Map<String, dynamic> body,
  ) async {
    try {
      var headers = {'Content-Type': 'application/json'};

      var request = http.Request(
        'POST',
        Uri.parse('${BaseUrl.baseUrl}catalogPayment1'),
      );
      request.body = json.encode(body);
      request.headers.addAll(headers);

      print("Request Body: ${request.body}");

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseString = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseString);
        return CatalogPaymentResponse.fromJson(jsonResponse);
      } else {
        print("API Error: ${response.reasonPhrase}");
        return CatalogPaymentResponse(
          status: false,
          message: response.reasonPhrase ?? "API call failed",
        );
      }
    } catch (e) {
      print("Exception: $e");
      return CatalogPaymentResponse(
        status: false,
        message: "Network error: $e",
      );
    }
  }

  Future<void> submitCatalogPayment() async {
    final product = selectedProduct.value;
    if (product == null) return;

    final address = addressController.text.trim();
    final city = cityController.text.trim();
    final postal = postalCodeController.text.trim();

    if (address.isEmpty || city.isEmpty || postal.isEmpty) {
      Get.snackbar(
        "Validation",
        "Please select a delivery address",
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white,
      );
      return;
    }

    final mobile = await StorageService.getMobileAsync() ?? "Unknown";
    double price = product.price?.toDouble() ?? 0.0;
    double tax = (price * taxPercent.value) / 100;
    double totalAmount = price + tax + deliveryCharge.value;

    final body = {
      "mobileNumber": mobile,
      
      "amount": price.toString(),
      "paidAmount": totalAmount.toInt(),
      "investAmount": 0, // For new payment, no investment amount used
      "grams": product.grams ?? 0,
      "address": address,
      "city": city,
      "postCode": postal,
      "taxAmount": tax.toInt(),
      "deliveryCharge": deliveryCharge.value.toInt(),
    };

    try {
      final catalogPaymentResponse = await _submitCatalogPaymentAPI(body);

      if (catalogPaymentResponse != null &&
          catalogPaymentResponse.status == true) {
        Get.back();
        Get.snackbar(
          "Success",
          catalogPaymentResponse.message ??
              "Catalog Payment Created Successfully",
          backgroundColor: const Color(0xFF09243D),
          colorText: Colors.white,
        );
        Get.offAll(() => DashboardScreen());
      } else {
        Get.snackbar(
          "Error",
          catalogPaymentResponse?.message ?? "Payment failed",
          backgroundColor: const Color(0xFF09243D),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Please check your internet connection",
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white,
      );
    }
  }

  Widget _buildPriceCard(
    double price,
    double tax,
    double delivery,
    double total,
  ) {
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
            "Tax (${taxPercent.value.toStringAsFixed(0)}%)",
            "₹ ${tax.toStringAsFixed(2)}",
          ),
          const SizedBox(height: 8),
          _buildRow("Delivery Charges", "₹ ${delivery.toStringAsFixed(2)}"),
          const Divider(color: Colors.white70),
          _buildRow(
            "Total Amount",
            "₹ ${total.toStringAsFixed(2)}",
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.amber,
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.amber,
            fontSize: 18,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class CatalogPaymentResponse {
  final bool status;
  final String message;
  final CatalogPaymentModel? data;

  CatalogPaymentResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory CatalogPaymentResponse.fromJson(Map<String, dynamic> json) {
    return CatalogPaymentResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? CatalogPaymentModel.fromJson(json['data'])
          : null,
    );
  }
}