
import 'package:aesera_jewels/models/summary_model.dart';
import 'package:aesera_jewels/modules/summary/summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  RxBool isRupees = true.obs;
  RxBool isOwnNumber = true.obs;

  RxString enteredMobile = "".obs;
  RxInt enteredAmount = 0.obs;
  RxString selectedValue = "".obs;

  final rupeesOptions = ["100", "500", "1000", "2000"];
  final gramsOptions = ["1", "2", "5", "10"];

  double goldRate = 6000; // Example rate ₹/gm

  void toggleMode(bool rupees) {
    isRupees.value = rupees;
    enteredAmount.value = 0;
    selectedValue.value = "";
  }

  void updateEnteredAmount(int value) {
    enteredAmount.value = value;
  }

  void selectValue(String option) {
    enteredAmount.value = int.tryParse(option) ?? 0;
    selectedValue.value = option;
  }

  String getConversion() {
    if (isRupees.value) {
      final grams = enteredAmount.value / goldRate;
      return grams > 0 ? "${grams.toStringAsFixed(3)} gm" : "";
    } else {
      final rupees = enteredAmount.value * goldRate;
      return rupees > 0 ? "₹${rupees.toStringAsFixed(2)}" : "";
    }
  }

  /// Navigate to Summary Screen with calculated data
  void goToSummary() {
    if (enteredAmount.value <= 0) {
      Get.snackbar(
        "Error",
        "Enter a valid amount/weight",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF09243D), colorText: Colors.white
      );
      return;
    }

    double goldQuantity = isRupees.value
        ? enteredAmount.value / goldRate
        : enteredAmount.value.toDouble();
    double goldValue = isRupees.value
        ? enteredAmount.value.toDouble()
        : enteredAmount.value * goldRate;
    double gst = goldValue * 0.03;
    double amountPayable = goldValue + gst;

    final summary = SummaryModel(
      goldRate: goldRate,
      goldQuantity: goldQuantity,
      goldValue: goldValue,
      gst: gst,
      amountPayable: amountPayable,
    );

    Get.to(() => SummaryScreen(summary: summary));
  }
}
