import 'package:get/get.dart';

class SeamlessPaymentController extends GetxController {
  void onSkip() {
    Get.offAllNamed('/register'); // Navigate to Dashboard
  }

  void onForward() {
    Get.toNamed('/madeGoldEasy'); // Navigate to MadeGoldEasy
  }
}
