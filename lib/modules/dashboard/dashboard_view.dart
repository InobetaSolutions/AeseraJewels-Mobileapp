
// // // lib/modules/dashboard/dashboard_screen.dart
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'dashboard_controller.dart';
// // import 'package:aesera_jewels/modules/login/login_view.dart';

// // class DashboardScreen extends StatelessWidget {
// //   final DashboardController controller = Get.put(DashboardController());

// //   @override
// //   Widget build(BuildContext context) {
// //     final width = MediaQuery.of(context).size.width;
// //     final buttonWidth = width * 0.25;

// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         centerTitle: true,
// //         elevation: 1,
// //         title: const Text("Dashboard", style: TextStyle(color: Colors.black)),
// //         actions: [
// //           Padding(
// //             padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
// //             child: ElevatedButton(
// //               onPressed: () => Get.offAll(() => LoginView()),
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: Colors.amber,
// //                 shape: const StadiumBorder(),
// //                 padding: EdgeInsets.symmetric(
// //                   horizontal: buttonWidth * 0.5,
// //                   vertical: 10,
// //                 ),
// //               ),
// //               child: const Text(
// //                 "Logout",
// //                 style: TextStyle(color: Colors.black, fontSize: 12),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       body: SafeArea(
// //         child: Scrollbar(
// //           thickness: 6,
// //           radius: const Radius.circular(10),
// //           child: SingleChildScrollView(
// //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 // Welcome Title
// //                 const Text(
// //                   "Rama Krishnan",
// //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
// //                 ),
// //                 const SizedBox(height: 20),

