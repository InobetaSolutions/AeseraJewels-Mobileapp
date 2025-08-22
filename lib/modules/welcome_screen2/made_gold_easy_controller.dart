import 'package:get/get.dart';

class MadeGoldEasyController extends GetxController {
  void skipRegister() {
    Get.offAllNamed('/register'); // Navigate directly to Register
  }

  void goToJewelsForOccasion() {
    Get.offAllNamed('/JewelsForOccasion'); // Navigate after last onboarding
  }
}
