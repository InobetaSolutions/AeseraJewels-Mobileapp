// import 'package:get/get.dart';

// class SeamlessPaymentController extends GetxController {
//   void onSkip() {
//     Get.offAllNamed('/login'); 
//     //Get.offAllNamed('/dashboard');
//   }

//   void onForward() {
//     Get.toNamed('/made_gold_easy'); // Navigate to MadeGoldEasy
//   }
// }
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SeamlessPaymentController extends GetxController {
  final PageController pageController = PageController();
  var currentPage = 0.obs;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void onSkip() {
    Get.offAllNamed('/login');
  }

  void onForward() {
    Get.toNamed('/made_gold_easy');
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
