// import 'package:aesera_jewels/routes/app_routes.dart';
// import 'package:get/get.dart';

// class DashboardController extends GetxController {
//   void goToBuyGold() => Get.toNamed(AppRoutes.BuyGold);
//   void goToCatalog() => Get.toNamed(AppRoutes.catalog);
//   void goToPortfolio() => Get.toNamed(AppRoutes.portfolio);
// }
import 'package:get/get.dart';

class DashboardController extends GetxController {
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
