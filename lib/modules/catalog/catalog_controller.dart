import 'dart:convert';
import 'package:aesera_jewels/models/catalog_model.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

// ✅ Import your dashboard screen
import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';

class CatalogController extends GetxController {
  var isLoading = true.obs;
  var productList = <ProductModel>[].obs;

  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();

  var selectedProduct = Rxn<ProductModel>();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  /// Fetch products
  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse("http://13.204.96.244:3000/api/get-products"),
      );

      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body);
        productList.value = decoded
            .map((json) => ProductModel.fromJson(json))
            .toList();
            print("Fetched ${productList.length} products");
      } else {
        Get.snackbar(
          "Error",
          "Failed to fetch products",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  /// Open Address BottomSheet
  void openAddressBottomSheet(ProductModel product) {
    selectedProduct.value = product;

    Get.bottomSheet(
      SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery Address",
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
              const SizedBox(height: 20),

              /// Show Product Amount (Non-Editable)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Amount",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0D0F1C),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6FDFF),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                          spreadRadius: 0.02,
                        ),
                      ],
                    ),
                    child: Text(
                      "₹ ${product.price} (${product.grams ?? 0} gm)",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              buildInputField(
                "Address",
                addressController,
                "Enter your address",
                inputFormatters: [LengthLimitingTextInputFormatter(35)],
              ),
              const SizedBox(height: 16),
              buildInputField(
                "City",
                cityController,
                "Enter your city",
                inputFormatters: [
                  LengthLimitingTextInputFormatter(35),
                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s]")),
                ],
              ),
              const SizedBox(height: 16),
              buildInputField(
                "Postal Code",
                postalCodeController,
                "Enter your postal code",
                type: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: submitCatalogPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF09243D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  /// Build input field
  Widget buildInputField(
    String label,
    TextEditingController controller,
    String hint, {
    TextInputType type = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0D0F1C),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF6FDFF),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 3),
                spreadRadius: 0.02,
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: type,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF2596BE),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              counterText: "",
            ),
          ),
        ),
      ],
    );
  }

  /// Submit catalog payment
  Future<void> submitCatalogPayment() async {
    final product = selectedProduct.value;
    if (product == null) return;

    final address = addressController.text.trim();
    final city = cityController.text.trim();
    final postal = postalCodeController.text.trim();

    if (address.isEmpty || city.isEmpty || postal.isEmpty) {
      Get.snackbar(
        "Validation",
        "All fields are required",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
        Uri.parse('http://13.204.96.244:3000/api/catalogPayment'),
      );
      request.body = json.encode(body);
      print("Request Body: ${request.body}");
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(await response.stream.bytesToString());
        CatalogPaymentModel payment = CatalogPaymentModel.fromJson(
          responseData["data"],
        );

        // ✅ Close bottomsheet
        Get.back();

        // ✅ Show success message
        Get.snackbar(
          "Success",
          "Catalog Payment Created Successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // ✅ Navigate to DashboardScreen
        Get.offAll(() => DashboardScreen());

        print("✅ Catalog Payment ID: ${payment.id}");
        print("✅ Grams: ${payment.grams}, Paid Grams: ${payment.paidGrams}");
      } else {
        Get.snackbar(
          "Error",
          response.reasonPhrase ?? "Failed",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
