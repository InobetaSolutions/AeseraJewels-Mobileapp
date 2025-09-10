
import 'dart:convert';
import 'package:aesera_jewels/models/investment_model.dart';
import 'package:aesera_jewels/models/catalog_model.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class InvestmentController extends GetxController {
  static const TAB_PAID = 0;
  static const TAB_RECEIVED = 1;
  static const TAB_PURCHASED = 2;

  final selectedTab = TAB_PAID.obs;
  final isLoading = false.obs;

  // API Lists
  final paidTransactions = <Transaction>[].obs;
  final allotments = <Allotment>[].obs;
  final purchasedHistory = <UserCatalog>[].obs;

  // Totals
  final apiTotalInvestment = 0.0.obs;
  final apiTotalGrams = 0.0.obs;

  // User data
  final userMobile = ''.obs;
  final userToken = ''.obs;
  final userName = ''.obs;

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
    userMobile.value = await StorageService().getMobile() ?? '';
    userToken.value = await StorageService().getToken() ?? '';
    userName.value = await StorageService().getName() ?? 'User';
  }

  void changeTab(int index) {
    selectedTab.value = index;
    if (index == TAB_RECEIVED) {
      fetchAllotments();
    } else if (index == TAB_PURCHASED) {
      fetchPurchasedCatalog();
    }
  }

  Future<void> refreshData() async {
    if (selectedTab.value == TAB_PAID) {
      await fetchTransactions();
    } else if (selectedTab.value == TAB_RECEIVED) {
      await fetchAllotments();
    } else if (selectedTab.value == TAB_PURCHASED) {
      await fetchPurchasedCatalog();
    }
  }

  /// ---- Fetch Paid Transactions ----
  Future<void> fetchTransactions() async {
    if (userMobile.value.isEmpty) return;
    isLoading.value = true;

    try {
      final headers = await StorageService().getAuthHeaders();
      final response = await http.post(
        Uri.parse("http://13.204.96.244:3000/api/getpaymenthistory"),
        headers: headers,
        body: jsonEncode({"mobile": userMobile.value}),
      );

      debugPrint("💬 Paid Response (${response.statusCode}) => ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final investmentResponse = InvestmentResponse.fromJson(data);

        apiTotalInvestment.value = investmentResponse.totalAmount;
        apiTotalGrams.value = investmentResponse.totalGrams;
        paidTransactions.assignAll(investmentResponse.payments);
      }
      print(paidTransactions);
    } catch (e) {
      Get.snackbar("Error", "Paid fetch failed: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ---- Fetch Allotments ----
  Future<void> fetchAllotments() async {
    if (userMobile.value.isEmpty) return;
    isLoading.value = true;

    try {
      final headers = await StorageService().getAuthHeaders();
      final response = await http.get(
        Uri.parse("http://13.204.96.244:3000/api/getByUserAllotment?mobile=${userMobile.value}"),
        headers: headers,
      );

      debugPrint("💬 Allotment Response (${response.statusCode}) => ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final allotmentResponse = AllotmentResponse.fromJson(data);
        allotments.assignAll(allotmentResponse.allotments);
      }
      print(allotments);
    } catch (e) {
      Get.snackbar("Error", "Allotment fetch failed: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ---- Fetch Purchased Catalog ----
  Future<void> fetchPurchasedCatalog() async {
    if (userMobile.value.isEmpty) return;
    isLoading.value = true;

    try {
      final headers = await StorageService().getAuthHeaders();
      final response = await http.post(
        Uri.parse("http://13.204.96.244:3000/api/getbyUserCatalog"),
        headers: headers,
        body: jsonEncode({"mobileNumber": userMobile.value}),
      );

      debugPrint("💬 Purchased Response (${response.statusCode}) => ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        purchasedHistory.assignAll(UserCatalog.listFromJson(data["data"]));
      }
      print(purchasedHistory);
    } catch (e) {
      Get.snackbar("Error", "Purchased fetch failed: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Helpers
  String formatDate(DateTime? date) {
    if (date == null) return "-";
    return DateFormat("dd MMM yyyy, h:mm a").format(date);
  }

  String get formattedTotal =>
      NumberFormat.currency(locale: "en_IN", symbol: "₹")
          .format(apiTotalInvestment.value);

  String get formattedTotalGrams =>
      "${apiTotalGrams.value.toStringAsFixed(2)} g";
}
