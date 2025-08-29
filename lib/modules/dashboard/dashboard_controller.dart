// // import 'package:aesera_jewels/routes/app_routes.dart';
// // import 'package:get/get.dart';

// // class DashboardController extends GetxController {
// //   void goToBuyGold() => Get.toNamed(AppRoutes.BuyGold);
// //   void goToCatalog() => Get.toNamed(AppRoutes.catalog);
// //   void goToPortfolio() => Get.toNamed(AppRoutes.portfolio);
// // }
// import 'package:get/get.dart';

// class DashboardController extends GetxController {
//   void goToBuyGold() {
//     Get.toNamed('/buy_gold');
//   }

//   void goToCatalog() {
//     Get.toNamed('/catalog');
//   }

//   void goToInvestment() {
//     Get.toNamed('/investment');
//   }
// }
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class DashboardController extends GetxController {
  var goldRate = 0.0.obs;
  var isLoadingRate = true.obs;

  @override
  void onInit() {
    fetchCurrentGoldRate();
  }

  void fetchCurrentGoldRate() async {
    try {
      isLoadingRate(true);
      final url = Uri.parse('http://13.204.96.244:3000/api/getCurrentRate');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        goldRate.value = data['price_gram_24k'];
      } else {
        Get.snackbar('Error', 'Failed to fetch gold rate');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoadingRate(false);
    }
  }

  void goToBuyGold() {
    Get.toNamed('/buy_gold');
  }

  void goToCatalog() {
    Get.toNamed('/catalog');
  }

  void goToInvestment() {
    Get.toNamed('/investment');
  }
}
