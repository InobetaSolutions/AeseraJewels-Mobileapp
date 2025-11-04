import 'package:aesera_jewels/modules/Gold_Coin/goldcoin_controller.dart';
import 'package:get/get.dart';

class GoldCoinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoldCoinController>(() => GoldCoinController());
  }
}
