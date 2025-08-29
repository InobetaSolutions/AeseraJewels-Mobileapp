

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:aesera_jewels/routes/app_routes.dart';

class DashboardController extends GetxController {
  /// Observables
  var goldRate = 0.0.obs;
  var isLoadingRate = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentGoldRate();
  }

  /// Fetch gold rate from API
  void fetchCurrentGoldRate() async {
    try {
      isLoadingRate(true);
      final url = Uri.parse('http://13.204.96.244:3000/api/getCurrentRate');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null && data['price_gram_24k'] != null) {
          goldRate.value = double.tryParse(data['price_gram_24k'].toString()) ?? 0.0;
        } else {
          Get.snackbar('Error', 'Invalid data from API');
        }
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
}
