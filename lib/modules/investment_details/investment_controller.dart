import 'dart:convert';
import 'package:aesera_jewels/models/investment_model.dart';
import 'package:aesera_jewels/models/catalog_model.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class InvestmentController extends GetxController {
  static const TAB_PAID = 0;
  static const TAB_RECEIVED = 1;
  static const TAB_PURCHASED = 2;

  final selectedTab = TAB_PAID.obs;
  final paidTransactions = <Transaction>[].obs;
  final receivedTransactions = <Transaction>[].obs;
  final purchasedHistory = <UserCatalog>[].obs; // 👈 Updated
  final allotments = <Allotment>[].obs;
  final isLoading = false.obs;

  final userName = ''.obs;
  final userMobile = ''.obs;
  final userToken = ''.obs;

  final apiTotalInvestment = 0.0.obs;
  final apiTotalGrams = 0.0.obs;

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
    userToken.value = await StorageService().getToken() ?? '';
  }

  void changeTab(int index) {
    selectedTab.value = index;
    if (index == TAB_RECEIVED) {
      fetchAllotments();
    } else if (index == TAB_PURCHASED) {
      fetchPurchasedCatalog(); // 👈 Call Purchased API
    }
  }

  /// REFRESH: Re-fetch all data
  Future<void> refreshData() async {
    await fetchTransactions();
    if (selectedTab.value == TAB_RECEIVED) {
      await fetchAllotments();
    } else if (selectedTab.value == TAB_PURCHASED) {
      await fetchPurchasedCatalog();
    }
  }

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
            .where(
              (t) =>
                  t.status.toLowerCase() == 'pending' ||
                  t.status.toLowerCase() == 'approved',
            )
            .toList();

        receivedTransactions.value = investmentResponse.payments
            .where((t) => t.status.toLowerCase() == 'received')
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

  Future<void> fetchAllotments() async {
    if (userMobile.value.isEmpty) return;

    isLoading.value = true;
    allotments.clear();

    try {
      final headers = {'Authorization': 'Bearer ${userToken.value}'};

      final response = await http.get(
        Uri.parse(
          'http://13.204.96.244:3000/api/getByUserAllotment?mobile=${userMobile.value}',
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(await response.body) as Map<String, dynamic>;
        final allotmentResponse = AllotmentResponse.fromJson(data);
        allotments.value = allotmentResponse.allotments;
      } else {
        Get.snackbar('Error', response.reasonPhrase ?? 'Failed to fetch data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// 👈 NEW: Fetch Purchased Catalog
  Future<void> fetchPurchasedCatalog() async {
    if (userMobile.value.isEmpty) return;

    isLoading.value = true;
    purchasedHistory.clear();

    try {
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'mobileNumber': userMobile.value});

      final response = await http.post(
        Uri.parse('http://13.204.96.244:3000/api/getbyUserCatalog'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        purchasedHistory.value = UserCatalog.listFromJson(data['data']);
      } else {
        Get.snackbar(
          'Error',
          response.reasonPhrase ?? 'Failed to fetch catalog',
        );
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
    final grams = apiTotalGrams.value > 0
        ? apiTotalGrams.value
        : calculatedGrams;
    return "${grams.toStringAsFixed(2)} g";
  }
}
