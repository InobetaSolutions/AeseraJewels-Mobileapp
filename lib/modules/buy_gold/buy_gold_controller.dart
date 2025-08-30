




// import 'package:get/get.dart';
// class BuyGoldController extends GetxController {
//   /// Mode: true = Rupees, false = Grams
//   RxBool isRupees = true.obs;

//   /// Selected quick option
//   RxString selectedValue = '200'.obs;

//   /// Entered custom value
//   RxDouble enteredAmount = 0.0.obs;

//   /// Options
//   final List<String> rupeesOptions = ['10', '50', '150', '200', '250', '300'];
//   final List<String> gramsOptions = ['2', '5', '50', '100', '200'];

//   /// Toggle between Rupees and Grams
//   void toggleMode(bool rupeesSelected) {
//     isRupees.value = rupeesSelected;
//     selectedValue.value = rupeesSelected ? '200' : '2';
//     enteredAmount.value = 0.0;
//   }

//   /// Quick Select
//   void selectValue(String value) {
//     selectedValue.value = value;
//     enteredAmount.value = 0.0;
//   }

//   /// Prepare payment data
//   Map<String, dynamic> getPaymentData() {
//     String amountToPass = isRupees.value
//         ? "₹${selectedValue.value}"
//         : "${selectedValue.value} gm";

//     if (enteredAmount.value > 0) {
//       amountToPass = isRupees.value
//           ? "₹${enteredAmount.value}"
//           : "${enteredAmount.value} gm";
//     }

//     return {
//       "amount": amountToPass,
//       "source": "buy_gold",
//     };
//   }
// }
import 'package:get/get.dart';

class BuyGoldController extends GetxController {
  /// Mode: true = Rupees, false = Grams
  RxBool isRupees = true.obs;

  /// Selected quick option (string)
  RxString selectedValue = ''.obs;

  /// Entered custom value
  RxInt enteredAmount = 0.obs;

  /// Options list
  RxList<String> rupeesOptions = <String>['100', '150', '200', '250', '300'].obs;
  RxList<String> gramsOptions = <String>['2', '5', '50', '100', '200'].obs;

  /// Toggle between Rupees and Grams
  void toggleMode(bool rupeesSelected) {
    isRupees.value = rupeesSelected;
    enteredAmount.value = 0;
    selectedValue.value = rupeesSelected ? rupeesOptions.first : gramsOptions.first;
  }

  /// Quick Select tap
  void selectValue(String value) {
    selectedValue.value = value;
    enteredAmount.value = 0;
  }

  /// Update entered value
  void updateEnteredAmount(int value) {
    enteredAmount.value = value;
    // Add custom value to options list if not exist
    if (isRupees.value) {
      if (!rupeesOptions.contains(value.toString())) {
        rupeesOptions.add(value.toString());
      }
      selectedValue.value = value.toString();
    } else {
      if (!gramsOptions.contains(value.toString())) {
        gramsOptions.add(value.toString());
      }
      selectedValue.value = value.toString();
    }
  }

  /// Prepare payment data
  Map<String, dynamic> getPaymentData() {
    String amount = isRupees.value
        ? "₹${selectedValue.value}"
        : "${selectedValue.value} gm";
    return {"amount": amount, "source": "buy_gold"};
  }
}
