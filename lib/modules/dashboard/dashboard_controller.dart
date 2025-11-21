
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

  var currentGoldRate;

  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
    fetchCurrentGoldRate();
    _loadUserData();
    fetchSupportData(); // fetch support info on init
  }

  /// ✅ FIXED Connectivity logic for connectivity_plus v6.x
  Future<void> _initConnectivity() async {
    try {
      final List<ConnectivityResult> results = await _connectivity.checkConnectivity();
      _updateConnectionStatus(results);

      _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
        _updateConnectionStatus(results);
      });
    } catch (e) {
      print("Connectivity init error: $e");
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    isOffline.value = !results.contains(ConnectivityResult.mobile) &&
        !results.contains(ConnectivityResult.wifi);
  }

  /// ✅ Load user data
  Future<void> _loadUserData() async {
    try {
      final name = StorageService().getName();
      userName.value = name ?? 'User';
      print('Dashboard User Name: $name');
    } catch (e) {
      userName.value = 'User';
      print('Error loading user name: $e');
    }
  }

  /// ✅ Fetch Gold Rate
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
      Get.snackbar('Error', "Please check your internet connection",
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

        print('Support Data: $data');
        print('Support Mobile: ${supportMobile.value}');
        print('Support Email: ${supportEmail.value}');
      } else {
        Get.snackbar('Error', 'Failed to fetch support info');
      }
    } catch (e) {
      Get.snackbar('Error', "Please check your internet connection",
          backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
    } finally {
      isLoadingSupport(false);
    }
  }

  /// ✅ Navigation
  void goToPayment() => Get.toNamed(AppRoutes.payment);
  void goToCatalog() => Get.toNamed(AppRoutes.catalog);
  void goToGoldCoin() => Get.toNamed(AppRoutes.goldcoin);
  void goToInvestment() => Get.toNamed(AppRoutes.investment);
  void goToCoinCatalog() => Get.toNamed(AppRoutes.coin_catalog);
  void goToGoldCoinpayment() => Get.toNamed(AppRoutes.goldcoinpayment);

  /// ✅ Logout
  void logout() async {
    final storageService = StorageService();
    await storageService.erase();
    userName.value = "";
    Get.offAllNamed("/");
  }
}


// import 'dart:convert';
// import 'dart:ui';
// import 'package:aesera_jewels/Api/base_url.dart';
// import 'package:aesera_jewels/models/gold_rate_model.dart';
// import 'package:aesera_jewels/routes/app_routes.dart';
// import 'package:aesera_jewels/services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DashboardController extends GetxController with WidgetsBindingObserver {
//   static DashboardController get to => Get.find<DashboardController>();

//   var goldRate = Rxn<GoldRateModel>();
//   var isLoadingRate = true.obs;
//   var userName = ''.obs;
//   var isOffline = false.obs;

//   // ✅ Support info
//   var supportMobile = ''.obs;
//   var supportEmail = ''.obs;
//   var isLoadingSupport = true.obs;

//   // Background tracking variables
//   DateTime? _backgroundStart;
//   var totalBackgroundTime = Duration.zero.obs;

//   final Connectivity _connectivity = Connectivity();

//   @override
//   void onInit() {
//     super.onInit();
//     WidgetsBinding.instance.addObserver(this);
//     _initConnectivity();
//     fetchCurrentGoldRate();
//     _loadUserData();
//     fetchSupportData(); // fetch support info on init
//   }

//   @override
//   void onClose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.onClose();
//   }

//   /// Format duration into minutes and seconds for display
//   String formatBackgroundTime(Duration duration) {
//     final minutes = duration.inMinutes;
//     final seconds = duration.inSeconds % 60;
    
//     if (minutes > 0) {
//       return '$minutes min ${seconds} sec';
//     } else {
//       return '$seconds sec';
//     }
//   }

