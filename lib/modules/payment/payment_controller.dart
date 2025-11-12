
import 'package:aesera_jewels/models/summary_model.dart';
import 'package:aesera_jewels/modules/summary/summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  /// Flags
  RxBool isRupees = true.obs;
  RxBool isOwnNumber = true.obs;

  /// Inputs
  RxString enteredMobile = "".obs;
  RxInt enteredAmount = 0.obs;
  RxString selectedValue = "".obs;

  /// Static Options
  final rupeesOptions = ["100", "500", "1000", "2000"];
  final gramsOptions = ["1", "2", "5", "10"];

  /// ✅ Current gold rate per gram (realistic value)
  double goldRate = 11781.49; // ₹ per gram

  /// Toggle between Rupees and Grams
  void toggleMode(bool rupees) {
    isRupees.value = rupees;
    enteredAmount.value = 0;
    selectedValue.value = "";
  }

  /// Update entered amount manually
  void updateEnteredAmount(int value) {
    enteredAmount.value = value;
  }

  /// Select quick button value
  void selectValue(String option) {
    enteredAmount.value = int.tryParse(option) ?? 0;
    selectedValue.value = option;
  }

  /// ✅ Correct Conversion Logic
  String getConversion() {
    if (enteredAmount.value <= 0) return "";

    if (isRupees.value) {
      // Convert Rupees → Grams
      final grams = enteredAmount.value / goldRate;
      return "${grams.toStringAsFixed(3)} gm";
    } else {
      // Convert Grams → Rupees
      final rupees = enteredAmount.value * goldRate;
      return "₹${rupees.toStringAsFixed(2)}";
    }
  }

  /// ✅ Navigate to Summary Screen with calculated + bound parameters
  void goToSummary() {
    if (enteredAmount.value <= 0) {
      Get.snackbar(
        "Error",
        "Enter a valid amount or weight",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white,
      );
      return;
    }

    /// Calculate gold quantity & value
    double goldQuantity = isRupees.value
        ? enteredAmount.value / goldRate
        : enteredAmount.value.toDouble();
    double goldValue = isRupees.value
        ? enteredAmount.value.toDouble()
        : enteredAmount.value * goldRate;

    /// Calculate tax & delivery
    double taxAmount = goldValue * 0.03; // Example 3% GST
    double deliveryCharge = 400; // Example delivery charge
    double totalWithTax = goldValue + taxAmount + deliveryCharge;

    /// Full payable (same as totalWithTax)
    double amountPayable = totalWithTax;

    /// ✅ Create SummaryModel with all fields
    final summary = SummaryModel(
      goldRate: goldRate,
      goldQuantity: goldQuantity,
      goldValue: goldValue,
      gst: taxAmount, // renamed in SummaryModel
      amountPayable: amountPayable,
      taxAmount: taxAmount,
      deliveryCharge: deliveryCharge,
      totalWithTax: totalWithTax,
    );

    /// ✅ Navigate to Summary Screen
    Get.to(() => SummaryScreen(summary: summary));
  }
}

