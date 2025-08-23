// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// // class RegisterController extends GetxController {
// //   final nameController = TextEditingController();
// //   final mobileController = TextEditingController();
// //   final aadharController = TextEditingController();

// //   void register() {
// //     // Add validation or API call here
// //     Get.toNamed('/otp');
// //   }

// //   void login() {
// //     Get.toNamed('/login');
// //   }

// //   @override
// //   void onClose() {
// //     nameController.dispose();
// //     mobileController.dispose();
// //     aadharController.dispose();
// //     super.onClose();
// //   }
// // }
// import 'dart:convert';
// import 'package:aesera_jewels/Api/base_url.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class RegisterController extends GetxController {
//   final nameController = TextEditingController();
//   final mobileController = TextEditingController();
//   final aadharController = TextEditingController();

//   var isLoading = false.obs;

//   void register() async {
//     String name = nameController.text.trim();
//     String mobile = mobileController.text.trim();
//     String aadhar = aadharController.text.trim();

//     if (name.isEmpty || mobile.isEmpty || aadhar.isEmpty) {
//       Get.snackbar("Missing Info", "Please fill all fields.");
//       return;
//     }

//     isLoading.value = true;

//     try {
//       var headers = {
//         'Content-Type': 'application/json',
//         'Authorization':
//             'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtb2JpbGUiOiI5ODc2NTQzMjEwIiwibmFtZSI6ImFlc2VyYSBqZXdlbHMiLCJpYXQiOjE3NTU5MzUwMjIsImV4cCI6MTc1NTkzODYyMn0.70lJ0aUJkWuUowmbvS5nL4Wc7m1u6LG8EJ7mxATMf6w'
//       };

//       var body = jsonEncode({
//         "mobile": mobile,
//         "name": name,
//       });

//       var url = Uri.parse('${BaseUrl.baseUrl}generate-otp');
//       var response = await http.post(url, headers: headers, body: body);

//       isLoading.value = false;

//       if (response.statusCode == 200) {
//         var responseBody = json.decode(response.body);

//         // Assuming response has `token`
//         String token = responseBody['token'] ?? "";

//         if (token.isNotEmpty) {
//           Get.toNamed('/otp', arguments: {
//             'mobile': mobile,
//             'name': name,
//             'token': token,
//           });
//         } else {
//           Get.snackbar("Error", "Token missing in response.");
//         }
//       } else {
//         Get.snackbar("Error", "Failed to generate OTP. ${response.reasonPhrase}");
//       }
//     } catch (e) {
//       isLoading.value = false;
//       Get.snackbar("Error", "Something went wrong. ${e.toString()}");
//     }
//   }

//   void login() {
//     Get.toNamed('/login');
//   }

//   @override
//   void onClose() {
//     nameController.dispose();
//     mobileController.dispose();
//     aadharController.dispose();
//     super.onClose();
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final aadharController = TextEditingController();

  final isLoading = false.obs;

  /// Method to trigger registration
  void register() async {
    final name = nameController.text.trim();
    final mobile = mobileController.text.trim();
    final aadhar = aadharController.text.trim();

    // === Input Validation ===
    if (name.isEmpty || mobile.isEmpty || aadhar.isEmpty) {
      Get.snackbar("Missing Info", "Please fill all fields.");
      return;
    }

    if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(name)) {
      Get.snackbar("Invalid Name", "Name should contain only alphabets.");
      return;
    }

    if (!RegExp(r"^[6-9]\d{9}$").hasMatch(mobile)) {
      Get.snackbar("Invalid Mobile", "Enter a valid 10-digit Indian mobile number.");
      return;
    }

    if (!RegExp(r"^\d{12}$").hasMatch(aadhar)) {
      Get.snackbar("Invalid Aadhar", "Aadhar must be exactly 12 digits.");
      return;
    }

    isLoading.value = true;

    try {
      final url = Uri.parse('http://13.204.96.244:3000/api/generate-otp');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtb2JpbGUiOiI5ODc2NTQzMjEwIiwibmFtZSI6ImFlc2VyYSBqZXdlbHMiLCJpYXQiOjE3NTU5MzUwMjIsImV4cCI6MTc1NTkzODYyMn0.70lJ0aUJkWuUowmbvS5nL4Wc7m1u6LG8EJ7mxATMf6w'
      };

      final body = jsonEncode({
        "mobile": mobile,
        "name": name,
      });

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
          Get.snackbar("Success", "OTP sent: $otp");

          // Navigate to OTP screen
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

  /// Navigate to login screen
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