//   /// App lifecycle observer for background/foreground tracking
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused) {
//       // App went to background
//       _backgroundStart = DateTime.now();
//       debugPrint('Dashboard: App went to background at $_backgroundStart');
//     } else if (state == AppLifecycleState.resumed) {
//       // App came to foreground
//       if (_backgroundStart != null) {
//         final backgroundDuration = DateTime.now().difference(_backgroundStart!);
//         totalBackgroundTime.value += backgroundDuration;
        
//         final formattedTime = formatBackgroundTime(backgroundDuration);
//         debugPrint('Dashboard: App was in background for $formattedTime');
//         debugPrint('Dashboard: Total background time: ${formatBackgroundTime(totalBackgroundTime.value)}');
        
//         _backgroundStart = null;
//       }
//     }
//   }

//   /// Clear SharedPreferences, GetStorage, and StorageService then navigate to login
//   Future<void> clearAndLogout({bool navigate = true}) async {
//     // Clear SharedPreferences
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.clear();
//     } catch (e) {
//       debugPrint('DashboardController: error clearing SharedPreferences: $e');
//     }

//     // Clear GetStorage
//     try {
//       final box = GetStorage();
//       await box.erase();
//     } catch (e) {
//       debugPrint('DashboardController: error clearing GetStorage: $e');
//     }

//     // Call StorageService erase
//     try {
//       await StorageService().erase();
//     } catch (e) {
//       debugPrint('DashboardController: StorageService.erase() failed: $e');
//     }

//     // Optionally navigate to login / root
//     if (navigate) {
//       userName.value = "";
//       totalBackgroundTime.value = Duration.zero;
//       // Reset attempt counter too (defensive)
//       try {
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setInt('bg_attempt_count', 0);
//         await prefs.setBool('isLoggedIn', false);
//       } catch (_) {}

//       Get.offAllNamed("/login");
//     }
//   }

//   /// ✅ FIXED Connectivity logic for connectivity_plus v6.x
//   Future<void> _initConnectivity() async {
//     try {
//       final List<ConnectivityResult> results = await _connectivity.checkConnectivity();
//       _updateConnectionStatus(results);

//       _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
//         _updateConnectionStatus(results);
//       });
//     } catch (e) {
//       print("Connectivity init error: $e");
//     }
//   }

//   void _updateConnectionStatus(List<ConnectivityResult> results) {
//     isOffline.value = !results.contains(ConnectivityResult.mobile) &&
//         !results.contains(ConnectivityResult.wifi);
//   }

//   /// ✅ Load user data
//   Future<void> _loadUserData() async {
//     try {
//       final name = StorageService().getName();
//       userName.value = name ?? 'User';
//       print('Dashboard User Name: $name');
//     } catch (e) {
//       userName.value = 'User';
//       print('Error loading user name: $e');
//     }
//   }

//   /// ✅ Fetch Gold Rate
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

//       final url = Uri.parse('${BaseUrl.baseUrl}getCurrentRate');
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
//       Get.snackbar('Error', "Please check your internet connection",
//           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
//     } finally {
//       isLoadingRate(false);
//     }
//   }

//   /// ✅ Fetch Support Info API (using getSupport)
//   Future<void> fetchSupportData() async {
//     try {
//       isLoadingSupport(true);

//       if (isOffline.value) return;

//       final url = Uri.parse('${BaseUrl.baseUrl}getSupport');
//       final response = await http.post(url);

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         if (data['data'] != null) {
//           supportMobile.value = data['data']['mobile'] ?? '';
//           supportEmail.value = data['data']['email'] ?? '';
//         }

//         print('Support Data: $data');
//         print('Support Mobile: ${supportMobile.value}');
//         print('Support Email: ${supportEmail.value}');
//       } else {
//         Get.snackbar('Error', 'Failed to fetch support info');
//       }
//     } catch (e) {
//       Get.snackbar('Error', "Please check your internet connection",
//           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
//     } finally {
//       isLoadingSupport(false);
//     }
//   }

//   /// ✅ Navigation
//   void goToPayment() => Get.toNamed(AppRoutes.payment);
//   void goToCatalog() => Get.toNamed(AppRoutes.catalog);
//   void goToGoldCoin() => Get.toNamed(AppRoutes.goldcoin);
//   void goToInvestment() => Get.toNamed(AppRoutes.investment);
//   void goToCoinCatalog() => Get.toNamed(AppRoutes.coin_catalog);
//   void goToGoldCoinpayment() => Get.toNamed(AppRoutes.goldcoinpayment);

//   /// ✅ Logout (same behavior as clearAndLogout)
//   void logout() async {
//     await clearAndLogout(navigate: true);
//   }
// }