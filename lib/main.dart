

import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
import 'package:aesera_jewels/modules/onboard/onboard_view.dart';
import 'package:aesera_jewels/routes/app_routes.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// ✅ Lock orientation to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
      title: 'GoldPoint',
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

// import 'dart:io';
// import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
// import 'package:aesera_jewels/modules/onboard/onboard_view.dart';
// import 'package:aesera_jewels/routes/app_routes.dart';
// import 'package:aesera_jewels/services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Lock orientation to portrait only
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);

//   // Initialize storage
//   await GetStorage.init();
//   Get.put(StorageService());

//   // Check login state from SharedPreferences (no change)
//   final prefs = await SharedPreferences.getInstance();
//   final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

//   runApp(MyApp(isLoggedIn: isLoggedIn));
// }

// class MyApp extends StatefulWidget {
//   final bool isLoggedIn;
//   const MyApp({super.key, required this.isLoggedIn});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// ///
// /// Enhanced Lifecycle logic:
// /// - Calculate background time in minutes and seconds
// /// - Show formatted time like "1 min 4 sec" or "50 sec"
// /// - Attempts allowed: 2. On 3rd attempt we wipe data and send user to login
// /// - Popups only show after login, not before login
// ///
// class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
//   DateTime? _backgroundStart; // when app went to background
//   bool _dialogShownForThisResume = false; // avoid duplicate dialogs

//   static const String _kAttemptKey = 'bg_attempt_count';

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   /// Clear SharedPreferences, GetStorage and StorageService
//   Future<void> _clearAllData() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.clear();
//     } catch (e) {
//       debugPrint('Error clearing SharedPreferences: $e');
//     }

//     try {
//       final box = GetStorage();
//       await box.erase();
//     } catch (e) {
//       debugPrint('Error clearing GetStorage: $e');
//     }

//     try {
//       await StorageService().erase();
//     } catch (e) {
//       debugPrint('Error calling StorageService.erase(): $e');
//     }
//   }

//   /// Format duration into minutes and seconds
//   String _formatDuration(Duration duration) {
//     final minutes = duration.inMinutes;
//     final seconds = duration.inSeconds % 60;
    
//     if (minutes > 0) {
//       return '$minutes min ${seconds} sec';
//     } else {
//       return '$seconds sec';
//     }
//   }

//   /// Show the themed, centered dialog with formatted time
//   void _showCenteredAutoDismissDialog(String title, String message, {int seconds = 3}) {
//     if (Get.context == null) return;

//     // Use a short delay so the app's routing/context has settled (especially after navigation)
//     Future.delayed(const Duration(milliseconds: 200), () {
//       try {
//         showDialog(
//           context: Get.context!,
//           barrierDismissible: false, // user cannot dismiss
//           builder: (ctx) {
//             // Build a dialog that matches the dashboard theme (dark background)
//             return WillPopScope(
//               onWillPop: () async => false, // prevent back button
//               child: AlertDialog(
//                 backgroundColor:  const Color(0xFFFFB700),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 title: Text(
//                   title,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                     fontFamily: 'Roboto',
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 content: Text(
//                   message,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 15,
//                     fontFamily: 'Roboto',
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 // no actions (no OK button) as requested
//               ),
//             );
//           },
//         );

//         // Dismiss automatically after [seconds]
//         Future.delayed(Duration(seconds: seconds), () {
//           try {
//             if (Navigator.canPop(Get.context!)) {
//               Navigator.of(Get.context!).pop();
//             }
//           } catch (e) {
//             debugPrint('Error closing dialog: $e');
//           }
//         });
//       } catch (e) {
//         debugPrint('Dialog show error: $e');
//       }
//     });
//   }

//   /// Check if user is logged in (has valid session)
//   Future<bool> _isUserLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('isLoggedIn') ?? false;
//   }

//   /// Called on lifecycle changes.
//   /// - On paused: record background timestamp
//   /// - On resumed: if we have a background timestamp, count one attempt, show dialog with formatted time or force logout
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {
//     super.didChangeAppLifecycleState(state);

//     if (state == AppLifecycleState.paused) {
//       _backgroundStart = DateTime.now();
//       _dialogShownForThisResume = false;
//       debugPrint('App paused at $_backgroundStart');
//       return;
//     }

//     if (state == AppLifecycleState.resumed) {
//       debugPrint('App resumed');
      
//       // Only act when we had a background timestamp and haven't shown dialog for this resume
//       if (_backgroundStart != null && !_dialogShownForThisResume) {
//         _dialogShownForThisResume = true;

//         // Check if user is logged in before showing any popups
//         final isLoggedIn = await _isUserLoggedIn();
        
//         if (!isLoggedIn) {
//           debugPrint('User not logged in, skipping background attempt check');
//           _backgroundStart = null;
//           return;
//         }

//         final prefs = await SharedPreferences.getInstance();
//         int attempt = prefs.getInt(_kAttemptKey) ?? 0;
//         attempt++; // count this full cycle
//         await prefs.setInt(_kAttemptKey, attempt);

//         final duration = DateTime.now().difference(_backgroundStart!);
//         final formattedTime = _formatDuration(duration);

//         debugPrint('Background attempt: $attempt, User logged in: $isLoggedIn');

//         // If attempt < 3 => show dialog and continue (only if logged in)
//         if (attempt < 3) {
//           final title = 'Security Alert!';
//           final message = 'Attempt: $attempt of 3\n'
//                           'App was away from foreground for:\n'
//                           '$formattedTime';
//           _showCenteredAutoDismissDialog(title, message, seconds: 4);
//         } else {
//           // attempt >= 3 => IMMEDIATE CLEAR + NAVIGATE TO LOGIN SCREEN (not onboard)
//           await _clearAllData();

//           // Reset attempt counter to 0 after wiping (so next login starts fresh)
//           try {
//             final resetPrefs = await SharedPreferences.getInstance();
//             await resetPrefs.setInt(_kAttemptKey, 0);
//             await resetPrefs.setBool('isLoggedIn', false);
//           } catch (_) {}

//           // Immediately navigate to LOGIN SCREEN (not onboard)
//           Get.offAllNamed("/login");

//           // Show the popup on login screen (short delay to allow navigation)
//           Future.delayed(const Duration(milliseconds: 400), () {
//             _showCenteredAutoDismissDialog(
//               'Session Terminated',
//               'Maximum security attempts reached!\n'
//               'You exceeded the allowed background attempts.\n'
//               'Please login again to continue.',
//               seconds: 4,
//             );
//           });
//         }

//         // Reset background start to avoid double triggers
//         _backgroundStart = null;
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'GoldPoint',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Roboto',
//       ),
//       initialRoute: AppRoutes.splash,
//       getPages: AppRoutes.routes,
//       home: widget.isLoggedIn ? DashboardScreen() : OnboardingScreen(),
//     );
//   }
// }