
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'scan_to_pay_controller.dart';

// class ScanToPayScreen extends GetWidget<ScanToPayController> {
//   final controller = Get.put(ScanToPayController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF9F4FA),
//       appBar: AppBar(
//         backgroundColor: Color(0xFFF9F4FA),
//         elevation: 0,
//         leading: BackButton(color: Colors.black),
//         centerTitle: true,
//         title: Text("Scan to pay", style: TextStyle(color: Colors.black)),
//       ),
//       body: SingleChildScrollView(
//         // Wrapping body in SingleChildScrollView
//         padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 16),
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "Scan this QR to Complete your\npurchase of gold",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//             const SizedBox(height: 40),
//             Container(
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: Color(0xFF0A2A4D),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Image.asset(
//                 'assets/images/qr 1.png', // Make sure this path is correct in pubspec.yaml
//                 width: 200,
//                 height: 200,
//               ),
//             ),
//             const SizedBox(height: 30), // Added space for button
//             Obx(
              
//               () => ElevatedButton(
//                 onPressed: controller.onProceed,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: controller.paymentCompleted.value
//                       ? Colors.grey[800]
//                       : const Color(0xFF0A2A4D),
//                   shape: const StadiumBorder(),
//                   minimumSize: const Size(double.infinity, 52),
//                 ),
//                 child: const Text(
//                   "Proceed",
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'scan_to_pay_controller.dart';

class ScanToPayScreen extends StatelessWidget {
  final ScanToPayController controller = Get.put(ScanToPayController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan to Pay"), leading: const BackButton()),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Scan this QR to Complete your purchase of gold"),
          const SizedBox(height: 20),
          // Container(
          //   padding: const EdgeInsets.all(20),
          //   color: Colors.indigo.shade900,
          //   child: const SizedBox(
          //     width: 200,
          //     height: 200,
          //     child: Placeholder(), // replace with QR widget
          //   ),
          // ),
           Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Color(0xFF0A2A4D),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(
                'assets/images/qr 1.png', // Make sure this path is correct in pubspec.yaml
                width: 200,
                height: 200,
              ),
            ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: controller.downloadQR, child: const Text("Download QR")),
              const SizedBox(width: 12),
              ElevatedButton(onPressed: controller.shareQR, child: const Text("Share QR")),
            ],
          ),
        ],
      ),
    );
  }
}
