import 'package:aesera_jewels/modules/welcome_screen2/made_gold_easy_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MadeGoldEasyScreen extends GetWidget<MadeGoldEasyController> {
  const MadeGoldEasyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// Image & Skip Button
            Stack(
              children: [
                Image.asset(
                  "assets/images/Depth 2, Frame 0.png",
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.60,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: ElevatedButton(
                    onPressed: controller.skipRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    "Saving in Gold Made Easy",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A2A4D),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Start building wealth with ease - saving in\n gold mode simple, accessible and hassle-free.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Colors.black45),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [_dot(), _dot(isActive: true), _dot()],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: controller.goToJewelsForOccasion,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0A2A4D),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _dot({bool isActive = false}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    width: isActive ? 18 : 10,
    height: 10,
    decoration: BoxDecoration(
      color: isActive ? Colors.black : Colors.black26,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Skip Button
//             Align(
//               alignment: Alignment.topRight,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 16, right: 16),
//                 child: TextButton(
//                   onPressed: controller.skipOnboarding,
//                   style: TextButton.styleFrom(
//                     backgroundColor: Colors.grey.shade200,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Text(
//                     'Skip',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 30),

//             // Image
//             Image.asset(
//               'assets/images/Depth 2, Frame 0.png', // Replace with your image
//               height: 280,
//               fit: BoxFit.contain,
//             ),
//             SizedBox(height: 30),

//             // Heading
//             Text(
//               'Saving in Gold Made Easy',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: 12),

//             // Subtext
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Text(
//                 'Start building wealth with ease - saving in gold mode simple, accessible and hassle-free.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 14, color: Colors.black54),
//               ),
//             ),
//             Spacer(),

//             // Dots Indicator
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 6,
//                   width: 6,
//                   decoration: BoxDecoration(
//                     color: Colors.grey,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//                 SizedBox(width: 6),
//                 Container(
//                   height: 6,
//                   width: 18,
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//                 SizedBox(width: 6),
//                 Container(
//                   height: 6,
//                   width: 6,
//                   decoration: BoxDecoration(
//                     color: Colors.grey,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 24),

//             // Next Button
//             Padding(
//               padding: const EdgeInsets.only(bottom: 40),
//               child: InkWell(
//                 onTap: controller.goToJewelsForOccasion,
//                 child: Container(
//                   height: 60,
//                   width: 60,
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Icons.arrow_forward,
//                     color: Colors.white,
//                     size: 28,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
