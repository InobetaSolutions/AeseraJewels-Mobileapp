import 'dart:convert';
import 'package:aesera_jewels/Api/base_url.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OtpController extends GetxController {
  /// 4 controllers & focus nodes for OTP fields
  final otpControllers = List.generate(4, (_) => TextEditingController());
  final focusNodes = List.generate(4, (_) => FocusNode());

  final isLoading = false.obs;
  final otp = ''.obs; // OTP from API (debug)
  final mobile = ''.obs; // user mobile
  final token = ''.obs; // token from API
  final name = ''.obs; // user name
  var isNewUser = false; // flag for new user
  bool lastVerifySuccess = false;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args != null) {
      otp.value = args['otp']?.toString() ?? '';
      mobile.value = args['mobile']?.toString() ?? '';
      token.value = args['token']?.toString() ?? '';
      name.value = args['name']?.toString() ?? '';
      isNewUser = args['isNewUser'] ?? false;
    }

    /// Auto-move focus forward & backward
    for (int i = 0; i < otpControllers.length; i++) {
      otpControllers[i].addListener(() {
        if (otpControllers[i].text.length == 1 &&
            i < otpControllers.length - 1) {
          focusNodes[i + 1].requestFocus();
        } else if (otpControllers[i].text.isEmpty && i > 0) {
          focusNodes[i - 1].requestFocus();
        }
      });
    }
  }

  /// Collect entered OTP
  String get enteredOtp => otpControllers.map((c) => c.text).join();

  /// ✅ Verify OTP API
  Future<void> verifyOtp() async {
    if (enteredOtp.length != 4) {
      Get.snackbar('Invalid OTP', 'Please enter the 4-digit OTP.');
      return;
    }

    isLoading.value = true;
    try {
      final url = Uri.parse("${BaseUrl.baseUrl}verify-otp");
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token.value}",
        },
        body: jsonEncode({"mobile": mobile.value, "otp": enteredOtp}),
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        lastVerifySuccess = true;

        /// Save user details in local storage
        final userId = data['data']['_id']?.toString() ?? '';
        final userName = data['data']['name']?.toString() ?? '';
        final userToken = data['data']['token']?.toString() ?? '';

        await StorageService().saveUser(
          userName,
          userToken,
          mobile.value,
          userId,
        );
        print("Stored token: $userToken, ID: $userToken");

      // Get.snackbar('Success', 'OTP verified successfully');

        /// Navigate based on user type
        if (isNewUser) {
          Get.offAllNamed('/dashboard'); // or fingerprint screen if needed
        } else {
          Get.offAllNamed('/dashboard');
        }
      } else {
        lastVerifySuccess = false;
        Get.snackbar('Error', 'Invalid OTP');
      }
    } catch (e) {
      isLoading.value = false;
      lastVerifySuccess = false;
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  /// ✅ Resend OTP API
  Future<void> resendOtp() async {
    try {
      final url = Uri.parse("${BaseUrl.baseUrl}resendOtp");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"mobile": mobile.value}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        otp.value = data['otp']?.toString() ?? '';
        Get.snackbar('OTP Resent', 'A new OTP has been sent to your number',
            backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
            
      } else {
        Get.snackbar('Error', 'Failed to resend OTP');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
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
