
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
//                    _buildPage(
//                     image: "assets/images/logo_onboard 2.png",
//                     title: "Gold has been a great investment \n for centuries.",
//                     subtitle: "GoldPoint makes it",
//                     company: "easy to invest in Gold!",
//                     skipAction: controller.skipOnboarding,
//                   ),
//                   _buildPage(
//                     image: "assets/images/logo_onboard1.png",
//                     title: "Your trusted Gold Savings App.",
//                     subtitle: "A product of",
//                     company: "Aesera Jewels Pvt Ltd!",
//                     skipAction: controller.skipOnboarding,
//                   ),
                 
//                   _buildPage(
//                     image: "assets/images/logo_onboard3.png",
//                     title: "A simple, secure, and",
//                     subtitle: "convenient way to invest..",
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
//                   const SizedBox(height: 15),
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
//             Container(
//             padding: const EdgeInsets.fromLTRB(6,15,6,0),
//               width: double.infinity,
//               height: 400,
//               child: Image.asset(image, fit: BoxFit.fill),
//             ),
//             Positioned(
//               top: 20,
//               right: 16,
//               child: ElevatedButton(
//                 onPressed: skipAction,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:const Color(0xFF09243D),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   elevation: 0,
//                 ),
//                 child: const Text(
//                   'Skip',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontFamily: 'Manrope',
//                     color: Colors.white,
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
//             style: GoogleFonts.lexend(fontSize: 22, fontWeight: FontWeight.w300, color: Colors.black)),
//         const SizedBox(height: 8),
//         Text(subtitle,
//             textAlign: TextAlign.center,
//             style: GoogleFonts.lexend(fontSize: 22, fontWeight: FontWeight.w300, color: Colors.black)),
//         if (company.isNotEmpty) ...[
//           const SizedBox(height: 10),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Text(company,
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.lexend(fontSize: 22, fontWeight: FontWeight.w300, color: Colors.white)),
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
                    title: "Gold has been a great investment\n for centuries.",
                    subtitle: "GoldPoint makes it",
                    company: "easy to invest in Gold!",
                    skipAction: controller.skipOnboarding,
                  ),
                  _buildPage(
                    image: "assets/images/logo_onboard1.png",
                    title: "Your trusted Gold Savings App.",
                    subtitle: "A product of",
                    company: "Aesera Jewels Pvt Ltd!",
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

            /// ------------------ Dots + Next ------------------
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
                      child:
                          Icon(Icons.arrow_forward, color: Colors.white, size: 32),
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
    required String title,
    required String subtitle,
    required String company,
    required VoidCallback skipAction,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// ------------------ Image & Skip Button ------------------
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
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
                      backgroundColor: const Color(0xFF09243D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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

            /// ------------------ Text Section ------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexend(
                      fontSize: 22,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexend(
                      fontSize: 22,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Company Label (kept same place for all)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      company,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lexend(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        );
      },
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
