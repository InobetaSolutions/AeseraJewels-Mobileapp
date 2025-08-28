import 'package:get/get.dart';

class MadeGoldEasyController extends GetxController {
  void skip() {
    Get.offAllNamed('/login'); // Navigate directly to Register
  }

  void goToJewelsForOccasion() {
    Get.offAllNamed('/jewels_for_occasion'); // Navigate after last onboarding
  }
}
