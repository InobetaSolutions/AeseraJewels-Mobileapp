
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:aesera_jewels/modules/investment_details/portfolio_view.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import '../buy_gold/buy_gold_controller.dart';

class PaymentSelectionController extends GetxController {
  var selectedTab = 0.obs; // 0 = Own Number, 1 = Others Number
  var isLoading = false.obs;
  Rx<XFile?> screenshot = Rx<XFile?>(null);

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final picker = ImagePicker();

  void switchTab(int index) {
    selectedTab.value = index;
    mobileController.clear();
    screenshot.value = null;
  }

  Future<void> pickImageSource() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) screenshot.value = image;
  }

  /// ✅ Submit Payment
  Future<void> submitPayment({required String sourceScreen}) async {
    String amountText = amountController.text.trim();

    // ✅ Remove symbols if user pasted "₹300" or "300gm"
    String cleanAmount = amountText.replaceAll(RegExp(r'[^0-9]'), '');
    int? amount = int.tryParse(cleanAmount);

    // ✅ Get mobile from StorageService if "Own Number" selected
    final storage = Get.find<StorageService>();
    String storedMobile = storage.getMobile() ?? "";
    String mobile = selectedTab.value == 0
        ? storedMobile
        : mobileController.text.trim();

    // 🔹 Validations
    if (amount == null || amount <= 0) {
      Get.snackbar("Error", "Please enter a valid amount");
      return;
    }
    if (mobile.isEmpty) {
      Get.snackbar("Error", "Please enter mobile number");
      return;
    }
    if (!RegExp(r'^\d{10}$').hasMatch(mobile)) {
      Get.snackbar("Error", "Mobile number must be 10 digits");
      return;
    }

    isLoading.value = true;
    try {
      final uri = Uri.parse('http://13.204.96.244:3000/api/create-payment');
      final body = jsonEncode({
        "mobile": mobile,
        "amount": amount, // ✅ integer only
      });

      print("📤 Sending request to: $uri");
      print("📦 Body: $body");

      var response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      isLoading.value = false;

      print("📥 Response Code: ${response.statusCode}");
      print("📥 Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Payment submitted successfully");

        /// ✅ Navigation after success
        if (sourceScreen == "catalog") {
          Get.offAll(() => InvestmentDetailScreen(initialTabIndex: 2));
        } else if (sourceScreen == "") {
          final buyGoldCtrl = Get.find<BuyGoldController>();
          int tabIndex = buyGoldCtrl.isRupees.value ? 0 : 1;
          Get.offAll(() => InvestmentDetailScreen(initialTabIndex: tabIndex));
        } else {
          Get.offAll(() => InvestmentDetailScreen(initialTabIndex: 0));
        }
      } else {
        final msg = response.body.isNotEmpty
            ? response.body
            : response.reasonPhrase ?? "Unknown error";
        Get.snackbar("Error", "Failed: $msg");
      }
    } catch (e) {
      isLoading.value = false;
      print("❌ Exception: $e");
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }
}
