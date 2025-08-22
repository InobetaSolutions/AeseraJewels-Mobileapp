import 'package:aesera_jewels/modules/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetWidget<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onPressed: () {
                      // TODO: Handle logout
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // User Name
              Text(
                'Rama krishnan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              // Gold Rate + Pay
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF0A2A4D),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Rate Gold (24K)',
                      style: TextStyle(color: Colors.amber),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Rs.9,450',
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: controller.goToBuyGold,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape: StadiumBorder(),
                        ),
                        child: Text(
                          'Pay',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Shop Now Section
              GestureDetector(
                onTap: controller.goToCatalog,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF0A2A4D),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      // Right-side gold coins image
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Image.asset(
                            'assets/images/Group 72.png', // Use your actual asset
                            fit: BoxFit.contain,
                            width: 120,
                          ),
                        ),
                      ),

                      // Left-side button
                      Positioned(
                        left: 16,
                        bottom: 16,
                        child: ElevatedButton(
                          onPressed: controller.goToCatalog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          child: Text(
                            'Shop Now',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Portfolio Button
              ElevatedButton(
                onPressed: controller.goToPortfolio,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0A2A4D),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Portfolio',
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// // import 'package:aesera_jewels/modules/dashboard/dashboard_controller.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// // class DashboardScreen extends StatelessWidget {
// //   final DashboardController controller = Get.find();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Text(
// //                     "Dashboard",
// //                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
// //                   ),
// //                   ElevatedButton(
// //                     onPressed: () {}, // Logout logic here
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.amber,
// //                       shape: StadiumBorder(),
// //                       padding: EdgeInsets.symmetric(
// //                         horizontal: 20,
// //                         vertical: 10,
// //                       ),
// //                     ),
// //                     child: Text(
// //                       "Logout",
// //                       style: TextStyle(color: Colors.black),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               SizedBox(height: 20),
// //               Text(
// //                 "Rama krishnan",
// //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
// //               ),
// //               SizedBox(height: 20),

// //               // GOLD RATE CONTAINER
// //               Container(
// //                 decoration: BoxDecoration(
// //                   color: Color(0xFF032541),
// //                   borderRadius: BorderRadius.circular(10),
// //                 ),
// //                 padding: EdgeInsets.all(16),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       "Current Rate Gold (24K)",
// //                       style: TextStyle(color: Colors.amber),
// //                     ),
// //                     SizedBox(height: 8),
// //                     Text(
// //                       "Rs.9,450",
// //                       style: TextStyle(
// //                         color: Colors.amber,
// //                         fontSize: 24,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                     SizedBox(height: 10),
// //                     Align(
// //                       alignment: Alignment.centerRight,
// //                       child: ElevatedButton(
// //                         onPressed: controller.goToBuyGold,
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: Colors.amber,
// //                           shape: StadiumBorder(),
// //                           padding: EdgeInsets.symmetric(
// //                             horizontal: 20,
// //                             vertical: 10,
// //                           ),
// //                         ),
// //                         child: Text(
// //                           "Pay",
// //                           style: TextStyle(color: Colors.black),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),

// //               SizedBox(height: 20),

// //               // SHOP NOW CONTAINER
// //               GestureDetector(
// //                 onTap: controller.goToCatalog,
// //                 child: Container(
// //                   decoration: BoxDecoration(
// //                     color: Color(0xFF032541),
// //                     borderRadius: BorderRadius.circular(16),
// //                   ),
// //                   padding: EdgeInsets.all(16),
// //                   child: Row(
// //                     children: [
// //                       Column(
// //                         children: [
// //                           Image.asset("assets/images/catalog1.png", width: 40),
// //                           SizedBox(height: 10),
// //                           Image.asset("assets/images/catelog2.png", width: 40),
// //                           SizedBox(height: 10),
// //                           ElevatedButton(
// //                             onPressed: controller.goToCatalog,
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: Colors.amber,
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(10),
// //                               ),
// //                             ),
// //                             child: Text(
// //                               "Shop Now",
// //                               style: TextStyle(color: Colors.black),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       SizedBox(width: 20),
// //                       Expanded(
// //                         child: Image.asset("assets/images/catelog3.png"),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),

// //               SizedBox(height: 20),

// //               // PORTFOLIO BUTTON
// //               Center(
// //                 child: ElevatedButton(
// //                   onPressed: controller.goToPortfolio,
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Color(0xFF032541),
// //                     padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                   ),
// //                   child: Text(
// //                     "Portfolio",
// //                     style: TextStyle(
// //                       color: Colors.amber,
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }import 'package:aesera_jewels/modules/dashboard/dashboard_controller.dart';
// import 'package:aesera_jewels/modules/dashboard/dashboard_controller.dart';
// import 'package:aesera_jewels/modules/login/login_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class DashboardScreen extends StatelessWidget {
//   final DashboardController controller = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           // Make the screen scrollable
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header Row
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Align(
//                       alignment: Alignment.topCenter,
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(60, 4, 20, 4),
//                         child: Text(
//                           "Dashboard",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {}, // Logout logic here
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.amber,
//                         shape: StadiumBorder(),
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 5,
//                           vertical: 5,
//                         ),
//                       ),
//                       child: TextButton(
//                         onPressed: () {
//                           Get.offAll(() => LoginView());
//                         },
//                         child: const Text(
//                           "Logout",
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   "Rama krishnan",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
//                 ),
//                 SizedBox(height: 20),

//                 // GOLD RATE CONTAINER
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Color(0xFF032541),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Current Rate Gold (24K)",
//                         style: TextStyle(color: Colors.amber),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         "Rs.9,450",
//                         style: TextStyle(
//                           color: Colors.amber,
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: ElevatedButton(
//                           onPressed: controller.goToBuyGold,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.amber,
//                             shape: StadiumBorder(),
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 20,
//                               vertical: 10,
//                             ),
//                           ),
//                           child: Text(
//                             "Pay",
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 SizedBox(height: 20),

//                 // SHOP NOW CONTAINER
//                 GestureDetector(
//                   onTap: controller.goToCatalog,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Color(0xFF032541),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     padding: EdgeInsets.all(16),
//                     child: Row(
//                       children: [
//                         Column(
//                           children: [
//                             Image.asset(
//                               "assets/images/catalog1.png",
//                               width: 40,
//                             ),
//                             SizedBox(height: 10),
//                             Image.asset(
//                               "assets/images/catelog2.png",
//                               width: 40,
//                             ),
//                             SizedBox(height: 10),
//                             ElevatedButton(
//                               onPressed: controller.goToCatalog,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.amber,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               child: Text(
//                                 "Shop Now",
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(width: 20),
//                         Expanded(
//                           child: Image.asset("assets/images/catelog3.png"),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 20),

//                 // PORTFOLIO BUTTON
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: controller.goToPortfolio,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF032541),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 80,
//                         vertical: 16,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text(
//                       "Portfolio",
//                       style: TextStyle(
//                         color: Colors.amber,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
