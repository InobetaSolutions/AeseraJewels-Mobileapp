import 'package:get/get.dart';

class JewelsForOccasionController extends GetxController {
 void onSkip() {
    Get.offAllNamed('/login'); // Navigate directly to Register
  }

  void goTologin() {
    Get.toNamed('/login'); // Navigate to Register
  }
} 