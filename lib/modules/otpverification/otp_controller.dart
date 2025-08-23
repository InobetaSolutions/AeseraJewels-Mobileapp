// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class OtpController extends GetxController {
//   final otpControllers = List.generate(4, (_) => TextEditingController());
//   final focusNodes = List.generate(4, (_) => FocusNode());
//   final isLoading = false.obs;
//   bool lastVerifySuccess = false;

//   // Values received from previous screen
//   final mobile = ''.obs;
//   final token = ''.obs;
//   final isNewUser = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     final args = Get.arguments;
//     mobile.value = args['mobile'] ?? '';
//     token.value = args['token'] ?? '';
//     isNewUser.value = args['isNewUser'] ?? false;
//   }

//   void verifyOtp() async {
//     final enteredOtp = otpControllers.map((c) => c.text).join();

//     if (enteredOtp.length != 4) {
//       Get.snackbar('Invalid OTP', 'Please enter the 4-digit OTP.');
//       return;
//     }

//     isLoading.value = true;

//     try {
//       final url = Uri.parse('http://13.204.96.244:3000/api/verify-otp');
//       final headers = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer ${token.value}'
//       };

//       final request = http.Request('POST', url);
//       request.body = json.encode({"mobile": mobile.value, "otp": enteredOtp});
//       request.headers.addAll(headers);

//       final response = await request.send();
//       final responseBody = await response.stream.bytesToString();
//       isLoading.value = false;

//       if (response.statusCode == 200) {
//         final data = jsonDecode(responseBody);

//         if (data["message"] == "Sign in successful" || data["message"] == "OTP Verified Successfully") {
//           lastVerifySuccess = true;
//           Get.snackbar('Success', 'OTP verified successfully');

//           // Navigate to home/dashboard
//           Get.offAllNamed('/dashboard');
//         } else {
//           lastVerifySuccess = false;
//           Get.snackbar('Error', data["message"] ?? 'Invalid OTP');
//         }
//       } else {
//         lastVerifySuccess = false;
//         Get.snackbar('Error', response.reasonPhrase ?? 'Server error');
//       }
//     } catch (e) {
//       isLoading.value = false;
//       lastVerifySuccess = false;
//       Get.snackbar('Error', 'Something went wrong: $e');
//     }
//   }

//   void resendCode() {
//     // Placeholder – you can integrate resend OTP API here
//     Get.snackbar("Resend OTP", "A new OTP has been sent to your number.");
//   }

//   @override
//   void onClose() {
//     for (var controller in otpControllers) {
//       controller.dispose();
//     }
//     for (var node in focusNodes) {
//       node.dispose();
//     }
//     super.onClose();
//   }
// }

import 'package:aesera_jewels/Api/base_url.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OtpController extends GetxController {
  final otpControllers = List.generate(4, (_) => TextEditingController());
  final focusNodes = List.generate(4, (_) => FocusNode());
  final isLoading = false.obs;

  final mobile = ''.obs;
  final token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    mobile.value = args['mobile'] ?? '';
    token.value = args['token'] ?? '';
  }

  String get enteredOtp => otpControllers.map((c) => c.text).join();

  void verifyOtp() async {
    if (enteredOtp.length != 4) {
      Get.snackbar('Invalid OTP', 'Please enter the 4-digit OTP.');
      return;
    }

    isLoading.value = true;

    try {
      final url = Uri.parse('${BaseUrl.baseUrl}verify-otp');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token.value}',
      };

      final body = json.encode({"mobile": mobile.value, "otp": enteredOtp});

      final response = await http.post(url, headers: headers, body: body);
      isLoading.value = false;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['message'].toString().toLowerCase().contains('success')) {
          Get.snackbar('Success', 'OTP verified successfully');
          Get.offAllNamed('/dashboard');
        } else {
          Get.snackbar('Error', data['message'] ?? 'Invalid OTP');
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.reasonPhrase}');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  void resendCode() {
    // Optionally call resend API
    Get.snackbar("Resend OTP", "A new OTP has been sent to your number.");
  }

  @override
  void onClose() {
    for (var c in otpControllers) {
      c.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}
