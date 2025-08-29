
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dashboard_controller.dart';
// import 'package:aesera_jewels/modules/login/login_view.dart';

// class DashboardScreen extends StatelessWidget {
//   final DashboardController controller = Get.put(DashboardController());

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         elevation: 1,
//         title: const Text("Dashboard" ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,fontFamily: 'Lexend',color: Colors.black)),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
//             child: ElevatedButton(
//               onPressed: () => Get.offAll(() => LoginView()),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.amber,
//                 shape: const StadiumBorder(),
//                 padding: EdgeInsets.symmetric(
//                   horizontal: width * 0.07,
//                   vertical: 10,
//                 ),
//               ),
//               child: const Text(
//                 "Logout",
//                 style: TextStyle(fontFamily: 'Lexend', color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Scrollbar(
//           thickness: 6,
//           radius: const Radius.circular(10),
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Welcome Text
//                 const Text(
//                   "Rama Krishnan",
//                   style: TextStyle(fontFamily: "Lexend",fontWeight: FontWeight.w700,fontSize: 22),
//                   // style: TextStyle(        

// ),
              
//                 const SizedBox(height: 20),

//                 // GOLD RATE CARD
//                 Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF032541),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Current Rate Gold (24K)",
//                         style: TextStyle(color: Colors.amber),
//                       ),
//                       const SizedBox(height: 8),
//                       Obx(() {
//                         if (controller.isLoadingRate.value) {
//                           return const Text(
//                             "Loading...",
//                             style: TextStyle(
//                               color: Colors.amber,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           );
//                         } else {
//                           return Text(
//                             "Rs. ${controller.goldRate.value.toStringAsFixed(2)}",
//                             style: const TextStyle(
//                               color: Colors.amber,
//                               fontSize: 26,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           );
//                         }
//                       }),
//                       const SizedBox(height: 12),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: ElevatedButton(
//                           onPressed: controller.goToBuyGold,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.amber,
//                             shape: const StadiumBorder(),
//                             padding: EdgeInsets.symmetric(
//                               horizontal: width * 0.08,
//                               vertical: 12,
//                             ),
//                           ),
//                           child: const Text(
//                             "Pay",
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // SHOP NOW SECTION
//                 GestureDetector(
//                   onTap: controller.goToCatalog,
//                   child: Container(
//                     width: 350,
//                     height: 250,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF032541),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     padding: const EdgeInsets.all(16),
//                     child: Row(
//                       children: [
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(
//                               "assets/images/catalog1.png",
//                               width: 130,
//                               height: 80,
//                             ),
//                             Image.asset(
//                               "assets/images/catelog2.png",
//                               width: 100,
//                               height: 50,
//                             ),
//                             const SizedBox(height: 1),
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
//                               child: FittedBox(
//                                 fit: BoxFit.scaleDown,
//                                 child: ElevatedButton(
//                                   onPressed: controller.goToCatalog,
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.amber,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(15),
//                                     ),
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal: width * 0.05,
//                                       vertical: 10,
//                                     ),
//                                   ),
//                                   child: const Text(
//                                     "Shop\n Now",
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(width: 20),
//                         Expanded(
//                           child: Image.asset(
//                             "assets/images/catelog3.png",
//                             width: double.infinity,
//                             height: 210,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 // PORTFOLIO BUTTON
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: controller.goToInvestment,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF032541),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: width * 0.2,
//                         vertical: 16,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: const Text(
//                       "Portfolio",
//                       style: TextStyle(
//                         color: Colors.amber,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Prevent keyboard or bottom overflow
//                 SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashboard_controller.dart';
import 'package:aesera_jewels/modules/login/login_view.dart';

class DashboardScreen extends GetWidget<DashboardController> {
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Dashboard",
          style: GoogleFonts.lexend(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A0F12),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 16, top: 10.5, bottom: 10.5),
            child: ElevatedButton(
              onPressed: () => Get.offAll(() => LoginView()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFB700),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 3),
              ),
              child: Text(
                "Logout",
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Scrollbar(
          thickness: 6,
          radius: const Radius.circular(10),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: bottomPadding + 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Welcome Text
                Text(
                  "Rama krishnan",
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Color(0xFF1A0F12),
                  ),
                ),

                const SizedBox(height: 16),

                /// GOLD RATE CARD
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 297,
                    height: 160,
                    decoration: BoxDecoration(
                      color: const Color(0xFF09243D),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Rate Gold (24K)",
                          style: GoogleFonts.lexend(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xFFFFB700),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Obx(() {
                          if (controller.isLoadingRate.value) {
                            return Text(
                              "Loading...",
                              style: GoogleFonts.lexend(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: Color(0xFFFFB700),
                              ),
                            );
                          } else {
                            return Text(
                              "Rs. ${controller.goldRate.value.toStringAsFixed(0)}",
                              style: GoogleFonts.lexend(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: Color(0xFFFFB700),
                              ),
                            );
                          }
                        }),
                        const Spacer(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: controller.goToBuyGold,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFB700),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.06,
                                vertical: 0,
                              ),
                            ),
                            child: Text(
                              "Pay",
                              style: GoogleFonts.lexend(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// CATALOG CARD
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 298,
                    height: 241,
                    decoration: BoxDecoration(
                      color: const Color(0xFF09243D),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12,right:12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          /// Left Section: Images and Button
                          Column(
                            children: [
                              
                              Image.asset(
                                "assets/images/catalog1.png",
                               
                                width: 90,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 10),
                              Image.asset(
                                "assets/images/catelog2.png",
                                width: 90,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 12),
                                            
                              /// Shop Now Button (TextButton)
                              TextButton(
                                onPressed: controller.goToCatalog,
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFB700),
                                  padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  "Shop\n Now",
                                  style: GoogleFonts.lexend(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                           Padding(
                             padding: const EdgeInsets.only(bottom: 40,top: 40),
                             child: SizedBox(width: 14),
                           ),
                                  Image.asset( "assets/images/catalog_gold_img.png",
                                  width: 150,
                                  height: 231,
                                  filterQuality: FilterQuality.high,
                                 fit: BoxFit.cover,
                                  ),
                                
                        
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 23),

                /// PORTFOLIO BUTTON
                Align(
                  alignment: Alignment.center,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: controller.goToInvestment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF09243D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 95,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        "Portfolio",
                        style: GoogleFonts.lexend(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFFB700),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