// //                 // GOLD RATE CARD
// //                 Container(
// //                   width: double.infinity,
// //                   decoration: BoxDecoration(
// //                     color: const Color(0xFF032541),
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   padding: const EdgeInsets.all(16),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       const Text(
// //                         "Current Rate Gold (24K)",
// //                         style: TextStyle(color: Colors.amber),
// //                       ),
// //                       const SizedBox(height: 8),

// //                       // 🔽 GOLD RATE TEXT (REACTIVE)
// //                       Obx(() {
// //                         if (controller.isLoadingRate.value) {
// //                           return const Text(
// //                             "Loading...",
// //                             style: TextStyle(
// //                               color: Colors.amber,
// //                               fontSize: 20,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           );
// //                         } else {
// //                           return Text(
// //                             "Rs. ${controller.goldRate.value.toStringAsFixed(2)}",
// //                             style: const TextStyle(
// //                               color: Colors.amber,
// //                               fontSize: 26,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           );
// //                         }
// //                       }),

// //                       const SizedBox(height: 12),

// //                       Align(
// //                         alignment: Alignment.centerRight,
// //                         child: ElevatedButton(
// //                           onPressed: controller.goToBuyGold,
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: Colors.amber,
// //                             shape: const StadiumBorder(),
// //                             padding: EdgeInsets.symmetric(
// //                               horizontal: width * 0.08,
// //                               vertical: 12,
// //                             ),
// //                           ),
// //                           child: const Text(
// //                             "Pay",
// //                             style: TextStyle(color: Colors.black),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),

// //                 const SizedBox(height: 20),

// //                 // SHOP NOW SECTION
// //                 GestureDetector(
// //                   onTap: controller.goToCatalog,
// //                   child: Container(
// //                     width: double.infinity,
// //                     height: 230,
// //                     decoration: BoxDecoration(
// //                       color: const Color(0xFF032541),
// //                       borderRadius: BorderRadius.circular(16),
// //                     ),
// //                     padding: const EdgeInsets.all(16),
// //                     child: Row(
// //                       children: [
// //                         Column(
// //                           children: [
// //                             Image.asset(
// //                               "assets/images/catalog1.png",
// //                               width: 70,
// //                               height: 70,
// //                             ),
// //                             const SizedBox(height: 5),
// //                             Image.asset(
// //                               "assets/images/catelog2.png",
// //                               width: 70,
// //                               height: 50,
// //                             ),
// //                             const SizedBox(height: 10),
// //                             ElevatedButton(
// //                               onPressed: controller.goToCatalog,
// //                               style: ElevatedButton.styleFrom(
// //                                 backgroundColor: Colors.amber,
// //                                 shape: RoundedRectangleBorder(
// //                                   borderRadius: BorderRadius.circular(10),
// //                                 ),
// //                                 padding: EdgeInsets.symmetric(
// //                                   horizontal: width * 0.04,

// //                                   vertical: 25,
// //                                 ),
// //                               ),
// //                               child: const Text(
// //                                 "Shop Now",
// //                                 style: TextStyle(color: Colors.black),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                         const SizedBox(width: 20),
// //                         Expanded(
// //                           child: Image.asset(
// //                             "assets/images/catelog3.png",
// //                             width: double.infinity,
// //                             height: 210,
// //                             fit: BoxFit.cover,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 30),

// //                 // PORTFOLIO BUTTON
// //                 Center(
// //                   child: ElevatedButton(
// //                     onPressed: controller.goToInvestment,
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: const Color(0xFF032541),
// //                       padding: EdgeInsets.symmetric(
// //                         horizontal: width * 0.2,
// //                         vertical: 16,
// //                       ),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                     ),
// //                     child: const Text(
// //                       "Portfolio",
// //                       style: TextStyle(
// //                         color: Colors.amber,
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 20),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
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
//         title: const Text("Dashboard", style: TextStyle(color: Colors.black)),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
//             child: ElevatedButton(
//               onPressed: () => Get.offAll(() => LoginView()),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.amber,
//                 shape: const StadiumBorder(),
//                 padding: EdgeInsets.symmetric(
//                   horizontal: width * 0.05,
//                   vertical: 10,
//                 ),
//               ),
//               child: const Text(
//                 "Logout",
//                 style: TextStyle(color: Colors.black, fontSize: 12),
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
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                 ),
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
//                     width: double.infinity,
//                     height: 230,
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
//                               width: 70,
//                               height: 70,
//                             ),
//                             const SizedBox(height: 5),
//                             Image.asset(
//                               "assets/images/catelog2.png",
//                               width: 70,
//                               height: 50,
//                             ),
//                             const SizedBox(height: 10),
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
//                               child: ElevatedButton(
//                                 onPressed: controller.goToCatalog,
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.amber,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   padding: EdgeInsets.symmetric(
//                                     horizontal: MediaQuery.of(context).size.width * 0.04,
//                                     vertical: 25,
//                                   ),
//                                 ),
//                                 child:  Flexible(
//                                   child: Text(
//                                     "Shop Now",
//                                     overflow: TextOverflow.ellipsis,
//                                     softWrap: true,
//                                     style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),
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

//                 // Prevent keyboard overflow
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
import 'dashboard_controller.dart';
import 'package:aesera_jewels/modules/login/login_view.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: const Text("Dashboard" ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,fontFamily: 'Lexend',color: Colors.black)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            child: ElevatedButton(
              onPressed: () => Get.offAll(() => LoginView()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: const StadiumBorder(),
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.07,
                  vertical: 10,
                ),
              ),
              child: const Text(
                "Logout",
                style: TextStyle(fontFamily: 'Lexend', color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Text
                const Text(
                  "Rama Krishnan",
                  style: TextStyle(fontFamily: "Lexend",fontWeight: FontWeight.w700,fontSize: 22),
                  // style: TextStyle(        

),
              
                const SizedBox(height: 20),

                // GOLD RATE CARD
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF032541),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Current Rate Gold (24K)",
                        style: TextStyle(color: Colors.amber),
                      ),
                      const SizedBox(height: 8),
                      Obx(() {
                        if (controller.isLoadingRate.value) {
                          return const Text(
                            "Loading...",
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else {
                          return Text(
                            "Rs. ${controller.goldRate.value.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Colors.amber,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      }),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: controller.goToBuyGold,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            shape: const StadiumBorder(),
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.08,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            "Pay",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // SHOP NOW SECTION
                GestureDetector(
                  onTap: controller.goToCatalog,
                  child: Container(
                    width: 350,
                    height: 250,
                    decoration: BoxDecoration(
                      color: const Color(0xFF032541),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/catalog1.png",
                              width: 130,
                              height: 80,
                            ),
                            Image.asset(
                              "assets/images/catelog2.png",
                              width: 100,
                              height: 50,
                            ),
                            const SizedBox(height: 1),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: ElevatedButton(
                                  onPressed: controller.goToCatalog,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.05,
                                      vertical: 10,
                                    ),
                                  ),
                                  child: const Text(
                                    "Shop\n Now",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Image.asset(
                            "assets/images/catelog3.png",
                            width: double.infinity,
                            height: 210,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // PORTFOLIO BUTTON
                Center(
                  child: ElevatedButton(
                    onPressed: controller.goToInvestment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF032541),
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.2,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Portfolio",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Prevent keyboard or bottom overflow
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
