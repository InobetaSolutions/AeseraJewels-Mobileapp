
import 'dart:convert';

import 'package:aesera_jewels/models/investment_model.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:aesera_jewels/models/investment_model.dart';

class InvestmentController extends GetxController {
  static const TAB_PAID = 0;
  static const TAB_RECEIVED = 1;
  static const TAB_PURCHASED = 2;

  /// Observables
  final selectedTab = TAB_PAID.obs;
  final paidTransactions = <Transaction>[].obs;
  final receivedTransactions = <Transaction>[].obs;
  final purchasedHistory = <Transaction>[].obs;
  final isLoading = false.obs;

  final userName = ''.obs;
  final userMobile = ''.obs;

  /// API total investment
  final apiTotalInvestment = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _initController();
  }

  Future<void> _initController() async {
    await _loadUserData();
    await fetchTransactions();
  }

  Future<void> _loadUserData() async {
    userName.value = await StorageService.getUserName() ?? '';
    userMobile.value = await StorageService().getMobile() ?? '';
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  Future<void> fetchTransactions() async {
    if (userMobile.value.isEmpty) return;

    isLoading.value = true;
    paidTransactions.clear();
    receivedTransactions.clear();
    purchasedHistory.clear();
    apiTotalInvestment.value = 0.0;

    try {
      final response = await http.post(
        Uri.parse('http://13.204.96.244:3000/api/getpaymenthistory'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobile': userMobile.value}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // API Total Investment
        if (data['totalAmount'] != null) {
          apiTotalInvestment.value = (data['totalAmount'] as num).toDouble();
        }

        final payments = (data['payments'] as List<dynamic>? ?? []);
        final allTransactions = payments
            .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
            .toList();

        // Separate lists based on status
        paidTransactions.value = allTransactions
            .where((t) =>
                t.status.toLowerCase() == 'pending' ||
                t.status.toLowerCase() == 'approved')
            .toList();

        receivedTransactions.value = allTransactions
            .where((t) => t.status.toLowerCase() == 'received')
            .toList();

        purchasedHistory.value = allTransactions
            .where((t) => t.status.toLowerCase() == 'purchased')
            .toList();
      } else {
        Get.snackbar('Error', response.reasonPhrase ?? 'Failed to fetch data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Fallback calculation
  double get calculatedTotal =>
      paidTransactions.fold(0.0, (sum, tx) => sum + (tx.amount));

  /// Use API total if available, else fallback
  String get formattedTotal {
    final amount =
        apiTotalInvestment.value > 0 ? apiTotalInvestment.value : calculatedTotal;
    return NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(amount);
  }
}
