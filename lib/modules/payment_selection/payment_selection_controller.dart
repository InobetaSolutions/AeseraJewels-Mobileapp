
import 'package:get/get.dart';

class PaymentSelectionController extends GetxController {
  final RxBool isOwnNumber = true.obs;
  final RxBool isRupees = true.obs;
  final RxInt enteredAmount = 0.obs;
  final RxDouble enteredGrams = 0.0.obs;
  final RxString mobileNumber = ''.obs;
  final RxString selectedOption = ''.obs;

  final rupeesOptions = <String>['100', '150', '200', '250 Popular', '300', '350', '400', '450'];
  final gramsOptions = <String>['2', '5', '50', '100', '200'];

  final double ratePerGram = 6200;

  String get displayAmount {
    if (isRupees.value) {
      return "₹${enteredAmount.value}";
    } else {
      final amount = enteredGrams.value * ratePerGram;
      return "₹${amount.toStringAsFixed(0)}";
    }
  }

  String get displayGrams {
    if (isRupees.value) {
      final grams = enteredAmount.value / ratePerGram;
      return "${grams.toStringAsFixed(2)} gm";
    } else {
      return "${enteredGrams.value} gm";
    }
  }

  void selectQuickOption(String value) {
    selectedOption.value = value;
    if (isRupees.value) {
      enteredAmount.value = int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    } else {
      enteredGrams.value = double.tryParse(value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0.0;
    }
  }
}
