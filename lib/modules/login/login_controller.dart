
// import 'dart:convert';
// import 'package:aesera_jewels/services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class LoginController extends GetxController
//  {
//   final mobileController = TextEditingController();
//   final otpController = TextEditingController();
//   //final CacheService _cacheService = CacheService();
//   final RxBool isLoading = false.obs;

//   /// Validate Indian mobile number (10 digits, starts with 6–9)
//   bool isValidMobile(String mobile) {
//     return RegExp(r'^[6-9]\d{9}$').hasMatch(mobile);
//   }

//   /// API-based login that triggers OTP generation
//   Future<void> login() async {
//     final mobile = mobileController.text.trim();

//     if (mobile.isEmpty || mobile.length != 10) {
//       Get.snackbar('Error', 'Please enter valid mobile number');
//       return;
//     }

//     if (!isValidMobile(mobile)) {
//       Get.snackbar('Invalid', 'Enter a valid 10-digit mobile number');
//       return;
//     }

//     isLoading.value = true;

//     try {
//       final url = Uri.parse('http://13.204.96.244:3000/api/user-login');
//       final headers = {'Content-Type': 'application/json'};
//       final body = jsonEncode({"mobile": mobile});

//       final request = http.Request('POST', url)
//         ..headers.addAll(headers)
//         ..body = body;

//       final response = await request.send();
//       isLoading.value = false;

//       if (response.statusCode == 200) {
//         final responseString = await response.stream.bytesToString();
//         final data = jsonDecode(responseString);

//         final otp = data['otp'];
//         final token = data['token'];
//         final name = data['name'] ?? 'User'; // fallback name

//         if (otp != null && token != null) {
//           Get.snackbar("Success", "OTP sent: $otp");
//    print("OTP: $otp");
//           _showSnackBar("OTP Sent", "Check your SMS (OTP: $otp)");
//            _showSnackBar("OTP Sent", "Check your SMS (OTP: $resendotp)");
          

//           Get.toNamed('/otp', arguments: {
//             "otp": otp,
//             "resendotp": resendotp,
//             "name": name,
//             "mobile": mobile,
//             "token": token,
//             "isNewUser": true,
//           });

//           Navigate to OTP screen with data
//           Get.toNamed('/otp', arguments: {
//             'otp': otp,
//             'mobile': mobile,
//             'name': name,
//             'token': token,
//             'isNewUser': true,
//           });
//           StorageService.saveLogin(token, mobile, name);
// Get.offAllNamed('/dashboard');

//         } else {
//           Get.snackbar("Error", "Invalid response from server.");
//         }
//       } else {
//         Get.snackbar("Error", "Failed: ${response.reasonPhrase}");
//       }
//     } catch (e) {
//       isLoading.value = false;
//       Get.snackbar("Error", "Something went wrong: $e");
//     }
//   }

// /// Navigate to registration screen
// // Add navigation logic here if needed, e.g.:
// // Get.toNamed('/register');

//   @override
//   void onClose() {
//     mobileController.dispose();
//   otpController.dispose();
//    super.onClose();
//   }
// }
import 'dart:convert';
import 'package:aesera_jewels/modules/auth_controller.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final mobileController = TextEditingController();
  final otpController = TextEditingController();
  final RxBool isLoading = false.obs;

  final authController = Get.put(AuthController());

  /// Validate Indian mobile number (10 digits, starts with 6–9)
  bool isValidMobile(String mobile) {
    return RegExp(r'^[6-9]\d{9}$').hasMatch(mobile);
  }

  /// API-based login that triggers OTP generation
  Future<void> login() async {
    final mobile = mobileController.text.trim();

    if (mobile.isEmpty || mobile.length != 10) {
      Get.snackbar('Error', 'Please enter a valid mobile number');
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
       
        if (otp != null && token != null) {
          // Show OTP for debugging (remove in production)
         // Get.snackbar("Success", "OTP sent successfully: $otp");
          print("OTP: $otp");

          // ✅ Navigate to OTP screen with arguments
          Get.toNamed('/otp', arguments: {
            "otp": otp,
            "mobile": mobile,
            "token": token,
            "isNewUser": false,
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
 void register() => Get.toNamed('/register');
  @override
  void onClose() {
    mobileController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
