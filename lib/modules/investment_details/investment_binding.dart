
import 'package:aesera_jewels/modules/investment_details/investment_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class InvestmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvestmentController>(() => InvestmentController());
  }
}
