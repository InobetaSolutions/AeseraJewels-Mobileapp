
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final isLoading = false.obs;

  void register() async {
    final name = nameController.text.trim();
    final mobile = mobileController.text.trim();

    if (name.isEmpty || mobile.isEmpty) {
      _showSnackBar("Missing Info", "Please fill all fields.", backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
      return;
    }
    if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(name)) {
      _showSnackBar("Invalid Name", "Name should contain only alphabets.", backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
      return;
    }
    if (!RegExp(r"^[6-9]\d{9}$").hasMatch(mobile)) {
      _showSnackBar("Invalid Mobile", "Enter a valid 10-digit mobile number.", backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      final url = Uri.parse("http://13.204.96.244:3000/api/generate-otp");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name, "mobile": mobile}),
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

      

        final otp = data['otp'];
        final resendotp = data['resendotp'];
        final token = data['token'];

        if (otp != null && token != null) {
          print("OTP: $otp");
         // _showSnackBar("OTP Sent", "Check your SMS (OTP: $otp)");
         // _showSnackBar("OTP Sent", "Check your SMS (OTP: $resendotp)");
            //_showSnackBar("OTP Sent", "Check your SMS (OTP:)");

          Get.offNamed('/otp', arguments: {
            "otp": otp,
            "resendotp": resendotp,
            "name": name,
            "mobile": mobile,
            "token": token,
            "isNewUser": true,
          });
        } else {
          _showSnackBar("Error", "Invalid response from server.", backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
        }
      } else {
        // _showSnackBar("Error", "Failed: ${response.reasonPhrase}");
         _showSnackBar(
            "User Already Registered",
            "This mobile number is already registered. Please login with this number.", backgroundColor: const Color(0xFF09243D), colorText: Colors.white
          );


      }
    } catch (e) {
      isLoading.value = false;
      _showSnackBar("Error",  " please check your internet connection",
          backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
    }
  }

  void _showSnackBar(String title, String message, {required Color backgroundColor, required Color colorText}) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white);
  }

  void login() => Get.offAllNamed('/login');

  @override
  void onClose() {
    nameController.dispose();
    mobileController.dispose();
    super.onClose();
  }
}

