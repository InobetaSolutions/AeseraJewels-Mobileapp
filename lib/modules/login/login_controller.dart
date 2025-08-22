import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final mobileController = TextEditingController();

  void login() {
    String mobile = mobileController.text.trim();
    if (mobile.isEmpty) {
      Get.snackbar('Error', 'Please enter mobile number');
      return;
    }

    // Navigate to OTP screen
    Get.toNamed('/otp', arguments: {'mobile': mobile});
  }

  @override
  void onClose() {
    mobileController.dispose();
    super.onClose();
  }
}