// // import 'package:aesera_jewels/modules/onboard/onboard_controller.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';


// // class OnboardingScreen extends GetWidget<OnboardingController> {
// //   final OnboardingController controller = Get.put(OnboardingController());

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: SafeArea(
// //         child: SizedBox(
// //           width: 390,
// //           height: 844,
// //           child: Column(
// //             children: [
// //               /// PageView with 3 screens
// //               Expanded(
// //                 child: PageView(
// //                   controller: controller.pageController,
// //                   onPageChanged: controller.onPageChanged,
// //                   children: [
// //                     _buildPage(
// //                       image: "assets/images/Depth 3, Frame 0.png",
// //                       title: "Easy and Seamless Payments",
// //                       subtitle:
// //                           "Secure your financial future with gold\n effortless saving made easy and seamless.",
// //                       skipAction: controller.skipOnboarding,
// //                     ),
// //                     _buildPage(
// //                       image: "assets/images/Depth 2, Frame 0.png",
// //                       title: "Saving in Gold Made Easy",
// //                       subtitle:
// //                           "Start building wealth with ease - saving in\n gold made simple, accessible and hassle-free.",
// //                       skipAction: controller.skipOnboarding,
// //                     ),
// //                     _buildPage(
// //                       image: "assets/images/Depth 4, Frame 0.png",
// //                       title: "Jewellery for Every Occasion",
// //                       subtitle:
// //                           "Turn your savings into beautiful jewellery with ease.",
// //                       skipAction: controller.skipOnboarding,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               SizedBox(height: 10),
// //               /// Dots + Forward Arrow
// //               Padding(
// //                 padding: const EdgeInsets.only(bottom: 30),
// //                 child: Column(
// //                   children: [
                  
// //                     Obx(() => Row(
// //                           mainAxisAlignment: MainAxisAlignment.center,
                        
// //                           children:
// //                            List.generate(
// //                             3,
// //                             (index) => _dot(
// //                               isActive: controller.currentPage.value == index,
// //                             ),
// //                           ),
// //                         )),
// //                     const SizedBox(height: 22),
// //                     GestureDetector(
// //                       onTap: controller.goToNextPage,
// //                       child: Container(
// //                         width: 60,
// //                         height: 60,
// //                         decoration: const BoxDecoration(
// //                           color: Color(0xFF0A2A4D),
// //                           shape: BoxShape.circle,
// //                         ),
// //                         child: const Icon(
// //                           Icons.arrow_forward,
// //                           color: Colors.white,
// //                           size: 32,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   /// Reusable Onboarding Page
// //   Widget _buildPage({
// //     required String image,
// //     required String title,
// //     required String subtitle,
// //     required VoidCallback skipAction,
// //   }) {
// //     return Column(
// //       children: [
// //         /// Image + Skip Button
// //         Stack(
// //           children: [
// //             Image.asset(
// //               image,
// //               width: 390,
// //               height: 450,
// //               fit: BoxFit.cover,
// //             ),
// //             Positioned(
// //               top: 16,
// //               right: 16,
// //               child: SizedBox(
// //                 width: 54,
// //                 height: 33,
// //                 child: ElevatedButton(
// //                   onPressed: skipAction,
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.white,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                     padding:
// //                         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                     elevation: 0,
// //                   ),
// //                   child: const Text(
// //                     'Skip',
// //                     style: TextStyle(
// //                       fontFamily: 'Manrope',
// //                       fontSize: 16,
// //                       color: Colors.black,
// //                       fontWeight: FontWeight.w700,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 25),

// //         /// Title & Subtitle
// //         Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
// //           child: Column(
// //             children: [
// //               Text(
// //                 title,
// //                 textAlign: TextAlign.center,
// //                 style: const TextStyle(
// //                   fontSize: 23,
// //                   fontFamily: 'Lexend',
// //                   fontWeight: FontWeight.w700,
// //                   color: Color(0xFF0A2A4D),
// //                 ),
// //               ),
// //               const SizedBox(height: 8),
// //               Text(
// //                 subtitle,
// //                 textAlign: TextAlign.center,
// //                 style: const TextStyle(
// //                   fontSize: 14,
// //                   fontFamily: 'Lexend',
// //                   fontWeight: FontWeight.w400,
// //                   color: Colors.black,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // /// Dot Indicator

// // Widget _dot({bool isActive = false}) {
// //   return Container(
// //     margin: const EdgeInsets.symmetric(horizontal: 4),
// //     width: isActive ? 20 : 10,
// //     height: 8,
// //     decoration: BoxDecoration(
// //       color: isActive ? Colors.black : Colors.black26,
// //       borderRadius: BorderRadius.circular(10),
// //     ),
// //   );
// // }
// import 'package:aesera_jewels/modules/onboard/onboard_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class OnboardingScreen extends GetWidget<OnboardingController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             /// PageView with 3 screens
//             Expanded(
//               child: PageView(
//                 controller: controller.pageController,
//                 onPageChanged: controller.onPageChanged,
//                 children: [
//                   _buildPage(
//                     image: "assets/images/Depth 3, Frame 0.png",
//                     title: "Easy and Seamless Payments",
//                     subtitle:
//                         "Secure your financial future with gold\n effortless saving made easy and seamless.",
//                     skipAction: controller.skipOnboarding,
//                   ),
//                   _buildPage(
//                     image: "assets/images/Depth 2, Frame 0.png",
//                     title: "Saving in Gold Made Easy",
//                     subtitle:
//                         "Start building wealth with ease - saving in\n gold made simple, accessible and hassle-free.",
//                     skipAction: controller.skipOnboarding,
//                   ),
//                   _buildPage(
//                     image: "assets/images/Depth 4, Frame 0.png",
//                     title: "Jewellery for Every Occasion",
//                     subtitle:
//                         "Turn your savings into beautiful jewellery with ease.",
//                     skipAction: controller.skipOnboarding,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 11),

//             /// Dot Indicators + Forward Button
//             Padding(
//               padding: const EdgeInsets.only(bottom: 30),
//               child: Column(
//                 children: [
//                   Obx(() => Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(
//                           3,
//                           (index) => _dot(
//                             isActive: controller.currentPage.value == index,
//                           ),
//                         ),
//                       )),
//                   const SizedBox(height: 22),
//                   GestureDetector(
//                     onTap: controller.goToNextPage,
//                     child: CircleAvatar(
//                       radius: 32,
//                       backgroundColor: Color(0xFF09243D),
//                       child:  Icon(
//                         Icons.arrow_forward_rounded,
//                         color: Colors.white,
//                         size: 32,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Reusable Onboarding Page
//   Widget _buildPage({
//     required String image,
//     required String title,
//     required String subtitle,
//     required VoidCallback skipAction,
//   }) {
//     return Column(
//       children: [
//         /// Image + Skip Button
//         Stack(
//           children: [
//             Image.asset(
//               image,
//               width: double.infinity,
//               height: 446,
//               fit: BoxFit.cover,
//             ),
//             Positioned(
//               top: 16,
//               right: 16,
//               child: SizedBox(
//                 width: 54,
//                 height: 33,
//                 child: ElevatedButton(
//                   onPressed: skipAction,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     elevation: 0,
//                   ),
//                   child:  Text(
//                     'Skip',
//                     style: GoogleFonts.manrope(
//                       fontSize: 16,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w700,
//                     ),
//                     // style: TextStyle(
//                     //   fontFamily: 'Manrope',
//                     //   fontSize: 16,
//                     //   color: Colors.black,
//                     //   fontWeight: FontWeight.w700,
//                     // ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),

//         /// Title & Subtitle with flexible space
//         Expanded(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
            
//             children: [
//               SizedBox(height:6),
//               Text(
//                 title,
//                 textAlign: TextAlign.center,
//                 style: AppTextStyles.title,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 subtitle,
//                 textAlign: TextAlign.center,
//                 style: AppTextStyles.subtitle,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   /// Dot Indicator
//   Widget _dot({bool isActive = false}) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       width: isActive ? 24: 8,
//       height: 8,
//       decoration: BoxDecoration(
//         color: isActive ? Colors.black : Colors.black26,
//         borderRadius: BorderRadius.circular(10),
//       ),
//     );
//   }
// }

// /// Centralized TextStyles
// class AppTextStyles {
//   static final TextStyle title = GoogleFonts.lexend(
//     fontSize: 22, // Adjusted for smaller screens
//     fontWeight: FontWeight.w700,
//     fontStyle: FontStyle.normal,
//     color: const Color(0xFF120D1C),
//   );  
//   static final TextStyle subtitle = GoogleFonts.lexend(
//     fontSize: 14,
//     fontStyle: FontStyle.normal,
//     fontWeight: FontWeight.w400,
//     color: Color(0xFF120D1C),
//   );  
//    static const TextStyle titleAlt = TextStyle(
//     fontSize: 20, 
//     fontFamily: 'Lexend',
//     fontWeight: FontWeight.w700,
//     color: Color(0xFF0A2A4D),
//   );

//   static const TextStyle subtitleAlt = TextStyle(
//     fontSize: 13, // Slightly reduced to prevent overflow
//     fontFamily: 'Lexend',
//     fontWeight: FontWeight.w400,
//     color: Colors.black,
//  );
// }
import 'package:aesera_jewels/modules/onboard/onboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends GetWidget<OnboardingController> {
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: [
                  _buildPage(
                    image: "assets/images/Depth 3, Frame 0.png",
                    title: "Easy and Seamless Payments",
                    subtitle:
                        "Secure your financial future with gold\n effortless saving made easy and seamless.",
                    skipAction: controller.skipOnboarding,
                  ),
                  _buildPage(
                    image: "assets/images/Depth 2, Frame 0.png",
                    title: "Saving in Gold Made Easy",
                    subtitle:
                        "Start building wealth with ease - saving in\n gold made simple, accessible and hassle-free.",
                    skipAction: controller.skipOnboarding,
                  ),
                  _buildPage(
                    image: "assets/images/Depth 4, Frame 0.png",
                    title: "Jewellery for Every Occasion",
                    subtitle:
                        "Turn your savings into beautiful jewellery with ease.",
                    skipAction: controller.skipOnboarding,
                  ),
                ],
              ),
            ),

            /// Dots + Next Button
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => _dot(
                            isActive: controller.currentPage.value == index,
                          ),
                        ),
                      )),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: controller.goToNextPage,
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: const Color(0xFF09243D),
                      child: const Icon(Icons.arrow_forward, color: Colors.white, size: 32),
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

  Widget _buildPage({
    required String image,
    required String title,
    required String subtitle,
    required VoidCallback skipAction,
  }) {
    return Column(
      children: [
        Stack(
          children: [
            Image.asset(image, width: double.infinity, height: 446, fit: BoxFit.cover),
            Positioned(
              top: 16,
              right: 16,
              child: ElevatedButton(
                onPressed: skipAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  elevation: 0,
                ),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Manrope',
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Text(title,
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF120D1C))),
        const SizedBox(height: 8),
        Text(subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black)),
      ],
    );
  }

  Widget _dot({bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.black26,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
