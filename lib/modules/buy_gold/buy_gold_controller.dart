




// // import 'package:get/get.dart';
// // class BuyGoldController extends GetxController {
// //   /// Mode: true = Rupees, false = Grams
// //   RxBool isRupees = true.obs;

// //   /// Selected quick option
// //   RxString selectedValue = '200'.obs;

// //   /// Entered custom value
// //   RxDouble enteredAmount = 0.0.obs;

// //   /// Options
// //   final List<String> rupeesOptions = ['10', '50', '150', '200', '250', '300'];
// //   final List<String> gramsOptions = ['2', '5', '50', '100', '200'];

// //   /// Toggle between Rupees and Grams
// //   void toggleMode(bool rupeesSelected) {
// //     isRupees.value = rupeesSelected;
// //     selectedValue.value = rupeesSelected ? '200' : '2';
// //     enteredAmount.value = 0.0;
// //   }

// //   /// Quick Select
// //   void selectValue(String value) {
// //     selectedValue.value = value;
// //     enteredAmount.value = 0.0;
// //   }

// //   /// Prepare payment data
// //   Map<String, dynamic> getPaymentData() {
// //     String amountToPass = isRupees.value
// //         ? "₹${selectedValue.value}"
// //         : "${selectedValue.value} gm";

// //     if (enteredAmount.value > 0) {
// //       amountToPass = isRupees.value
// //           ? "₹${enteredAmount.value}"
// //           : "${enteredAmount.value} gm";
// //     }

// //     return {
// //       "amount": amountToPass,
// //       "source": "buy_gold",
// //     };
// //   }
// // }
// import 'package:get/get.dart';

// class BuyGoldController extends GetxController {
//   /// Mode: true = Rupees, false = Grams
//   RxBool isRupees = true.obs;

//   /// Selected quick option (string)
//   RxString selectedValue = ''.obs;

//   /// Entered custom value
//   RxInt enteredAmount = 0.obs;

//   /// Options list
//   RxList<String> rupeesOptions = <String>['100', '150', '200', '250', '300'].obs;
//   RxList<String> gramsOptions = <String>['2', '5', '50', '100', '200'].obs;

//   /// Toggle between Rupees and Grams
//   void toggleMode(bool rupeesSelected) {
//     isRupees.value = rupeesSelected;
//     enteredAmount.value = 0;
//     selectedValue.value = rupeesSelected ? rupeesOptions.first : gramsOptions.first;
//   }

//   /// Quick Select tap
//   void selectValue(String value) {
//     selectedValue.value = value;
//     enteredAmount.value = 0;
//   }

//   /// Update entered value
//   void updateEnteredAmount(int value) {
//     enteredAmount.value = value;
//     // Add custom value to options list if not exist
//     if (isRupees.value) {
//       if (!rupeesOptions.contains(value.toString())) {
//         rupeesOptions.add(value.toString());
//       }
//       selectedValue.value = value.toString();
//     } else {
//       if (!gramsOptions.contains(value.toString())) {
//         gramsOptions.add(value.toString());
//       }
//       selectedValue.value = value.toString();
//     }
//   }

//   /// Prepare payment data
//   Map<String, dynamic> getPaymentData() {
//     String amount = isRupees.value
//         ? "₹${selectedValue.value}"
//         : "${selectedValue.value} gm";
//     return {"amount": amount, "source": "buy_gold"};
//   }
// }
import 'package:get/get.dart';

class BuyGoldController extends GetxController {
  /// Mode: true = Rupees, false = Grams
  final RxBool isRupees = true.obs;

  /// Selected quick option (string)
  final RxString selectedValue = ''.obs;

  /// Entered custom value (integer)
  final RxInt enteredAmount = 0.obs;

  /// Options list
  final RxList<String> rupeesOptions =
      <String>['100', '150', '200', '250', '300'].obs;
  final RxList<String> gramsOptions =
      <String>['2', '5', '50', '100', '200'].obs;

  @override
  void onInit() {
    super.onInit();
    // default selection
    selectedValue.value = rupeesOptions.first;
  }

  /// Toggle between Rupees and Grams
  void toggleMode(bool rupeesSelected) {
    isRupees.value = rupeesSelected;
    // reset custom entered amount
    enteredAmount.value = 0;
    selectedValue.value = rupeesSelected ? rupeesOptions.first : gramsOptions.first;
  }

  /// Quick Select tap
  void selectValue(String value) {
    selectedValue.value = value;
    // reflect quick select as the entered amount (so UI shows same)
    enteredAmount.value = int.tryParse(value) ?? 0;

    // ensure this option exists in the list (avoid duplicates)
    if (isRupees.value) {
      if (!rupeesOptions.contains(value)) rupeesOptions.add(value);
    } else {
      if (!gramsOptions.contains(value)) gramsOptions.add(value);
    }
  }

  /// Update entered value (called while typing)
  void updateEnteredAmount(int value) {
    enteredAmount.value = value;

    // if user typed a custom value, keep selectedValue in sync (and add to list if needed)
    if (value > 0) {
      final s = value.toString();
      selectedValue.value = s;
      if (isRupees.value) {
        if (!rupeesOptions.contains(s)) rupeesOptions.add(s);
      } else {
        if (!gramsOptions.contains(s)) gramsOptions.add(s);
      }
    }
  }

  /// Get integer amount to send to API (always integer number)
  int getAmountForApi() {
    if (enteredAmount.value > 0) return enteredAmount.value;
    return int.tryParse(selectedValue.value) ?? 0;
  }

  /// Payment data map to pass as arguments (amount as integer)
  Map<String, dynamic> getPaymentData() {
    return {
      "amount": getAmountForApi(),
      "source": "buy_gold",
    };
  }
}
