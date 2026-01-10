// import 'dart:convert';
// import 'package:aesera_jewels/Api/base_url.dart';
// import 'package:aesera_jewels/models/catalog_model.dart';
// import 'package:aesera_jewels/models/investment_model.dart';
// import 'package:aesera_jewels/services/storage_service.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';

// class InvestmentDetailController extends GetxController {
//   static const TAB_PAID = 0;
//   static const TAB_RECEIVED = 1;
//   static const TAB_PURCHASED = 2;
//   static const TAB_SOLD = 3;

//   final selectedTab = TAB_PAID.obs;
//   final isLoading = false.obs;

//   final paidTransactions = <Transaction>[].obs;
//   final allotments = <Allotment>[].obs;
//   final purchasedHistory = <UserCatalog>[].obs;
//   final coinPaymentHistory = <CoinPayment>[].obs;

//   final apiTotalInvestment = 0.0.obs;
//   final apiTotalGrams = 0.0.obs;

//   final userMobile = ''.obs;
//   final userToken = ''.obs;
//   final userName = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     _initController();
//   }

//   Future<void> _initController() async {
//     await _loadUserData();
//     await fetchTransactions();
//   }

//   Future<void> _loadUserData() async {
//     userMobile.value = await StorageService().getMobile() ?? '';
//     userToken.value = await StorageService().getToken() ?? '';
//     userName.value = await StorageService().getName() ?? 'User';
//   }

//   void changeTab(int index) {
//     selectedTab.value = index;
//     if (index == TAB_RECEIVED) {
//       fetchAllotments();
//     } else if (index == TAB_PURCHASED) {
//       fetchPurchasedCatalog();
//       fetchCoinPaymentHistory(); // Fetch both APIs for purchased tab
//     }
//   }

//   Future<void> refreshData() async {
//     if (selectedTab.value == TAB_PAID) {
//       await fetchTransactions();
//     } else if (selectedTab.value == TAB_RECEIVED) {
//       await fetchAllotments();
//     } else if (selectedTab.value == TAB_PURCHASED) {
//       await fetchPurchasedCatalog();
//       await fetchCoinPaymentHistory();
//     }
//   }

//   Future<void> fetchTransactions() async {
//     if (userMobile.value.isEmpty) return;
//     isLoading.value = true;
//     try {
//       final headers = await StorageService().getAuthHeaders();
//       final response = await http.post(
//         Uri.parse("${BaseUrl.baseUrl}getpaymenthistory"),
//         headers: headers,
//         body: jsonEncode({"mobile": userMobile.value}),
//       );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final investmentResponse = InvestmentResponse.fromJson(data);

//         // Update the API totals correctly
//         apiTotalInvestment.value = double.parse(
//           investmentResponse.totalAmount.toString(),
//         );
//         apiTotalGrams.value = double.parse(
//           investmentResponse.totalGrams.toString(),
//         );

//         paidTransactions.assignAll(investmentResponse.payments);
//       } else {
//         print("API Error: ${response.statusCode}");
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Please check your internet connection",
//         backgroundColor: const Color(0xFF09243D),
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//   // Future<void> fetchTransactions() async {
//   //   if (userMobile.value.isEmpty) return;
//   //   isLoading.value = true;
//   //   try {
//   //     final headers = await StorageService().getAuthHeaders();
//   //     final response = await http.post(
//   //       Uri.parse("${BaseUrl.baseUrl}getpaymenthistory"),
//   //       headers: headers,
//   //       body: jsonEncode({"mobile": userMobile.value}),
//   //     );
//   //     if (response.statusCode == 200) {
//   //       final data = jsonDecode(response.body);
//   //       final investmentResponse = InvestmentResponse.fromJson(data);
//   //       apiTotalInvestment.value = investmentResponse.totalAmount;
//   //       apiTotalGrams.value = investmentResponse.totalGrams;
//   //       paidTransactions.assignAll(investmentResponse.payments);
//   //     } else {
//   //       print("API Error: ${response.statusCode}");
//   //     }
//   //   } catch (e) {
//   //     Get.snackbar("Error", "Please check your internet connection",
//   //         backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
//   //   } finally {
//   //     isLoading.value = false;
//   //   }
//   // }

