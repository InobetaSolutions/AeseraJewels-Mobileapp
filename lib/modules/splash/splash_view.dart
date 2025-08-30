// // ignore_for_file: deprecated_member_use

// import 'package:aesera_jewels/modules/splash/splash_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_view.dart';

// class SplashView extends GetWidget<SplashController> {            
//   SplashView({Key? key}) : super(key: key);
//   final SplashController controller = Get.put(SplashController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image.asset(
//             'assets/images/color patten 1.png', // Replace with your background image
//             fit: BoxFit.cover,
//           ),
//           Center(
//             child: Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.3),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Image.asset(
//                 'assets/images/splash logo.png', // Replace with your logo image
//                 width: 145,
//                 height: 145,
//                 fit: BoxFit.contain,
//               ),
              
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:aesera_jewels/modules/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject controller
    Get.put(SplashController());

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/color patten 1.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                'assets/images/splash logo.png',
                width: 145,
                height: 145,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
