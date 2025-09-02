
import 'dart:convert';
import 'package:aesera_jewels/models/gold_rate_model.dart';
import 'package:aesera_jewels/routes/app_routes.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DashboardController extends GetxController {
  var goldRate = Rxn<GoldRateModel>();
  var isLoadingRate = true.obs;
  var userName = ''.obs;


  @override
  void onInit() {
    super.onInit();
   
    fetchCurrentGoldRate();loadUserName();
  }

  Future<void> loadUserName() async {
    final name = await StorageService.getUserName();
    userName.value = name ?? "";
  }

  /// Fetch gold rate from API
  Future<void> fetchCurrentGoldRate() async {
    try {
      isLoadingRate(true);
      final url = Uri.parse('http://13.204.96.244:3000/api/getCurrentRate');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        goldRate.value = GoldRateModel.fromJson(data);
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
  void goToBuyGold() => Get.toNamed(AppRoutes.buyGold);
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
//   }