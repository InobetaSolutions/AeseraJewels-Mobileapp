import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
import 'package:aesera_jewels/modules/onboard/onboard_view.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  /// Check login status and navigate
  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2)); // splash delay

    final prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString("userId"); // ✅ check userId
    final bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    print("Splash → UserId: $userId, LoggedIn: $isLoggedIn");

    if (userId != null && userId.isNotEmpty && isLoggedIn) {
      // ✅ User already registered → Go Dashboard
      Get.offAllNamed('/dashboard');
    } else {
      // ❌ Not registered → Go Onboarding
      Get.offAllNamed('/onboard');
    }
  }

  @override
  void onReady() {
    super.onReady();
    // Extra logic if needed after ready
  }

  @override
  void onClose() {
    // Cleanup if needed
    super.onClose();
  }
}
