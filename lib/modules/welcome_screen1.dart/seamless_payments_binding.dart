
import 'package:aesera_jewels/modules/welcome_screen1.dart/seamless_payments_controller.dart';
import 'package:get/get.dart';

class SeamlessPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeamlessPaymentController>(() => SeamlessPaymentController());
  }
}
