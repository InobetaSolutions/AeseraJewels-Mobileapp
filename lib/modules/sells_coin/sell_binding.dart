import 'package:aesera_jewels/modules/sells_coin/sellcoin_Controller.dart';
import 'package:get/get.dart';

class SellBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SellcoinController());
  }
}
