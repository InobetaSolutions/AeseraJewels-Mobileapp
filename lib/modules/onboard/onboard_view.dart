
// // import 'package:aesera_jewels/modules/onboard/onboard_controller.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';

// // class OnboardingScreen extends GetWidget<OnboardingController> {
// //   final OnboardingController controller = Get.put(OnboardingController());

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             Expanded(
// //               child: PageView(
// //                 controller: controller.pageController,
// //                 onPageChanged: controller.onPageChanged,
// //                 children: [
// //                   _buildPage(
// //                     image: "assets/images/Depth 3, Frame 0.png",
// //                     title: "Easy and Seamless Payments",
// //                     subtitle:
// //                         "Secure your financial future with gold\n effortless saving made easy and seamless.",
// //                     skipAction: controller.skipOnboarding,
// //                   ),
// //                   _buildPage(
// //                     image: "assets/images/Depth 2, Frame 0.png",
// //                     title: "Saving in Gold Made Easy",
// //                     subtitle:
// //                         "Start building wealth with ease - saving in\n gold made simple, accessible and hassle-free.",
// //                     skipAction: controller.skipOnboarding,
// //                   ),
// //                   _buildPage(
// //                     image: "assets/images/Depth 4, Frame 0.png",
// //                     title: "Jewellery for Every Occasion",
// //                     subtitle:
// //                         "Turn your savings into beautiful jewellery with ease.",
// //                     skipAction: controller.skipOnboarding,
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             /// Dots + Next Button
// //             Padding(
// //               padding: const EdgeInsets.only(bottom: 30),
// //               child: Column(
// //                 children: [
// //                   Obx(() => Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: List.generate(
// //                           3,
// //                           (index) => _dot(
// //                             isActive: controller.currentPage.value == index,
// //                           ),
// //                         ),
// //                       )),
// //                   const SizedBox(height: 20),
// //                   GestureDetector(
// //                     onTap: controller.goToNextPage,
// //                     child: CircleAvatar(
// //                       radius: 32,
// //                       backgroundColor: const Color(0xFF09243D),
// //                       child: const Icon(Icons.arrow_forward, color: Colors.white, size: 32),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildPage({
// //     required String image,
// //     required String title,
// //     required String subtitle,
// //     required VoidCallback skipAction,
// //   }) {
// //     return Column(
// //       children: [
// //         Stack(
// //           children: [
// //             Image.asset(image, width: double.infinity, height: 446, fit: BoxFit.cover),
// //             Positioned(
// //               top: 16,
// //               right: 16,
// //               child: ElevatedButton(
// //                 onPressed: skipAction,
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.white,
// //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// //                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                   elevation: 0,
// //                 ),
// //                 child: const Text(
// //                   'Skip',
// //                   style: TextStyle(
// //                     fontSize: 16,
// //                     fontFamily: 'Manrope',
// //                     color: Colors.black,
// //                     fontWeight: FontWeight.w700,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 25),
// //         Text(title,
// //             textAlign: TextAlign.center,
// //             style: GoogleFonts.lexend(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF120D1C))),
// //         const SizedBox(height: 8),
// //         Text(subtitle,
// //             textAlign: TextAlign.center,
// //             style: GoogleFonts.lexend(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black)),
// //       ],
// //     );
// //   }

// //   Widget _dot({bool isActive = false}) {
// //     return Container(
// //       margin: const EdgeInsets.symmetric(horizontal: 4),
// //       width: isActive ? 24 : 8,
// //       height: 8,
// //       decoration: BoxDecoration(
// //         color: isActive ? Colors.black : Colors.black26,
// //         borderRadius: BorderRadius.circular(10),
// //       ),
// //     );
// //   }
// // }
// import 'package:aesera_jewels/modules/onboard/onboard_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class OnboardingScreen extends GetWidget<OnboardingController> {
//   final OnboardingController controller = Get.put(OnboardingController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: PageView(
//                 controller: controller.pageController,
//                 onPageChanged: controller.onPageChanged,
//                 children: [
//                   _buildPage(
//                     image: "assets/images/Depth 3, Frame 0.png",
//                     title: "Your trusted Gold Savings App.",
//                     subtitle: "A product of",
//                     company: "Aesera Jewellers Pvt Ltd.",
//                     skipAction: controller.skipOnboarding,
//                   ),
//                   _buildPage(
//                     image: "assets/images/onboard image 2.png",
//                     title: "Gold has been a great Wallet centuries.",
//                     subtitle: "GoldPoint makes it easy to Wallet in Gold!",
//                     company: "",
//                     skipAction: controller.skipOnboarding,
//                   ),
//                   _buildPage(
//                     image: "assets/images/onboard image3.png",
//                     title: "GILDAN",
//                     subtitle: "A simple, secure, and\nconvenient way to Wallet..",
//                     company: "Start investing now!",
//                     skipAction: controller.skipOnboarding,
//                   ),
//                 ],
//               ),
//             ),

//             /// Dots + Next Button
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
//                   const SizedBox(height: 20),
//                   GestureDetector(
//                     onTap: controller.goToNextPage,
//                     child: CircleAvatar(
//                       radius: 32,
//                       backgroundColor: const Color(0xFF09243D),
//                       child: const Icon(Icons.arrow_forward, color: Colors.white, size: 32),
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

//   Widget _buildPage({
//     required String image,
//     required String title,
//     required String subtitle,
//     required String company,
//     required VoidCallback skipAction,
//   }) {
//     return Column(
//       children: [
//         Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Image.asset(image, width: double.infinity, height: 446, fit: BoxFit.contain),
//             ),
//             Positioned(
//               top: 16,
//               right: 16,
//               child: ElevatedButton(
//                 onPressed: skipAction,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   elevation: 0,
//                 ),
//                 child: const Text(
//                   'Skip',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontFamily: 'Manrope',
//                     color: Colors.black,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 25),
//         Text(title,
//             textAlign: TextAlign.center,
//             style: GoogleFonts.lexend(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF120D1C))),
//         const SizedBox(height: 8),
//         Text(subtitle,
//             textAlign: TextAlign.center,
//             style: GoogleFonts.lexend(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black)),
//         if (company.isNotEmpty) ...[
//           const SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Text(company,
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.lexend(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white)),
//           ),
//         ],
//       ],
//     );
//   }

