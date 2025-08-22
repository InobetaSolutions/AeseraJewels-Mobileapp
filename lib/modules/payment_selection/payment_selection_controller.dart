// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class PaymentController extends GetxController {
//   RxString mobileNumber = ''.obs;
//   RxString amountPaid = ''.obs;
//   XFile? screenshot;

//   final ImagePicker picker = ImagePicker();

//   // Function to pick a screenshot
//   Future<void> pickScreenshot() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       screenshot = pickedFile;
//       update();
//     }
//   }

//   // Function to clear the form
//   void clearForm() {
//     mobileNumber.value = '';
//     amountPaid.value = '';
//     screenshot = null;
//     update();
//   }

//   // Function to submit payment
//   void submitPayment() {
//     // Placeholder for payment logic
//     Get.snackbar('Payment Completed', 'Payment has been successfully completed');
//   }
// }

// mixin ImageSource {
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PaymentController extends GetxController with GetSingleTickerProviderStateMixin {
  // Reactive variables for form input
  RxString mobileNumber = ''.obs;
  RxString amountPaid = ''.obs;

  // Screenshot picked from gallery
  Rx<XFile?> screenshot = Rx<XFile?>(null);

  // Tab management for "Own Number" and "Others Number"
  late TabController tabController;

  // Image picker instance
  final ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  // Function to pick screenshot
  Future<void> pickScreenshot() async {
    try {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        screenshot.value = pickedFile;
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
    }
  }

  // Function to clear form inputs
  void clearForm() {
    mobileNumber.value = '';
    amountPaid.value = '';
    screenshot.value = null;
  }

  // Simulated payment submission
  void submitPayment() {
    if (tabController.index == 1 && mobileNumber.value.trim().isEmpty) {
      Get.snackbar("Error", "Mobile number is required for 'Others Number'");
      return;
    }

    if (amountPaid.value.trim().isEmpty) {
      Get.snackbar("Error", "Please enter the amount paid.");
      return;
    }

    // Simulate a successful payment
    Get.snackbar("Success", "Payment has been successfully completed");
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
