
// import 'package:aesera_jewels/modules/onboard/onboard_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class OnboardingScreen extends GetWidget<OnboardingController> {
//   final OnboardingController controller = Get.put(OnboardingController());

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             /// ------------------ PageView ------------------
//             Expanded(
//               child: PageView(
//                 controller: controller.pageController,
//                 onPageChanged: controller.onPageChanged,
//                 children: [
//                   _buildPage(
//                     image: "assets/images/logo_onboard 2.png",
//                     title:
//                         "Gold has been a great investment\n for centuries.",
//                     subtitle: "GoldPoint makes it",
//                     company: "easy to invest in Gold!",
//                     skipAction: controller.skipOnboarding,
//                   ),
//                   _buildPage(
//                     image: "assets/images/logo_onboard1.png",
//                     title: "Your trusted Gold Savings App.",
//                     subtitle: "\n A product of ",
//                     company: "Aesera Jewels Pvt Ltd!",
//                     skipAction: controller.skipOnboarding,
//                   ),
//                   _buildPage(
//                     image: "assets/images/logo_onboard3.png",
//                     title: "A simple, secure, and\n convenient way to invest.",
//                     subtitle: "",
//                     company: "Start investing now!",
//                     skipAction: controller.skipOnboarding,
//                   ),
//                 ],
//               ),
//             ),

//             /// ------------------ Dots + Next ------------------
//             Padding(
//               padding: const EdgeInsets.only(bottom: 30),
//               child: Column(
//                 children: [
//                   Obx(
//                     () => Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List.generate(
//                         3,
//                         (index) => _dot(
//                           isActive: controller.currentPage.value == index,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   GestureDetector(
//                     onTap: controller.goToNextPage,
//                     child: const CircleAvatar(
//                       radius: 32,
//                       backgroundColor: Color(0xFF09243D),
//                       child: Icon(
//                         Icons.arrow_forward,
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

//   /// ------------------ Page Layout ------------------
//   Widget _buildPage({
//     required String image,
//     required String title,
//     required String subtitle,
//     required String company,
//     required VoidCallback skipAction,
//   }) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             /// ------------------ Image & Skip Button ------------------
//             Stack(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
//                   width: 380,
//                   height: 380,
//                   child: Image.asset(image, fit: BoxFit.fill),
//                 ),
//                 Positioned(
//                   top: 20,
//                   right: 16,
//                   child: ElevatedButton(
//                     onPressed: skipAction,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF09243D),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 6,
//                       ),
//                       elevation: 0,
//                     ),
//                     child: const Text(
//                       'Skip',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontFamily: 'Manrope',
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             /// ------------------ Text Section ------------------
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 100,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           title,
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.lexend(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w300,
//                             color: Colors.black,
//                             // height: 1.4,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           subtitle,
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.lexend(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w300,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 5),

//                   /// Company Label (always same position)
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 10,
//                     ),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF09243D),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Text(
//                       company,
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.lexend(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w300,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 40),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   /// ------------------ Dot Indicator ------------------
//   Widget _dot({bool isActive = false}) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
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

class OnboardingScreen extends GetWidget<OnboardingController> {
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// ------------------ PageView ------------------
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: [
                  _buildPage(
                    image: "assets/images/logo_onboard 2.png",
                    textImage: "assets/images/welcome screen txt1.png",
                    skipAction: controller.skipOnboarding,
                  ),
                  _buildPage(
                    image: "assets/images/logo_onboard1.png",
                    textImage: "assets/images/welcome screen txt2.png",
                    skipAction: controller.skipOnboarding,
                  ),
                  _buildPage(
                    image: "assets/images/logo_onboard3.png",
                    textImage: "assets/images/welcome screen txt3 (2).png",
                    skipAction: controller.skipOnboarding,
                  ),
                ],
              ),
            ),

            /// ------------------ Dots + Next Button ------------------
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => _dot(
                          isActive: controller.currentPage.value == index,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: controller.goToNextPage,
                    child: const CircleAvatar(
                      radius: 32,
                      backgroundColor: Color(0xFF09243D),
                      child: Icon(
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

  /// ------------------ Page Layout ------------------
  Widget _buildPage({
    required String image,
    required String textImage,
    required VoidCallback skipAction,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// ------------------ Image & Skip Button ------------------
        Stack(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
                  width: 380,
                  height: 380,
               
                  child: Image.asset(image, fit: BoxFit.fill),
                ),
                Positioned(
                  top: 20,
                  right: 16,
                  child: ElevatedButton(
                    onPressed: skipAction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF09243D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
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


        /// ------------------ Text (Image) Section ------------------
        Column(
          children: [
            SizedBox(height: 20),
        
          Container(
                width:
                double.infinity,
                height: 200,
                child: Image.asset(textImage, fit: BoxFit.fill),
              ),
            SizedBox(height: 40),
          ],
        ),
      ],
    );
  }

  /// ------------------ Dot Indicator ------------------
  Widget _dot({bool isActive = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
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
