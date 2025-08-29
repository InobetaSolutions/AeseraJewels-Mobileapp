import 'package:aesera_jewels/modules/buy_gold/buy_gold_controller.dart';
import 'package:get/get.dart';

class BuyGoldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyGoldController>(() => BuyGoldController());
  }
}
