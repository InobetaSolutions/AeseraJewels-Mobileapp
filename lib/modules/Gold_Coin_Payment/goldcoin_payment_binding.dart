import 'package:aesera_jewels/models/goldcoin_payment_model.dart';
import 'package:aesera_jewels/modules/Gold_Coin_Payment/goldcoin_payment_controller.dart';
import 'package:get/get.dart';

class GoldCoinPaymentBinding extends Bindings {
  GoldCoinPaymentBinding(GoldCoinPaymentModel model, Type goldCoinPaymentModel);

  @override
  void dependencies() {
    final GoldCoinPaymentModel model = Get.arguments as GoldCoinPaymentModel;
    Get.put(GoldCoinPaymentController(model));
  }
}
