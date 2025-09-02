import 'package:aesera_jewels/modules/payment/payment_controller.dart';
import 'package:get/get.dart';

class Payment_Binding  extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<Payment_Controller>(() => Payment_Controller());
  }
}