//   Widget _dot({bool isActive = false}) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       width: isActive ? 24 : 8,
//       height: 8,
//       decoration: BoxDecoration(
//         color: isActive ? Colors.black : Colors.black26,
//         borderRadius: BorderRadius.circular(10),
//       ),
//     );
//   }
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
                    image: "assets/images/logo_onboard1.png",
                    title: "Your trusted Gold Savings App.",
                    subtitle: "A product of",
                    company: "Aesera Jewels Pvt Ltd!",
                    skipAction: controller.skipOnboarding,
                  ),
                  _buildPage(
                    image: "assets/images/logo_onboard 2.png",
                    title: "Gold has been a great investment \n for centuries.",
                    subtitle: "GoldPoint makes it",
                    company: "easy to invest in Gold!",
                    skipAction: controller.skipOnboarding,
                  ),
                  _buildPage(
                    image: "assets/images/logo_onboard3.png",
                    title: "A simple, secure, and",
                    subtitle: "convenient way to invest..",
                    company: "Start investing now!",
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
                  const SizedBox(height: 15),
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
    required String company,
    required VoidCallback skipAction,
  }) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
            padding: const EdgeInsets.fromLTRB(6,15,6,0),
              width: double.infinity,
              height: 400,
              child: Image.asset(image, fit: BoxFit.fill),
            ),
            Positioned(
              top: 20,
              right: 16,
              child: ElevatedButton(
                onPressed: skipAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  elevation: 0,
                ),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Manrope',
                    color: Colors.white,
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
            style: GoogleFonts.lexend(fontSize: 22, fontWeight: FontWeight.w300, color: Colors.black)),
        const SizedBox(height: 8),
        Text(subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(fontSize: 22, fontWeight: FontWeight.w300, color: Colors.black)),
        if (company.isNotEmpty) ...[
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(company,
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white)),
          ),
        ],
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