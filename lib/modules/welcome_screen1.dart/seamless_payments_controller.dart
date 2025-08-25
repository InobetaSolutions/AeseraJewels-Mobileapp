import 'package:get/get.dart';

class SeamlessPaymentController extends GetxController {
  void onSkip() {
    //Get.offAllNamed('/register'); 
    Get.offAllNamed('/dashboard');
  }

  void onForward() {
    Get.toNamed('/made_gold_easy'); // Navigate to MadeGoldEasy
  }
}
