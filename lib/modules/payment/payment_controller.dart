
// import 'dart:convert';
// import 'package:aesera_jewels/models/payment_model.dart';
// import 'package:aesera_jewels/modules/investment_details/investment_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../../services/storage_service.dart';

// class Payment_Controller extends GetxController {
//   /// Toggles
//   RxBool isOwnNumber = true.obs;
//   RxBool isRupees = true.obs;

//   /// Fields
//   RxString enteredMobile = ''.obs;
//   RxInt enteredAmount = 0.obs; // can be rupees or grams
//   RxString selectedValue = ''.obs;

//   /// Quick select options
//   List<String> rupeesOptions = ["5000", "10000", "20000", "50000"].obs;
//   List<String> gramsOptions = ["1", "2", "5", "10"].obs;

//   /// API URL
//   final String baseUrl = "http://13.204.96.244:3000/api/newPayment";

//   /// Gold Rate
//   RxDouble goldRate = 0.0.obs;

//   @override
//   void onInit() async {
//     super.onInit();
//     String? rate = await StorageService.getGoldRate();
//     goldRate.value = double.tryParse(rate ?? "0") ?? 0;
//   }

//   void toggleNumber(bool own) => isOwnNumber.value = own;

//   void toggleMode(bool rupees) {
//     isRupees.value = rupees;
//     enteredAmount.value = 0;
//     selectedValue.value = '';
//   }

//   void updateEnteredAmount(int value) {
//     enteredAmount.value = value;
//   }

//   void selectValue(String value) {
//     selectedValue.value = value;
//     enteredAmount.value = int.tryParse(value) ?? 0;
//   }

//   String getConversion() {
//     if (goldRate.value == 0) return "Loading...";
//     if (isRupees.value) {
//       double gm = enteredAmount.value / goldRate.value;
//       return "${gm.toStringAsFixed(3)} g";
//     } else {
//       double rupees = enteredAmount.value * goldRate.value;
//       return "₹${rupees.toStringAsFixed(2)}";
//     }
//   }

//   /// Create Payment API Call
//   Future<void> createPayment() async {
//     try {
//       String? mobile =
//           isOwnNumber.value ? StorageService().getMobile() : enteredMobile.value;

//       if (mobile == null || mobile.isEmpty) {
//         Get.snackbar("Error", "Please enter mobile number");
//         return;
//       }

//       // Separate rupees vs grams input
//       double amount = isRupees.value ? enteredAmount.value.toDouble() : 0;
//       double gram = isRupees.value ? 0 : enteredAmount.value.toDouble();

//       // Allocate both sides
//       double amountAllocated = amount > 0 ? amount : gram * goldRate.value;
//       double gramAllocated = gram > 0 ? gram : amount / goldRate.value;

//       var token = await StorageService.getTokenAsync();
//       var headers = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       };

//       var body = json.encode({
//         "mobile": mobile,
//         "others": isOwnNumber.value ? "" : enteredMobile.value,
//         "amount": amount,
//         "gram": gram,
//         "amount_allocated": amountAllocated,
//         "gram_allocated": gramAllocated,
//       });

//       print("Request Body: $body");

//       var response =
//           await http.post(Uri.parse(baseUrl), headers: headers, body: body);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         var data = json.decode(response.body);
//         PaymentModel payment = PaymentModel.fromJson(data);

//         Get.snackbar("Success", "Payment successfully created!");

//         // ✅ Navigate to correct tab
//         int initialTabIndex = payment.amount == 0 ? 1 : 0;
//         Get.offAll(() => InvestmentDetailScreen(initialTabIndex: initialTabIndex));
//       } else {
//         Get.snackbar("Error", "Failed: ${response.reasonPhrase}");
//       }
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     }
//   }
// }
import 'dart:convert';
import 'package:aesera_jewels/models/payment_model.dart';
import 'package:aesera_jewels/modules/investment_details/investment_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../services/storage_service.dart';

class Payment_Controller extends GetxController {
  /// Toggles
  final RxBool isOwnNumber = true.obs;
  final RxBool isRupees = true.obs;

