import 'dart:convert';
import 'package:aesera_jewels/models/payment_model.dart';
import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../services/storage_service.dart';
 
class Payment_Controller extends GetxController {
  /// Toggles
  RxBool isOwnNumber = true.obs;
  RxBool isRupees = true.obs;
 
  /// Fields
  RxString enteredMobile = ''.obs;
  RxInt enteredAmount = 0.obs; // can be amount or grams
  RxString selectedValue = ''.obs;
 
  /// Quick select options
  List<String> rupeesOptions = ["5000", "10000", "20000", "50000"];
  List<String> gramsOptions = ["1", "2", "5", "10"];
 
  /// API base URL
  final String baseUrl = "http://13.204.96.244:3000/api/newPayment";
 
  /// Gold Rate
  RxDouble goldRate = 0.0.obs;
 
  @override
  void onInit() async {
    super.onInit();
    // Load gold rate from local storage
    String? rate = await StorageService.getGoldRate();
    goldRate.value = double.tryParse(rate ?? "0") ?? 0;
  }
 
  /// Toggle between own and others number
  void toggleNumber(bool own) {
    isOwnNumber.value = own;
  }
 
  /// Toggle between rupees and grams
  void toggleMode(bool rupees) {
    isRupees.value = rupees;
    enteredAmount.value = 0;
    selectedValue.value = '';
  }
 
  /// Update amount when typing
  void updateEnteredAmount(int value) {
    enteredAmount.value = value;
  }
 
  /// Quick select value
  void selectValue(String value) {
    selectedValue.value = value;
    enteredAmount.value = int.tryParse(value) ?? 0;
  }
 
  /// Calculate conversion result
  String getConversion() {
    if (goldRate.value == 0) return "Loading...";
    if (isRupees.value) {
      double gm = enteredAmount.value / goldRate.value;
      return "${gm.toStringAsFixed(3)} gm";
    } else {
      double rupees = enteredAmount.value * goldRate.value;
      return "₹${rupees.toStringAsFixed(2)}";
    }
  }
 
  /// Create Payment API Call
  Future<void> createPayment() async {
    try {
      String? mobile = isOwnNumber.value
          ? StorageService().getMobile()
          : enteredMobile.value;
 
      if (mobile == null || mobile.isEmpty) {
        Get.snackbar("Error", "Please enter mobile number");
        return;
      }
 
      double amount = isRupees.value ? enteredAmount.value.toDouble() : 0;
      double gram = isRupees.value ? 0 : enteredAmount.value.toDouble();
 
      double amountAllocated = amount > 0 ? amount : gram * goldRate.value;
      double gramAllocated = gram > 0 ? gram : amount / goldRate.value;
 
      var token = await StorageService.getTokenAsync();
      print("Token: $token");
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
 
      var body = json.encode({
        "mobile": mobile,
        "others": isOwnNumber.value ? "" : enteredMobile.value,
        "amount": amount,
        "gram_allocated": gramAllocated.toStringAsFixed(4),
        "gram": gram,
        "amount_allocated": amountAllocated,
      });
 
      print("Request Body: $body");
 
      var response = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: body,
      );
 
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        PaymentModel payment = PaymentModel.fromJson(data);
 
        Get.snackbar("Success", "Payment successfully created!");
 
        /// 👇 Navigate to DashboardScreen instead of InvestmentDetailScreen
        Get.offAll(() => DashboardScreen());
      } else {
        Get.snackbar("Error", "Failed: ${response.reasonPhrase}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
 
 