// lib/app/modules/onboarding/onboarding_binding.dart
import 'package:aesera_jewels/modules/onboard/onboard_controller.dart';
import 'package:get/get.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}
