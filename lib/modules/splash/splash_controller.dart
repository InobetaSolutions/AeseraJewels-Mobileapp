import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Initialization code here

    Future.delayed(const Duration(seconds: 3), () {
      // Get.offNamed('/otp');
      Get.offNamed('/onboard');
    });
  }

  @override
  void onReady() {
    super.onReady();
    // Code to execute when the controller is ready
  }

  @override
  void onClose() {
    // Cleanup code here
    super.onClose();
  }
}
