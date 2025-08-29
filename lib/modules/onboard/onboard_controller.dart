import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;

  final PageController pageController = PageController();

  /// Update current page index
  void onPageChanged(int index) {
    currentPage.value = index;
  }

  /// Forward button pressed
  void goToNextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAllNamed('/login');
    }
  }

  /// Skip button pressed
  void skipOnboarding() {
    Get.offAllNamed('/login');
  }
}
