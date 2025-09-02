
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:aesera_jewels/modules/investment_details/portfolio_view.dart';
import 'package:aesera_jewels/modules/investment_details/portfolio_controller.dart';

class Payment_Controller extends GetxController {
  /// Toggles
  final isOwnNumber = true.obs;
  final isRupees = true.obs;

  /// Input
  final enteredMobile = ''.obs;
  final enteredAmount = 0.obs;
  final selectedValue = ''.obs;

  /// Options
  final rupeesOptions = <String>['100', '150', '200', '250', '300'].obs;
  final gramsOptions = <String>['2', '5', '50', '100', '200'].obs;

  @override
  void onInit() {
    super.onInit();
    selectedValue.value = rupeesOptions.first;
  }

  /// Toggle own/others number
  void toggleNumber(bool own) {
    isOwnNumber.value = own;
    if (own) enteredMobile.value = '';
  }

  /// Toggle Rupees/Grams
  void toggleMode(bool rupeesSelected) {
    isRupees.value = rupeesSelected;
    enteredAmount.value = 0;
    selectedValue.value =
        rupeesSelected ? rupeesOptions.first : gramsOptions.first;
  }

  /// Quick select
  void selectValue(String value) {
    selectedValue.value = value;
    enteredAmount.value = int.tryParse(value) ?? 0;
  }

  /// Text field entry
  void updateEnteredAmount(int value) {
    enteredAmount.value = value;
    if (value > 0) selectedValue.value = value.toString();
  }

  /// API call
  Future<void> createPayment() async {
    final mobile = isOwnNumber.value
        ? await StorageService().getMobile() ?? ''
        : enteredMobile.value.trim();

    if (mobile.isEmpty || !RegExp(r'^\d{10}$').hasMatch(mobile)) {
      Get.snackbar("Error", "Enter a valid 10-digit mobile number");
      return;
    }

    final amount = enteredAmount.value > 0
        ? enteredAmount.value
        : int.tryParse(selectedValue.value) ?? 0;

    if (amount <= 0) {
      Get.snackbar("Error", "Please enter valid amount/grams");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("http://13.204.96.244:3000/api/create-payment"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "mobile": mobile,
          "mode": isRupees.value ? "rupees" : "grams",
          "amount": amount,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final tabIndex = isRupees.value
            ? InvestmentController.TAB_PAID
            : InvestmentController.TAB_RECEIVED;

        Get.offAll(() => InvestmentDetailScreen(initialTabIndex: tabIndex));
      } else {
        Get.snackbar("Error", response.reasonPhrase ?? "Payment failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }
}
