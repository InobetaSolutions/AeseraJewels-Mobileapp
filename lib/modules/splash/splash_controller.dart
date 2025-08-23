import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    // Navigate to SeamlessPayment screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed('/seamless_payments');
    });
  }
}
