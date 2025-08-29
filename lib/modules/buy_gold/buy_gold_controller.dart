




import 'package:get/get.dart';
class BuyGoldController extends GetxController {
  /// Mode: true = Rupees, false = Grams
  RxBool isRupees = true.obs;

  /// Selected quick option
  RxString selectedValue = '200'.obs;

  /// Entered custom value
  RxDouble enteredAmount = 0.0.obs;

  /// Options
  final List<String> rupeesOptions = ['10', '50', '150', '200', '250', '300'];
  final List<String> gramsOptions = ['2', '5', '50', '100', '200'];

  /// Toggle between Rupees and Grams
  void toggleMode(bool rupeesSelected) {
    isRupees.value = rupeesSelected;
    selectedValue.value = rupeesSelected ? '200' : '2';
    enteredAmount.value = 0.0;
  }

  /// Quick Select
  void selectValue(String value) {
    selectedValue.value = value;
    enteredAmount.value = 0.0;
  }

  /// Prepare payment data
  Map<String, dynamic> getPaymentData() {
    String amountToPass = isRupees.value
        ? "₹${selectedValue.value}"
        : "${selectedValue.value} gm";

    if (enteredAmount.value > 0) {
      amountToPass = isRupees.value
          ? "₹${enteredAmount.value}"
          : "${enteredAmount.value} gm";
    }

    return {
      "amount": amountToPass,
      "source": "buy_gold",
    };
  }
}
