// import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
// import 'package:aesera_jewels/modules/onboard/onboard_view.dart';
// import 'package:aesera_jewels/routes/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   final prefs = await SharedPreferences.getInstance();
//   final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

//   runApp(MyApp(isLoggedIn: isLoggedIn));
// }

// class MyApp extends StatelessWidget {
//   final bool isLoggedIn;
//   const MyApp({super.key, required this.isLoggedIn});


//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Aesera Jewels',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Roboto', // optional
//       ),
//       initialRoute: AppRoutes.splash,
//       getPages: AppRoutes.routes,
//      home: isLoggedIn ?  DashboardScreen() :  OnboardingScreen(), 
//     );
    
//   }
// }
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await GetStorage.init();
// //   runApp(MyApp());

import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
import 'package:aesera_jewels/modules/onboard/onboard_view.dart';
import 'package:aesera_jewels/routes/app_routes.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// ✅ Initialize GetStorage
  await GetStorage.init();

  /// ✅ Register StorageService globally
  Get.put(StorageService());

  /// ✅ Check login state from SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aesera Jewels',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,

      /// ✅ Choose home based on login state
      home: isLoggedIn ? DashboardScreen() : OnboardingScreen(),
    );
  }
}
