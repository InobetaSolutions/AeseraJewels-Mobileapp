import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final aadharController = TextEditingController();

  void register() {
    // Add validation or API call here
    Get.toNamed('/otp');
  }

  void login() {
    Get.toNamed('/login');
  }

  @override
  void onClose() {
    nameController.dispose();
    mobileController.dispose();
    aadharController.dispose();
    super.onClose();
  }
}
