

import 'dart:convert';
import 'package:aesera_jewels/models/catalog_model.dart';
import 'package:aesera_jewels/modules/payment_selection/payment_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CatalogController extends GetxController {
  var isLoading = true.obs;
  var productList = <ProductModel>[].obs;

  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();

  final selectedValue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  /// Fetch products from API
  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse("http://13.204.96.244:3000/api/get-products"));

      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body);
        productList.value =
            decoded.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        Get.snackbar("Error", "Failed to fetch products",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  /// Open Bottom Sheet for Address Input
  void openAddressBottomSheet() {
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
                      height: 28 / 22,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close, color: Colors.black),
                  )
                ],
              ),
              const SizedBox(height: 20),

              buildInputField("Address", addressController, "Enter your address",
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(35),
                  ]),
              const SizedBox(height: 16),

              buildInputField("City", cityController, "Enter your city",
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(35),
                    FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s]")),
                  ]),
              const SizedBox(height: 16),

              buildInputField("Postal Code", postalCodeController, "Enter your postal code",
                  type: TextInputType.number, inputFormatters: [
                LengthLimitingTextInputFormatter(6),
                FilteringTextInputFormatter.digitsOnly,
              ]),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: submitAddress,
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

  /// Custom Input Field Widget
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
                color: Color(0xFF2596BE),
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              counterText: "",
            ),
          ),
        ),
      ],
    );
  }

  /// Validate and Submit Address
  void submitAddress() {
    final address = addressController.text.trim();
    final city = cityController.text.trim();
    final postal = postalCodeController.text.trim();

    if (address.isEmpty || city.isEmpty || postal.isEmpty) {
      _showError("All fields are required");
      return;
    }
    if (city.length > 35 || !RegExp(r'^[a-zA-Z\s]+$').hasMatch(city)) {
      _showError("City must be letters up to 35 chars");
      return;
    }
    if (address.length > 35) {
      _showError("Address must be within 35 characters");
      return;
    }
    if (!RegExp(r'^\d{6}$').hasMatch(postal)) {
      _showError("Postal code must be exactly 6 digits");
      return;
    }

    Get.back();
    Get.to(
      () => PaymentScreen(),
      arguments: {
        "amount": selectedValue.value.toStringAsFixed(2),
        "source": "catalog",
      },
    );
  }

  void _showError(String msg) {
    Get.snackbar(
      "Validation",
      msg,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
