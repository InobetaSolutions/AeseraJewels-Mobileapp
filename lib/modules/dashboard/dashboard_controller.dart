

// // // import 'dart:convert';
// // // import 'package:get/get.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'package:aesera_jewels/routes/app_routes.dart';

// // // class DashboardController extends GetxController {
// // //   final name = ''.obs;
// // //   var goldRate = 0.0.obs;
// // //   var isLoadingRate = true.obs;

// // //   @override
// // //   void onInit() {
// // //     super.onInit();
// // //     fetchCurrentGoldRate();
// // //   }

// // //   /// Fetch gold rate from API
// // //   void fetchCurrentGoldRate() async {
// // //     try {
// // //       isLoadingRate(true);
// // //       final url = Uri.parse('http://13.204.96.244:3000/api/getCurrentRate');
// // //       final response = await http.get(url);

// // //       if (response.statusCode == 200) {
// // //         final data = jsonDecode(response.body);
// // //         if (data != null && data['price_gram_24k'] != null) {
// // //           goldRate.value = double.tryParse(data['price_gram_24k'].toString()) ?? 0.0;
// // //         } else {
// // //           Get.snackbar('Error', 'Invalid data from API');
// // //         }
// // //       } else {
// // //         Get.snackbar('Error', 'Failed to fetch gold rate');
// // //       }
// // //     } catch (e) {
// // //       Get.snackbar('Error', e.toString());
// // //     } finally {
// // //       isLoadingRate(false);
// // //     }
// // //   }

// // //   /// Navigation functions
// // //   void goToBuyGold() => Get.toNamed(AppRoutes.buyGold);
// // //   void goToCatalog() => Get.toNamed(AppRoutes.catalog);
// // //   void goToInvestment() => Get.toNamed(AppRoutes.investment);
// // // }
// // import 'dart:convert';
// // import 'package:aesera_jewels/models/gold_rate_model.dart';
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:aesera_jewels/routes/app_routes.dart';
// // //import 'gold_rate_model.dart';

// // class DashboardController extends GetxController {
// //   final name = ''.obs; // dynamic name from Get.arguments
// //   var goldRate = Rxn<GoldRateModel>(); // full model
// //   var isLoadingRate = true.obs;

// //   @override
// //   void onInit() {
// //     super.onInit();

// //     // Take arguments dynamically
// //     final args = Get.arguments;
// //     if (args != null && args['name'] != null) {
// //       name.value = args['name'].toString();
// //     }

// //     fetchCurrentGoldRate();
// //   }

// //   /// Fetch gold rate from API
// //   Future<void> fetchCurrentGoldRate() async {
// //     try {
// //       isLoadingRate(true);
// //       final url = Uri.parse('http://13.204.96.244:3000/api/getCurrentRate');
// //       final response = await http.get(url);

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         goldRate.value = GoldRateModel.fromJson(data);
// //       } else {
// //         Get.snackbar('Error', 'Failed to fetch gold rate');
// //       }
// //     } catch (e) {
// //       Get.snackbar('Error', e.toString());
// //     } finally {
// //       isLoadingRate(false);
// //     }
// //   }

// //   /// Navigation functions
// //   void goToBuyGold() => Get.toNamed(AppRoutes.buyGold);
// //   void goToCatalog() => Get.toNamed(AppRoutes.catalog);
// //   void goToInvestment() => Get.toNamed(AppRoutes.investment);
// // }
// import 'dart:convert';
// import 'package:aesera_jewels/models/gold_rate_model.dart';
// import 'package:aesera_jewels/routes/app_routes.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class DashboardController extends GetxController {
//   var goldRate = Rxn<GoldRateModel>();
//   final name = ''.obs; 
//   var isLoadingRate = true.obs;

//   @override
//   void onInit() {
//     super.onInit();
//       userName.value = storage.read("userName") ?? "";
//     final args = Get.arguments;
//     if (args != null && args['name'] != null) {
//       name.value = args['name'].toString();
//     }
//     fetchCurrentGoldRate();
//   }
// void logout() {
//     storage.erase(); // clear all storage
//     userName.value = "";
//   /// Fetch gold rate from API
//   Future<void> fetchCurrentGoldRate() async {
//     try {
//       isLoadingRate(true);
//       final url = Uri.parse('http://13.204.96.244:3000/api/getCurrentRate');
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         goldRate.value = GoldRateModel.fromJson(data);
//       } else {
//         Get.snackbar('Error', 'Failed to fetch gold rate');
//       }
//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//     } finally {
//       isLoadingRate(false);
//     }
//   }

//   /// Navigation functions
//   void goToBuyGold() => Get.toNamed(AppRoutes.buyGold);
//   void goToCatalog() => Get.toNamed(AppRoutes.catalog);
//   void goToInvestment() => Get.toNamed(AppRoutes.investment);
// }
//   /// Logout user
//   void logout() {
//     storage.erase(); // clear all storage
//     userName.value = "";

//  Get.offAllNamed("/");
//   }

//   final storage = GetStorage();
//   var userName = ''.obs;

//   void loadUser() {
//     userName.value = storage.read("userName") ?? "";
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
    StorageService.erase(); // clear all storage
    userName.value = "";
    Get.offAllNamed("/"); // back to login/onboarding
  }
}
//   }