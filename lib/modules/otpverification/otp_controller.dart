// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// // class OtpController extends GetxController {
// //   // 4 text controllers and 4 focus nodes for OTP input
// //   final otpControllers = List.generate(4, (_) => TextEditingController());
// //   final focusNodes = List.generate(4, (_) => FocusNode());

// //   void verifyOtp() {
// //     String otp = otpControllers.map((c) => c.text).join();

// //     if (otp.length == 4) {
// //       if (otp == "1234") {
// //         Get.offAllNamed('/dashboard');
// //       } else {
// //         Get.snackbar('Invalid OTP', 'The entered code is incorrect.');
// //       }
// //     } else {
// //       Get.snackbar('Error', 'Please enter a 4-digit OTP');
// //     }
// //   }

// //   void resendCode() {
// //     Get.snackbar("OTP Sent", "A new OTP has been sent to your number.");
// //   }

// //   @override
// //   void onClose() {
// //     for (var controller in otpControllers) {
// //       controller.dispose();
// //     }
// //     for (var node in focusNodes) {
// //       node.dispose();
// //     }
// //     super.onClose();
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class OtpController extends GetxController {
//   final otpControllers = List.generate(4, (_) => TextEditingController());
//   final focusNodes = List.generate(4, (_) => FocusNode());

//   void verifyOtp() {
//     String otp = otpControllers.map((c) => c.text).join();

//     if (otp.length == 4) {
//       Get.snackbar('OTP Entered', 'Your OTP: $otp');
//       if (otp == "1234") {
//         Get.offAllNamed('/dashboard');
//       } else {
//         Get.snackbar('Invalid OTP', 'The entered code is incorrect.');
//       }
//     } else {
//       Get.snackbar('Error', 'Please enter a 4-digit OTP');
//     }
//   }

//   void resendCode() {
//     Get.snackbar("OTP Sent", "A new OTP has been sent to your number.");
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final otpControllers = List.generate(4, (_) => TextEditingController());
  final focusNodes = List.generate(4, (_) => FocusNode());

  // Verify OTP functionality
  void verifyOtp() {
    String otp = otpControllers.map((c) => c.text).join();

    if (otp.length == 4) {
      Get.snackbar('OTP Entered', 'Your OTP: $otp');
      if (otp == "1234") {
        Get.offAllNamed('/dashboard'); // Navigate to the dashboard if OTP is correct
      } else {
        Get.snackbar('Invalid OTP', 'The entered code is incorrect.');
      }
    } else {
      Get.snackbar('Error', 'Please enter a 4-digit OTP');
    }
  }

  // Resend OTP functionality
  void resendCode() {
    Get.snackbar("OTP Sent", "A new OTP has been sent to your number.");
  }

  @override
  void onClose() {
    // Dispose of controllers and focus nodes when the screen is closed
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}