//   Future<void> fetchAllotments() async {
//     if (userMobile.value.isEmpty) return;
//     isLoading.value = true;
//     try {
//       final headers = await StorageService().getAuthHeaders();
//       final response = await http.get(
//         Uri.parse(
//           "${BaseUrl.baseUrl}getByUserAllotment?mobile=${userMobile.value}",
//         ),
//         headers: headers,
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final allotmentResponse = AllotmentResponse.fromJson(data);
//         allotments.assignAll(allotmentResponse.allotments);
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Please check your internet connection",
//         backgroundColor: const Color(0xFF09243D),
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> fetchPurchasedCatalog() async {
//     if (userMobile.value.isEmpty) return;
//     isLoading.value = true;
//     try {
//       final headers = await StorageService().getAuthHeaders();
//       final response = await http.post(
//         Uri.parse("${BaseUrl.baseUrl}getbyUserCatalog"),
//         headers: headers,
//         body: jsonEncode({"mobileNumber": userMobile.value}),
//       );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         purchasedHistory.assignAll(UserCatalog.listFromJson(data["data"]));
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Please check your internet connection",
//         backgroundColor: const Color(0xFF09243D),
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   /// NEW: Fetch Coin Payment History
//   Future<void> fetchCoinPaymentHistory() async {
//     if (userMobile.value.isEmpty) return;
//     isLoading.value = true;
//     try {
//       final headers = await StorageService().getAuthHeaders();
//       final response = await http.get(
//         Uri.parse(
//           "${BaseUrl.baseUrl}getCoinPaymentHistory/${userMobile.value}",
//         ),
//         headers: headers,
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final coinPaymentResponse = CoinPaymentResponse.fromJson(data);
//         coinPaymentHistory.assignAll(coinPaymentResponse.data);
//       }
//     } catch (e) {
//       print("Coin Payment History Error: $e");
//       Get.snackbar(
//         "Error",
//         "Please check your internet connection",
//         backgroundColor: const Color(0xFF09243D),
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   String formatDate(DateTime? date, {String pattern = "dd-MM-yyyy"}) {
//     if (date == null) return "N/A";
//     return DateFormat(pattern).format(date);
//   }

//   String get formattedTotal => NumberFormat.currency(
//     locale: "en_IN",
//     symbol: "₹",
//   ).format(apiTotalInvestment.value);

//   String get formattedTotalGrams =>
//       "${apiTotalGrams.value.toStringAsFixed(2)} g";
// }

import 'dart:convert';
import 'package:aesera_jewels/Api/base_url.dart';
import 'package:aesera_jewels/models/catalog_model.dart';
import 'package:aesera_jewels/models/investment_model.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class InvestmentDetailController extends GetxController {
  static const TAB_PAID = 0;
  static const TAB_RECEIVED = 1;
  static const TAB_PURCHASED = 2;
  static const TAB_SOLD = 3;

  final selectedTab = TAB_PAID.obs;
  final isLoading = false.obs;

  final paidTransactions = <Transaction>[].obs;
  final allotments = <Allotment>[].obs;
  final purchasedHistory = <UserCatalog>[].obs;
  final coinPaymentHistory = <CoinPayment>[].obs;
  final sellPaymentHistory = <SellPaymentHistory>[].obs; // Add this line

  final apiTotalInvestment = 0.0.obs;
  final apiTotalGrams = 0.0.obs;

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
      fetchCoinPaymentHistory();
    } else if (index == TAB_SOLD) {
      fetchSellPaymentHistory(); // Add this line
    }
  }

  Future<void> refreshData() async {
    if (selectedTab.value == TAB_PAID) {
      await fetchTransactions();
    } else if (selectedTab.value == TAB_RECEIVED) {
      await fetchAllotments();
    } else if (selectedTab.value == TAB_PURCHASED) {
      await fetchPurchasedCatalog();
      await fetchCoinPaymentHistory();
    } else if (selectedTab.value == TAB_SOLD) {
      await fetchSellPaymentHistory(); // Add this line
    }
  }

  Future<void> fetchTransactions() async {
    if (userMobile.value.isEmpty) return;
    isLoading.value = true;
    try {
      final headers = await StorageService().getAuthHeaders();
      final response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}getpaymenthistory"),
        headers: headers,
        body: jsonEncode({"mobile": userMobile.value}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final investmentResponse = InvestmentResponse.fromJson(data);

        apiTotalInvestment.value = double.parse(
          investmentResponse.totalAmount.toString(),
        );
        apiTotalGrams.value = double.parse(
          investmentResponse.totalGrams.toString(),
        );

        paidTransactions.assignAll(investmentResponse.payments);
      } else {
        print("API Error: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Please check your internet connection",
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAllotments() async {
    if (userMobile.value.isEmpty) return;
    isLoading.value = true;
    try {
      final headers = await StorageService().getAuthHeaders();
      final response = await http.get(
        Uri.parse(
          "${BaseUrl.baseUrl}getByUserAllotment?mobile=${userMobile.value}",
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final allotmentResponse = AllotmentResponse.fromJson(data);
        allotments.assignAll(allotmentResponse.allotments);
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Please check your internet connection",
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPurchasedCatalog() async {
    if (userMobile.value.isEmpty) return;
    isLoading.value = true;
    try {
      final headers = await StorageService().getAuthHeaders();
      final response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}getbyUserCatalog"),
        headers: headers,
        body: jsonEncode({"mobileNumber": userMobile.value}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        purchasedHistory.assignAll(UserCatalog.listFromJson(data["data"]));
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Please check your internet connection",
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCoinPaymentHistory() async {
    if (userMobile.value.isEmpty) return;
    isLoading.value = true;
    try {
      final headers = await StorageService().getAuthHeaders();
      final response = await http.get(
        Uri.parse(
          "${BaseUrl.baseUrl}getCoinPaymentHistory/${userMobile.value}",
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final coinPaymentResponse = CoinPaymentResponse.fromJson(data);
        coinPaymentHistory.assignAll(coinPaymentResponse.data);
      }
    } catch (e) {
      print("Coin Payment History Error: $e");
      Get.snackbar(
        "Error",
        "Please check your internet connection",
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // NEW: Fetch Sell Payment History
  Future<void> fetchSellPaymentHistory() async {
    if (userMobile.value.isEmpty) return;
    isLoading.value = true;
    try {
      final headers = await StorageService().getAuthHeaders();
      final response = await http.get(
        Uri.parse('${BaseUrl.baseUrl}getAllSellPaymentHistoryForUser'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final data = jsonDecode(responseBody);
        final sellPaymentResponse = SellPaymentResponse.fromJson(data);
        sellPaymentHistory.assignAll(sellPaymentResponse.data);
        print(
          "Sell Payment History Fetched Successfully: ${sellPaymentHistory.length} items",
        );
      } else {
        print("Sell Payment History API Error: ${response.statusCode}");
        print("Reason: ${response.reasonPhrase}");
        Get.snackbar(
          "Error",
          "Failed to load sell payment history",
          backgroundColor: const Color(0xFF09243D),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Sell Payment History Error: $e");
      Get.snackbar(
        "Error",
        "Please check your internet connection",
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  String formatDate(DateTime? date, {String pattern = "dd-MM-yyyy"}) {
    if (date == null) return "N/A";
    return DateFormat(pattern).format(date);
  }

  String get formattedTotal => NumberFormat.currency(
    locale: "en_IN",
    symbol: "₹",
  ).format(apiTotalInvestment.value);

  String get formattedTotalGrams =>
      "${apiTotalGrams.value.toStringAsFixed(2)} g";
}
