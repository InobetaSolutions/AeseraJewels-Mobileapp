
import 'package:aesera_jewels/modules/scan_to_pay/scan_to_pay_view.dart';
import 'package:get/get.dart';

class BuyGoldController extends GetxController {
  // Mode selection
  RxBool isRupees = true.obs;

  // Selected amount or grams
  RxString selectedValue = '200'.obs; // Default ₹200

  // Quick select options
  final List<String> rupeesOptions = ['10', '50', '150', '200', '250', '300'];
  final List<String> gramsOptions = ['2', '5', '50', '100', '200'];

  // Handle toggle between Rupees and Grams
  void toggleMode(bool rupeesSelected) {
    isRupees.value = rupeesSelected;
    selectedValue.value = rupeesSelected ? '200' : '2';
  }

  // Quick selection tap
  void selectValue(String value) {
    selectedValue.value = value;
  }

  // Proceed with payment logic → Navigate to ScanToPayScreen
  void makePayment() {
    Get.to(() => ScanToPayScreen());
  }
}
