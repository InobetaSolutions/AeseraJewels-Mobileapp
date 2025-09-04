import 'dart:convert';
import 'package:aesera_jewels/models/gold_rate_model.dart';
import 'package:aesera_jewels/routes/app_routes.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:connectivity_plus/connectivity_plus.dart';

class DashboardController extends GetxController {
  var goldRate = Rxn<GoldRateModel>();
  var isLoadingRate = true.obs;
  var userName = ''.obs;
  var isOffline = false.obs; // ✅ track connectivity

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
    fetchCurrentGoldRate();
    loadUserName();
  }

Future<void> _initConnectivity() async {
  final connectivityResults = await Connectivity().checkConnectivity(); // already List<ConnectivityResult>
  _updateConnectionStatus(connectivityResults);

  Connectivity().onConnectivityChanged.listen((results) {
    _updateConnectionStatus(results);
  });
}

void _updateConnectionStatus(List<ConnectivityResult> results) {
  // Offline only if *all* results are "none"
  if (results.every((r) => r == ConnectivityResult.none)) {
    isOffline(true);
  } else {
    isOffline(false);
  }
}


  Future<void> loadUserName() async {
    final name = await StorageService.getUserName();
    userName.value = name ?? "";
  }

  /// Fetch gold rate from API
  Future<void> fetchCurrentGoldRate() async {
    try {
      isLoadingRate(true);

      if (isOffline.value) {
        /// Load from storage if offline
        final savedRate = await StorageService.getGoldRate();
        if (savedRate != null) {
          goldRate.value = GoldRateModel(
            id: "cached", // dummy id for offline
            timestamp: DateTime.now().millisecondsSinceEpoch,
            priceGram24k: double.parse(savedRate),
            istDate: DateTime.now().toString(),
          );
        }
        return;
      }

      final url = Uri.parse('http://13.204.96.244:3000/api/getCurrentRate');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        goldRate.value = GoldRateModel.fromJson(data);

        // ✅ Save gold rate locally
        if (goldRate.value != null) {
          await StorageService.saveGoldRate(
            goldRate.value!.priceGram24k.toString(),
          );
        }

        print('Fetched Gold Rate: ${goldRate.value!.priceGram24k}');
      } else {
        Get.snackbar('Error', 'Failed to fetch gold rate');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoadingRate(false);
    }
  }

  /// Navigation functions
  void goToPayment() => Get.toNamed(AppRoutes.payment);
  void goToCatalog() => Get.toNamed(AppRoutes.catalog);
  void goToInvestment() => Get.toNamed(AppRoutes.investment);

  /// Logout user
  void logout() {
    final storageService = StorageService();
    storageService.erase(); // clear all storage
    userName.value = "";
    Get.offAllNamed("/"); // back to login/onboarding
  }
}
