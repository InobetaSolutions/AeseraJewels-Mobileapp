// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';

// class OnboardingController extends GetxController {
//   var currentPage = 0.obs;

//   final PageController pageController = PageController();

//   /// Update current page index
//   void onPageChanged(int index) {
//     currentPage.value = index;
//   }
//  ElevatedButton(
//                     onPressed: () {
//                       Get.to(() => const RegisterScreen());
//                     },
//   /// Forward button pressed
//   void goToNextPage() {
//     if (currentPage.value < 2) {
//       pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     } else {
//       Get.offAllNamed('/login');
//     }
//   }
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthController extends GetxController {
//   var userName = "".obs;

//   /// Save user data
//   Future<void> registerUser(String name) async {
//     userName.value = name;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool("isLoggedIn", true);
//     await prefs.setString("userName", name);
//   }

//   /// Load saved user data
//   Future<void> loadUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     userName.value = prefs.getString("userName") ?? "";
//   }

//   /// Logout user
//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     userName.value = "";
//   }
// }

//   /// Skip button pressed
//   void skipOnboarding() {
//     Get.offAllNamed('/login');
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  final PageController pageController = PageController();

  void onPageChanged(int index) {
    currentPage.value = index;
  }

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

  void skipOnboarding() {
    Get.offAllNamed('/login');
  }
}
