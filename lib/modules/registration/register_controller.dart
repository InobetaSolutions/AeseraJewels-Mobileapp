// // import 'dart:convert';
// // import 'package:aesera_jewels/services/storage_service.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;

// // class RegisterController  extends GetxController {
// //   final nameController = TextEditingController();
// //   final mobileController = TextEditingController();
// //   final isLoading = false.obs;

// //   /// Register API
// //   void register() async {
// //     final name = nameController.text.trim();
// //     final mobile = mobileController.text.trim();

// //     // === Validation ===
// //     if (name.isEmpty || mobile.isEmpty) {
// //       _showSnackBar("Missing Info", "Please fill all fields.");
// //       return;
// //     }

// //     if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(name)) {
// //       _showSnackBar("Invalid Name", "Name should contain only alphabets.");
// //       return;
// //     }

// //     if (!RegExp(r"^[6-9]\d{9}$").hasMatch(mobile)) {
// //       _showSnackBar("Invalid Mobile", "Enter a valid 10-digit Indian mobile number.");
// //       return;
// //     }

// //     isLoading.value = true;

// //     try {
// //       final url = Uri.parse("http://13.204.96.244:3000/api/generate-otp");

// //       final headers = {
// //         'Content-Type': 'application/json',
// //         'Authorization':
// //             'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtb2JpbGUiOiI5ODc2NTQzMjEwIiwibmFtZSI6ImFlc2VyYSBqZXdlbHMiLCJpYXQiOjE3NTU5MzUwMjIsImV4cCI6MTc1NTkzODYyMn0.70lJ0aUJkWuUowmbvS5nL4Wc7m1u6LG8EJ7mxATMf6w'
// //       };

// //       final body = jsonEncode({
// //         "mobile": mobile,
// //         "name": name,
// //       });

// //       final response = await http.post(url, headers: headers, body: body);
// //       isLoading.value = false;

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);

// //         final otp = data['otp'];
// //         final token = data['token'];

// //         if (otp != null && token != null) {
// //           // ✅ Show OTP on Top Snackbar
// //           _showSnackBar("OTP Sent", "Your OTP is $otp");

// //           // ✅ Navigate to OTP Screen with arguments
// //           // Get.toNamed('/otp', arguments: {
// //           //   'otp': otp,
// //           //   'mobile': mobile,
// //           //   'name': name,
// //           //   'token': token,
// //           //   'isNewUser': true,
// //           // });
// //           StorageService.saveLogin(token, mobile, name);
// // Get.offAllNamed('/dashboard');

// //         } else {
// //           _showSnackBar("Error", "Invalid response from server.");
// //         }
// //       } else {
// //         _showSnackBar("Error", "Failed: ${response.reasonPhrase}");
// //       }
// //     } catch (e) {
// //       isLoading.value = false;
// //       _showSnackBar("Error", "Something went wrong: $e");
// //     }
// //   }

// //   /// Custom Snackbar
// //   void _showSnackBar(String title, String message) {
// //     Get.snackbar(
// //       title,
// //       message,
// //       snackPosition: SnackPosition.TOP,
// //       backgroundColor: const Color(0xFF09243D),
// //       colorText: Colors.white,
// //       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// //       borderRadius: 12,
// //       snackStyle: SnackStyle.FLOATING,
// //       maxWidth: 350,
// //       duration: const Duration(seconds: 3),
// //       titleText: Text(
// //         title,
// //         style: const TextStyle(
// //           fontSize: 18,
// //           fontWeight: FontWeight.bold,
// //           color: Colors.white,
// //         ),
// //       ),
// //       messageText: Text(
// //         message,
// //         style: const TextStyle(
// //           fontSize: 16,
// //           color: Colors.white,
// //         ),
// //       ),
// //     );
// //   }

// //   /// Navigate to Login
// //   void login() {
// //     Get.toNamed('/login');
// //   }

// //   @override
// //   void onClose() {
// //     nameController.dispose();
// //     mobileController.dispose();
// //     //super.onClose();
// //   }
// // }
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
      _showSnackBar("Missing Info", "Please fill all fields.");
      return;
    }
    if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(name)) {
      _showSnackBar("Invalid Name", "Name should contain only alphabets.");
      return;
    }
    if (!RegExp(r"^[6-9]\d{9}$").hasMatch(mobile)) {
      _showSnackBar("Invalid Mobile", "Enter a valid 10-digit mobile number.");
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
          _showSnackBar("OTP Sent", "Check your SMS (OTP: $otp)");
           _showSnackBar("OTP Sent", "Check your SMS (OTP: $resendotp)");
          

          Get.toNamed('/otp', arguments: {
            "otp": otp,
            "resendotp": resendotp,
            "name": name,
            "mobile": mobile,
            "token": token,
            "isNewUser": true,
          });
        } else {
          _showSnackBar("Error", "Invalid response from server.");
        }
      } else {
        _showSnackBar("Error", "Failed: ${response.reasonPhrase}");
      }
    } catch (e) {
      isLoading.value = false;
      _showSnackBar("Error", "Something went wrong: $e");
    }
  }

  void _showSnackBar(String title, String message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white);
  }

  void login() => Get.toNamed('/login');

  @override
  void onClose() {
    nameController.dispose();
    mobileController.dispose();
    super.onClose();
  }
}
