

import 'dart:async';

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
  final isResendAvailable = true.obs; // For enabling/disabling resend
  final resendCountdown = 0.obs; // Countdown timer display

  Timer? _timer; // Add this line to define the _timer variable

  final mobile = ''.obs;
  final token = ''.obs;

  @override
  void onInit() {
    // super.onInit(); // Removed due to superclass not defining onInit
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
        print(  response.body);
        Get.snackbar('Error', 'Server error: ${response.reasonPhrase}');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  void resendCode() {
     if (!isResendAvailable.value) return;
    Get.snackbar("Resend OTP", "A new OTP has been sent to your number.");
     isResendAvailable.value = false;
    resendCountdown.value = 30;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
      } else {
        timer.cancel();
        isResendAvailable.value = true;
      }
    });
  }

  @override
  void onClose() {
    for (var c in otpControllers) {
      c.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
  }
}

