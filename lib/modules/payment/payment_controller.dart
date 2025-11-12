

import 'package:aesera_jewels/models/summary_model.dart';
import 'package:aesera_jewels/modules/summary/summary_screen.dart';
import 'package:aesera_jewels/services/storage_service.dart';
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

  /// Dynamic Gold Rate
  RxDouble goldRate = 0.0.obs;
  RxBool isLoadingGoldRate = true.obs;

  /// Static Options
  final rupeesOptions = ["100", "500", "1000", "2000"];
  final gramsOptions = ["1", "2", "5", "10"];

  @override
  void onInit() {
    super.onInit();
    _loadGoldRate();
  }

  /// ✅ Load gold rate from StorageService
  Future<void> _loadGoldRate() async {
    try {
      isLoadingGoldRate(true);
      final savedRate = await StorageService.getGoldRate();
      if (savedRate != null) {
        goldRate.value = double.parse(savedRate);
        print('Loaded gold rate: ₹${goldRate.value} per gram');
      } else {
        // No fallback value - will remain 0.0 if no rate is available
        print('No gold rate available from storage');
      }
    } catch (e) {
      print('Error loading gold rate: $e');
    } finally {
      isLoadingGoldRate(false);
    }
  }

  /// ✅ Update gold rate dynamically (can be called from dashboard)
  void updateGoldRate(double newRate) {
    goldRate.value = newRate;
    print('Gold rate updated to: ₹$newRate per gram');
  }

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

  /// ✅ Dynamic Conversion Logic using API gold rate
  String getConversion() {
    if (enteredAmount.value <= 0 || goldRate.value <= 0) return "";

    if (isRupees.value) {
      // Convert Rupees → Grams
      final grams = enteredAmount.value / goldRate.value;
      return "${grams.toStringAsFixed(3)} gm";
    } else {
      // Convert Grams → Rupees
      final rupees = enteredAmount.value * goldRate.value;
      return "₹${rupees.toStringAsFixed(2)}";
    }
  }

  /// ✅ Navigate to Summary Screen with dynamic calculations
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

    if (goldRate.value <= 0) {
      Get.snackbar(
        "Error",
        "Gold rate not available. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white,
      );
      return;
    }

    /// Calculate gold quantity & value using dynamic gold rate
    double goldQuantity = isRupees.value
        ? enteredAmount.value / goldRate.value
        : enteredAmount.value.toDouble();
    
    double goldValue = isRupees.value
        ? enteredAmount.value.toDouble()
        : enteredAmount.value * goldRate.value;

    /// Calculate tax & delivery
    double taxAmount = goldValue * 0.03; // Example 3% GST
    double deliveryCharge = 400; // Example delivery charge
    double totalWithTax = goldValue + taxAmount + deliveryCharge;

    /// Full payable (same as totalWithTax)
    double amountPayable = totalWithTax;

    /// ✅ Create SummaryModel with dynamic gold rate
    final summary = SummaryModel(
      goldRate: goldRate.value,
      goldQuantity: goldQuantity,
      goldValue: goldValue,
      gst: taxAmount,
      amountPayable: amountPayable,
      taxAmount: taxAmount,
      deliveryCharge: deliveryCharge,
      totalWithTax: totalWithTax,
    );

    /// ✅ Navigate to Summary Screen
    Get.to(() => SummaryScreen(summary: summary));
  }

  /// ✅ Get current conversion rate for display
  String get goldRateDisplay {
    return "₹${goldRate.value.toStringAsFixed(2)}/gm";
  }
}