import 'package:get/get.dart';
import 'scan_to_pay_controller.dart';

class ScanToPayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanToPayController>(() => ScanToPayController());
  }
}
