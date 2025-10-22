// import 'dart:convert';
// import 'package:aesera_jewels/models/gold_rate_model.dart';
// import 'package:aesera_jewels/routes/app_routes.dart';
// import 'package:aesera_jewels/services/storage_service.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:connectivity_plus/connectivity_plus.dart';

// class DashboardController extends GetxController {
//   var goldRate = Rxn<GoldRateModel>();
//   var isLoadingRate = true.obs;
//   var userName = ''.obs;
//   var isOffline = false.obs;

//   // ✅ Support info
//   var supportMobile = ''.obs;
//   var supportEmail = ''.obs;
//   var isLoadingSupport = true.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     _initConnectivity();
//     fetchCurrentGoldRate();
//     loadUserName();
//     fetchSupportData(); // fetch support info on init
//   }

//   /// Connectivity
//   Future<void> _initConnectivity() async {
//     final connectivityResults = await Connectivity().checkConnectivity();
//     _updateConnectionStatus(connectivityResults as ConnectivityResult);

//     Connectivity().onConnectivityChanged.listen((result) {
//       _updateConnectionStatus(result as ConnectivityResult);
//     });
//   }

//   void _updateConnectionStatus(ConnectivityResult result) {
//     isOffline(result == ConnectivityResult.none);
//   }

//   /// Load saved username
//   Future<void> loadUserName() async {
//     final name = await StorageService.getUserName();
//     userName.value = name ?? "";
//   }

//   /// Fetch Gold Rate
//   Future<void> fetchCurrentGoldRate() async {
//     try {
//       isLoadingRate(true);

//       if (isOffline.value) {
//         final savedRate = await StorageService.getGoldRate();
//         if (savedRate != null) {
//           goldRate.value = GoldRateModel(
//             id: "cached",
//             timestamp: DateTime.now().millisecondsSinceEpoch,
//             priceGram24k: double.parse(savedRate),
//             istDate: DateTime.now().toString(),
//           );
//         }
//         return;
//       }

//       final url = Uri.parse('http://13.204.96.244:3000/api/getCurrentRate');
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         goldRate.value = GoldRateModel.fromJson(data);

//         if (goldRate.value != null) {
//           await StorageService.saveGoldRate(
//             goldRate.value!.priceGram24k.toString(),
//           );
//         }
//       } else {
//         Get.snackbar('Error', 'Failed to fetch gold rate');
//       }
//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//     } finally {
//       isLoadingRate(false);
//     }
//   }

//   /// ✅ Fetch Support Info API
//   Future<void> fetchSupportData() async {
//     try {
//       isLoadingSupport(true);

//       if (isOffline.value) return;

//       final url = Uri.parse(
//         'http://13.204.96.244:3000/api/getSupportById/68bbf1ac721e818f3835143d',
//       );
//       final response = await http.post(url);

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         supportMobile.value = data['data']['mobile'] ?? '';
//         supportEmail.value = data['data']['email'] ?? '';
//       } else {
//         Get.snackbar('Error', 'Failed to fetch support info');
//       }
//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//     } finally {
//       isLoadingSupport(false);
//     }
//   }

//   /// Navigation
//   void goToPayment() => Get.toNamed(AppRoutes.payment);
//   void goToCatalog() => Get.toNamed(AppRoutes.catalog);
//   void goToInvestment() => Get.toNamed(AppRoutes.investment);

//   /// Logout
//   void logout() async {
//     final storageService = StorageService();
//     await storageService.erase();
//     userName.value = "";
//     Get.offAllNamed("/");
//   }
// }
import 'dart:convert';
import 'dart:ui';
import 'package:aesera_jewels/Api/base_url.dart';
import 'package:aesera_jewels/models/gold_rate_model.dart';
import 'package:aesera_jewels/routes/app_routes.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class DashboardController extends GetxController {
  var goldRate = Rxn<GoldRateModel>();
  var isLoadingRate = true.obs;
  var userName = ''.obs;
  var isOffline = false.obs;

  // ✅ Support info
  var supportMobile = ''.obs;
  var supportEmail = ''.obs;
  var isLoadingSupport = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
    fetchCurrentGoldRate();
    loadUserName();
    fetchSupportData(); // fetch support info on init
  }

  /// Connectivity
  Future<void> _initConnectivity() async {
    final connectivityResults = await Connectivity().checkConnectivity();
    _updateConnectionStatus(connectivityResults as ConnectivityResult);

    Connectivity().onConnectivityChanged.listen((result) {
      _updateConnectionStatus(result as ConnectivityResult);
    });
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    isOffline(result == ConnectivityResult.none);
  }

  /// Load saved username
  Future<void> loadUserName() async {
    final name = await StorageService.getUserName();
    userName.value = name ?? "";
  }

  /// Fetch Gold Rate
  Future<void> fetchCurrentGoldRate() async {
    try {
      isLoadingRate(true);

      if (isOffline.value) {
        final savedRate = await StorageService.getGoldRate();
        if (savedRate != null) {
          goldRate.value = GoldRateModel(
            id: "cached",
            timestamp: DateTime.now().millisecondsSinceEpoch,
            priceGram24k: double.parse(savedRate),
            istDate: DateTime.now().toString(),
          );
        }
        return;
      }

      final url = Uri.parse('${BaseUrl.baseUrl}getCurrentRate');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        goldRate.value = GoldRateModel.fromJson(data);

        if (goldRate.value != null) {
          await StorageService.saveGoldRate(
            goldRate.value!.priceGram24k.toString(),
          );
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch gold rate');
      }
    } catch (e) {
      Get.snackbar('Error',  " please check your internet connection",
          backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
    } finally {
      isLoadingRate(false);
    }
  }

  /// ✅ Fetch Support Info API (using getSupport)
  Future<void> fetchSupportData() async {
    try {
      isLoadingSupport(true);

      if (isOffline.value) return;

      final url = Uri.parse('${BaseUrl.baseUrl}getSupport');
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['data'] != null) {
          supportMobile.value = data['data']['mobile'] ?? '';
          supportEmail.value = data['data']['email'] ?? '';
        }
        print('Support Data: $data'); // Debug print
        print('Support Mobile: ${supportMobile.value}');
        print('Support Email: ${supportEmail.value}');
      } else {
        Get.snackbar('Error', 'Failed to fetch support info');
      }
    } catch (e) {
      Get.snackbar('Error', " please check your internet connection",
          backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
    } finally {
      isLoadingSupport(false);
    }
  }

  /// Navigation
  void goToPayment() => Get.toNamed(AppRoutes.payment);
  void goToCatalog() => Get.toNamed(AppRoutes.catalog);
  void goToInvestment() => Get.toNamed(AppRoutes.investment);

  /// Logout
  void logout() async {
    final storageService = StorageService();
    await storageService.erase();
    userName.value = "";
    Get.offAllNamed("/");
  }
}
