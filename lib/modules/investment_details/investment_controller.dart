import 'dart:convert';
import 'package:aesera_jewels/models/investment_model.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
 
class InvestmentController extends GetxController {
  static const TAB_PAID = 0;
  static const TAB_RECEIVED = 1;
  static const TAB_PURCHASED = 2;
  final paidTransactions = <Transaction>[].obs;
 
  final userName = ''.obs;
  final userMobile = ''.obs;
  final userToken = ''.obs;

  final apiTotalInvestment = 0.0.obs;
  final apiTotalGrams = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
  }
 
  Future<void> _loadUserData() async {
    userName.value = await StorageService.getUserName() ?? '';
    userMobile.value = await StorageService().getMobile() ?? '';
    userToken.value = await StorageService().getToken() ?? '';
  }

  void changeTab(int index) => selectedTab.value = index;

  Future<void> fetchTransactions() async {
    if (userMobile.value.isEmpty) return;
 
    isLoading.value = true;
    paidTransactions.clear();
    receivedTransactions.clear();
    purchasedHistory.clear();
    apiTotalInvestment.value = 0.0;
    apiTotalGrams.value = 0.0;
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${userToken.value}',
      };
      final response = await http.post(
        Uri.parse('http://13.204.96.244:3000/api/getpaymenthistory'),
        headers: headers,
        body: jsonEncode({'mobile': userMobile.value}),
      );
 
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final investmentResponse = InvestmentResponse.fromJson(data);
 
        apiTotalInvestment.value = investmentResponse.totalAmount;
        apiTotalGrams.value = investmentResponse.totalGrams;
        paidTransactions.value = investmentResponse.payments
            .where((t) =>
                t.status.toLowerCase() == 'pending' ||
                t.status.toLowerCase() == 'approved')
            .toList();
 
        receivedTransactions.value = investmentResponse.payments
            .where((t) => t.status.toLowerCase() == 'received')
            .toList();
 
        purchasedHistory.value = investmentResponse.payments
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
  double get calculatedTotal =>
      paidTransactions.fold(0.0, (sum, tx) => sum + tx.amount);
  double get calculatedGrams =>
      paidTransactions.fold(0.0, (sum, tx) => sum + tx.gram);
  String get formattedTotal {
    final amount = apiTotalInvestment.value > 0
        ? apiTotalInvestment.value
        : calculatedTotal;
    return NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(amount);
  }
  String get formattedTotalGrams {
    final grams =
        apiTotalGrams.value > 0 ? apiTotalGrams.value : calculatedGrams;
    return "${grams.toStringAsFixed(3)} g";
  }
  
}
 
 