import 'package:get/get.dart';
import 'buy_gold_controller.dart';

class BuyGoldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyGoldController>(() => BuyGoldController());
  }
}