  /// Fields
  final RxString enteredMobile = ''.obs;
  final RxInt enteredAmount = 0.obs; // can be rupees or grams
  final RxString selectedValue = ''.obs;

  /// Quick select options
  final RxList<String> rupeesOptions = <String>["5000", "10000", "20000", "50000"].obs;
  final RxList<String> gramsOptions = <String>["1", "2", "5", "10"].obs;

  /// API URL
  final String baseUrl = "http://13.204.96.244:3000/api/newPayment";

  /// Gold Rate
  final RxDouble goldRate = 0.0.obs;

  @override
  void onInit() async {
    super.onInit();
    String? rate = await StorageService.getGoldRate();
    goldRate.value = double.tryParse(rate ?? "0") ?? 0;

    /// Default selection
    selectedValue.value = rupeesOptions.first;
  }

  /// Toggle between own number / others
  void toggleNumber(bool own) => isOwnNumber.value = own;

  /// Toggle between rupees and grams
  void toggleMode(bool rupees) {
    isRupees.value = rupees;
    enteredAmount.value = 0;
    selectedValue.value = rupees ? rupeesOptions.first : gramsOptions.first;
  }

  /// Update entered amount manually
  void updateEnteredAmount(int value) {
    enteredAmount.value = value;
    if (value > 0) {
      final strVal = value.toString();
      selectedValue.value = strVal;
      if (isRupees.value) {
        if (!rupeesOptions.contains(strVal)) rupeesOptions.add(strVal);
      } else {
        if (!gramsOptions.contains(strVal)) gramsOptions.add(strVal);
      }
    }
  }

  /// Select quick value
  void selectValue(String value) {
    selectedValue.value = value;
    enteredAmount.value = int.tryParse(value) ?? 0;

    if (isRupees.value) {
      if (!rupeesOptions.contains(value)) rupeesOptions.add(value);
    } else {
      if (!gramsOptions.contains(value)) gramsOptions.add(value);
    }
  }

  /// Get conversion text
  String getConversion() {
    if (goldRate.value == 0) return "Loading...";
    if (isRupees.value) {
      double gm = enteredAmount.value / goldRate.value;
      return "${gm.toStringAsFixed(3)} g";
    } else {
      double rupees = enteredAmount.value * goldRate.value;
      return "₹${rupees.toStringAsFixed(2)}";
    }
  }

  /// Get amount for API
  int getAmountForApi() {
    if (enteredAmount.value > 0) return enteredAmount.value;
    return int.tryParse(selectedValue.value) ?? 0;
  }

  /// Create Payment API Call
  Future<void> createPayment() async {
    try {
      String? mobile = isOwnNumber.value
          ? StorageService().getMobile()
          : enteredMobile.value.trim();

      if (mobile == null || mobile.isEmpty) {
        Get.snackbar("Error", "Please enter mobile number");
        return;
      }

      if (!RegExp(r'^\d{10}$').hasMatch(mobile)) {
        Get.snackbar("Error", "Mobile number must be 10 digits");
        return;
      }

      double amount = isRupees.value ? enteredAmount.value.toDouble() : 0;
      double gram = isRupees.value ? 0 : enteredAmount.value.toDouble();

      double amountAllocated = amount > 0 ? amount : gram * goldRate.value;
      double gramAllocated = gram > 0 ? gram : amount / goldRate.value;

      var token = await StorageService.getTokenAsync();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var body = json.encode({
        "mobile": mobile,
        "others": isOwnNumber.value ? "" : enteredMobile.value,
        "amount": amount,
        "gram": gram,
        "amount_allocated": amountAllocated,
        "gram_allocated": gramAllocated,
      });

      print("Request Body: $body");

      var response =
          await http.post(Uri.parse(baseUrl), headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        PaymentModel payment = PaymentModel.fromJson(data);

        Get.snackbar("Success", "Payment successfully created!");
        int initialTabIndex = payment.amount == 0 ? 1 : 0;
        Get.offAll(() => InvestmentDetailScreen(initialTabIndex: initialTabIndex));
      } else {
        Get.snackbar("Error", "Failed: ${response.reasonPhrase}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
