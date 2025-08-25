
// import 'package:aesera_jewels/modules/payment_selection/payment_selection_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class BuyGoldController extends GetxController {
//   // Mode selection (true = Rupees, false = Grams)
//   RxBool isRupees = true.obs;

//   // Selected quick option value
//   RxString selectedValue = '200'.obs; // Default ₹200

//   // Entered amount from text field
//   RxDouble enteredAmount = 0.0.obs;

//   // Quick select options
//   final List<String> rupeesOptions = ['10', '50', '150', '200', '250', '300'];
//   final List<String> gramsOptions = ['2', '5', '50', '100', '200'];

//   /// Toggle between Rupees and Grams
//   void toggleMode(bool rupeesSelected) {
//     isRupees.value = rupeesSelected;
//     selectedValue.value = rupeesSelected ? '200' : '2';
//     enteredAmount.value = 0.0; // Reset custom entry
//   }

//   /// Quick selection tap
//   void selectValue(String value) {
//     selectedValue.value = value;
//     enteredAmount.value = 0.0; // Reset entered value when quick select is used
//   }

//   /// Proceed with payment logic → Navigate to PaymentScreen (Named Route)
//   void makePayment() {
//     String amountToPass = isRupees.value
//         ? selectedValue.value
//         : '${selectedValue.value} grams';

//     // If custom amount is entered, use that
//     if (enteredAmount.value > 0) {
//       amountToPass = enteredAmount.value.toString();
//     }

//     Get.toNamed(AppRoutes.payment, arguments: {
//       "amount": amountToPass,
//       "source": "buy_gold"
//     });
//   }
// }
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
