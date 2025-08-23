// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// // class LoginController extends GetxController {
// //   final mobileController = TextEditingController();

// //   void login() {
// //     String mobile = mobileController.text.trim();
// //     if (mobile.isEmpty) {
// //       Get.snackbar('Error', 'Please enter mobile number');
// //       return;
// //     }

// //     // Navigate to OTP screen
// //     Get.toNamed('/otp', arguments: {'mobile': mobile});
// //   }

// //   @override
// //   void onClose() {
// //     mobileController.dispose();
// //     super.onClose();
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class LoginController extends GetxController {
//   final mobileController = TextEditingController();
//   final RxBool isLoading = false.obs;

//   void login() {
//     String mobile = mobileController.text.trim();

//     if (mobile.isEmpty) {
//       Get.snackbar('Error', 'Please enter mobile number');
//       return;
//     }

//     if (!isValidMobile(mobile)) {
//       Get.snackbar('Invalid', 'Enter a valid 10-digit mobile number');
//       return;
//     }

//     isLoading.value = true;

//     // Simulate a delay or API call
//     Future.delayed(const Duration(seconds: 2), () {
//       isLoading.value = false;
//       Get.toNamed('/otp', arguments: {'mobile': mobile});
//     });
//   }

//   bool isValidMobile(String mobile) {
//     final regex = RegExp(r'^[6-9]\d{9}$'); // Starts with 6-9, total 10 digits
//     return regex.hasMatch(mobile);
//   }

//   @override
//   void onClose() {
//     mobileController.dispose();
//     super.onClose();
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final mobileController = TextEditingController();
  final RxBool isLoading = false.obs;

  /// Validate Indian mobile number (10 digits, starts with 6–9)
  bool isValidMobile(String mobile) {
    return RegExp(r'^[6-9]\d{9}$').hasMatch(mobile);
  }

  /// API-based login that triggers OTP generation
  Future<void> login() async {
    final mobile = mobileController.text.trim();

    if (mobile.isEmpty) {
      Get.snackbar('Error', 'Please enter mobile number');
      return;
    }

    if (!isValidMobile(mobile)) {
      Get.snackbar('Invalid', 'Enter a valid 10-digit mobile number');
      return;
    }

    isLoading.value = true;

    try {
      final url = Uri.parse('http://13.204.96.244:3000/api/user-login');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({"mobile": mobile});

      final request = http.Request('POST', url)
        ..headers.addAll(headers)
        ..body = body;

      final response = await request.send();
      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final data = jsonDecode(responseString);

        final otp = data['otp'];
        final token = data['token'];
        final name = data['name'] ?? 'User'; // fallback name

        if (otp != null && token != null) {
          Get.snackbar("Success", "OTP sent: $otp");

          // Navigate to OTP screen with data
          Get.toNamed('/otp', arguments: {
            'otp': otp,
            'mobile': mobile,
            'name': name,
            'token': token,
            'isNewUser': true,
          });
        } else {
          Get.snackbar("Error", "Invalid response from server.");
        }
      } else {
        Get.snackbar("Error", "Failed: ${response.reasonPhrase}");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  /// Navigate to registration screen
  void register() {
    Get.toNamed('/register');
  }

  @override
  void onClose() {
    mobileController.dispose();
    super.onClose();
  }
}
