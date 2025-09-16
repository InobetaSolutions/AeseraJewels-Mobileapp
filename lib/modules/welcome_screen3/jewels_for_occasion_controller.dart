// import 'package:get/get.dart';

// class JewelsForOccasionController extends GetxController {
//  void onSkip() {
//     Get.offAllNamed('/login'); // Navigate directly to Register
//   }

//   void goTologin() {
//     Get.toNamed('/login'); // Navigate to Register
//   }
// } 
import 'package:get/get.dart';

enum UPIStatus { selectApp, waiting, success, failed }

class UPIPaymentController extends GetxController {
  final Rx<UPIStatus> status = UPIStatus.selectApp.obs;

  void selectApp(String app) {
    status.value = UPIStatus.waiting;
    Future.delayed(const Duration(seconds: 3), () {
      // Mock success/failure
      status.value = UPIStatus.success;
      // status.value = UPIStatus.failed;
    });
  }
}
