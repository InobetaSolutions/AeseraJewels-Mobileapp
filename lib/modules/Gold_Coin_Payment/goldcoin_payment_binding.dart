import 'package:aesera_jewels/modules/Gold_Coin/goldcoin_controller.dart';
import 'package:aesera_jewels/modules/Gold_Coin_Payment/goldcoin_payment_controller.dart';
import 'package:get/get.dart';

class GoldCoinPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoldCoinPaymentController>(() => GoldCoinPaymentController());
  }
}
