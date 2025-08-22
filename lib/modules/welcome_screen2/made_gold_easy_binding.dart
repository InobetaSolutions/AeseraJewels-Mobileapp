
import 'package:aesera_jewels/modules/welcome_screen2/made_gold_easy_controller.dart';
import 'package:get/get.dart';

class MadeGoldEasyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MadeGoldEasyController>(() => MadeGoldEasyController());
  }
}
