
// // // // import 'package:aesera_jewels/modules/Gold_Coin/goldcoin_controller.dart';
// // // // import 'package:aesera_jewels/services/storage_service.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:get/get.dart';
// // // // import 'package:google_fonts/google_fonts.dart';

// // // // class GoldCoinView extends GetView<GoldCoinController> {
// // // //   GoldCoinView({super.key});

// // // //   final GoldCoinController controller = Get.put(GoldCoinController());

// // // //   // Coin images corresponding to each weight
// // // //   final List<String> goldImages = [
// // // //     'assets/images/1 gm coin.png',
// // // //     'assets/images/2 gm coin.png',
// // // //     'assets/images/4 gm.png',
// // // //     'assets/images/10 gm.png',
// // // //     // 'assets/images/20 gm.png',
// // // //   ];

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: const Color(0xFFFAFAFA),
// // // //       appBar: AppBar(
// // // //         backgroundColor: const Color(0xFFFAFAFA),
// // // //         elevation: 0,
// // // //         centerTitle: true,
// // // //         title: Text(
// // // //           "Gold Coin Catalog",
// // // //           style: GoogleFonts.lexend(
// // // //             fontSize: 22,
// // // //             fontWeight: FontWeight.w700,
// // // //             color: const Color(0xFF1A0F12),
// // // //           ),
// // // //         ),
// // // //         actions: [
// // // //           Padding(
// // // //             padding: const EdgeInsets.only(right: 12),
// // // //             child: ElevatedButton(
// // // //               onPressed: () async {
// // // //                 await StorageService().erase();
// // // //                 Get.offNamed('/login');
// // // //               },
// // // //               style: ElevatedButton.styleFrom(
// // // //                 backgroundColor: const Color(0xFFFFB700),
// // // //                 shape: RoundedRectangleBorder(
// // // //                   borderRadius: BorderRadius.circular(20),
// // // //                 ),
// // // //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// // // //               ),
// // // //               child: Text(
// // // //                 "Logout",
// // // //                 style: GoogleFonts.lexend(
// // // //                   fontSize: 16,
// // // //                   fontWeight: FontWeight.w700,
// // // //                   color: Colors.black,
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //       body: Obx(() {
// // // //         if (controller.isLoadingRate.value) {
// // // //           return const Center(child: CircularProgressIndicator());
// // // //         }

// // // //         if (controller.goldRate.value == null) {
// // // //           return const Center(child: Text("Unable to load gold rate"));
// // // //         }

// // // //         return SafeArea(
// // // //           child: SingleChildScrollView(
// // // //             padding: const EdgeInsets.all(16),
// // // //             child: Column(
// // // //               children: [
// // // //                 _buildGoldCardList(),
// // // //                 const SizedBox(height: 30),
// // // //                 _buildContinueButton(),
// // // //                 const SizedBox(height: 10),
// // // //                 Text(
// // // //                   "24k Pure Gold | 100% Safe & Secured",
// // // //                   style: GoogleFonts.lexend(
// // // //                     fontWeight: FontWeight.w500,
// // // //                     fontSize: 16,
// // // //                     color: const Color(0xFFFFB700),
// // // //                   ),
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //         );
// // // //       }),
// // // //     );
// // // //   }

// // // //   Widget _buildGoldCardList() {
// // // //     return Column(
// // // //       children: List.generate(controller.weights.length, (index) {
// // // //         return Padding(
// // // //           padding: const EdgeInsets.only(bottom: 24),
// // // //           child: _goldItem(index),
// // // //         );
// // // //       }),
// // // //     );
// // // //   }

// // // //   Widget _goldItem(int index) {
// // // //     final baseWeight = controller.weights[index];
// // // //     final imagePath = goldImages[index];

// // // //     // Price per coin (fixed for that coin weight)
// // // //     final coinPrice = controller.getCoinPrice(baseWeight);

// // // //     return Obx(() {
// // // //       final quantity = controller.coinCount[index] ?? 1;

// // // //       return Container(
// // // //         width: double.infinity,
// // // //         decoration: BoxDecoration(
// // // //           color: const Color(0xFF09243D),
// // // //           borderRadius: BorderRadius.circular(12),
// // // //         ),
// // // //         padding: const EdgeInsets.all(16),
// // // //         child: Column(
// // // //           children: [
// // // //             Image.asset(imagePath, height: 100),
// // // //             const SizedBox(height: 12),

// // // //             // Fixed weight label
// // // //             Text(
// // // //               "$baseWeight GM Coin",
// // // //               style: GoogleFonts.lexend(
// // // //                 fontWeight: FontWeight.w700,
// // // //                 fontSize: 18,
// // // //                 color: Colors.white,
// // // //               ),
// // // //             ),
// // // //             const SizedBox(height: 8),

// // // //             // Fixed rupee value (does not change when quantity changes)
// // // //             Text(
// // // //               "Rs. ${coinPrice.toStringAsFixed(2)}",
// // // //               style: GoogleFonts.lexend(
// // // //                 fontWeight: FontWeight.w700,
// // // //                 fontSize: 20,
// // // //                 color: const Color(0xFFFFB700),
// // // //               ),
// // // //             ),
// // // //             const SizedBox(height: 14),

// // // //             // Quantity control row
// // // //             Row(
// // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // //               children: [
// // // //                 _quantityButton("-", () => controller.decreaseCount(index)),
// // // //                 const SizedBox(width: 40),
// // // //                 Text(
// // // //                   "${quantity} pcs",
// // // //                   style: GoogleFonts.lexend(
// // // //                     fontWeight: FontWeight.w700,
// // // //                     fontSize: 20,
// // // //                     color: Colors.white,
// // // //                   ),
// // // //                 ),
// // // //                 const SizedBox(width: 40),
// // // //                 _quantityButton("+", () => controller.increaseCount(index)),
// // // //               ],
// // // //             ),

// // // //             const SizedBox(height: 8),
// // // //             // Show total weight dynamically (e.g., 10g × 2 = 20g)
// // // //             Text(
// // // //               "Total: ${controller.getTotalWeightForCoin(index).toStringAsFixed(0)}g",
// // // //               style: GoogleFonts.lexend(
// // // //                 fontSize: 14,
// // // //                 fontWeight: FontWeight.w600,
// // // //                 color: Colors.white70,
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       );
// // // //     });
// // // //   }

// // // //   Widget _quantityButton(String text, VoidCallback onTap) {
// // // //     return InkWell(
// // // //       onTap: onTap,
// // // //       borderRadius: BorderRadius.circular(8),
// // // //       child: Container(
// // // //         height: 35,
// // // //         width: 35,
// // // //         alignment: Alignment.center,
// // // //         decoration: BoxDecoration(
// // // //           color: const Color(0xFFFFB700),
// // // //           borderRadius: BorderRadius.circular(8),
// // // //         ),
// // // //         child: Text(
// // // //           text,
// // // //           style: GoogleFonts.lexend(
// // // //             fontWeight: FontWeight.w700,
// // // //             fontSize: 18,
// // // //             color: Colors.black,
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildContinueButton() {
// // // //     return ElevatedButton(
// // // //       onPressed: () {
// // // //         Get.snackbar(
// // // //           "Gold Live Rate",
// // // //           "Rs. ${controller.goldRate.value!.priceGram24k.toStringAsFixed(2)} / gram",
// // // //           snackPosition: SnackPosition.BOTTOM,
// // // //           backgroundColor: Colors.black87,
// // // //           colorText: Colors.white,
// // // //         );
// // // //       },
// // // //       style: ElevatedButton.styleFrom(
// // // //         backgroundColor: const Color(0xFF09243D),
// // // //         shape: RoundedRectangleBorder(
// // // //           borderRadius: BorderRadius.circular(14),
// // // //         ),
// // // //         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
// // // //       ),
// // // //       child: Text(
// // // //         "Continue",
// // // //         style: GoogleFonts.lexend(
// // // //           fontSize: 18,
// // // //           fontWeight: FontWeight.w700,
// // // //           color: Colors.white,
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // // import 'package:aesera_jewels/modules/Gold_Coin/goldcoin_controller.dart';
// // // import 'package:aesera_jewels/services/storage_service.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:google_fonts/google_fonts.dart';

// // // class GoldCoinView extends GetView<GoldCoinController> {
// // //   GoldCoinView({super.key});

// // //   final GoldCoinController controller = Get.put(GoldCoinController());

// // //   final List<String> goldImages = [
// // //     'assets/images/1 gm coin.png',
// // //     'assets/images/2 gm coin.png',
// // //     'assets/images/4 gm.png',
// // //     'assets/images/10 gm.png',
// // //     'assets/images/20 gm.png',
// // //   ];

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final screenWidth = MediaQuery.of(context).size.width;

// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFFFAFAFA),
// // //       appBar: AppBar(
// // //         backgroundColor: const Color(0xFFFAFAFA),
// // //         elevation: 0,
// // //         centerTitle: true,
// // //         title: Text(
// // //           "Gold Coin Catalog",
// // //           style: GoogleFonts.lexend(
// // //             fontSize: 22,
// // //             fontWeight: FontWeight.w700,
// // //             color: const Color(0xFF1A0F12),
// // //           ),
// // //         ),
// // //         actions: [
// // //           Padding(
// // //             padding: const EdgeInsets.only(right: 12),
// // //             child: ElevatedButton(
// // //               onPressed: () async {
// // //                 await StorageService().erase();
// // //                 Get.offNamed('/login');
// // //               },
// // //               style: ElevatedButton.styleFrom(
// // //                 backgroundColor: const Color(0xFFFFB700),
// // //                 shape: RoundedRectangleBorder(
// // //                   borderRadius: BorderRadius.circular(20),
// // //                 ),
// // //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// // //               ),
// // //               child: Text(
// // //                 "Logout",
// // //                 style: GoogleFonts.lexend(
// // //                   fontSize: 16,
// // //                   fontWeight: FontWeight.w700,
// // //                   color: Colors.black,
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //       body: Obx(() {
// // //         if (controller.isLoadingRate.value) {
// // //           return const Center(child: CircularProgressIndicator());
// // //         }

// // //         if (controller.goldRate.value == null) {
// // //           return const Center(child: Text("Unable to load gold rate"));
// // //         }

// // //         return SafeArea(
// // //           child: Column(
// // //             children: [
// // //               Expanded(child: _buildGoldGrid(screenWidth)),
// // //               const SizedBox(height: 20),
// // //               _buildContinueButton(),
// // //               const SizedBox(height: 10),
// // //               Text(
// // //                 "24k Pure Gold | 100% Safe & Secured",
// // //                 style: GoogleFonts.lexend(
// // //                   fontWeight: FontWeight.w500,
// // //                   fontSize: 16,
// // //                   color: const Color(0xFFFFB700),
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 20),
// // //             ],
// // //           ),
// // //         );
// // //       }),
// // //     );
// // //   }

// // //   /// ✅ GridView layout for gold coins
// // //   Widget _buildGoldGrid(double screenWidth) {
// // //     return GridView.builder(
// // //       padding: const EdgeInsets.all(12),
// // //       itemCount: controller.weights.length,
// // //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //         crossAxisCount: 2,
// // //         childAspectRatio: 0.65,
// // //         crossAxisSpacing: 10,
// // //         mainAxisSpacing: 10,
// // //       ),
// // //       itemBuilder: (_, index) {
// // //         final baseWeight = controller.weights[index];
// // //         final imagePath = goldImages[index];
// // //         final coinPrice = controller.getCoinPrice(baseWeight);

// // //         return Obx(() {
// // //           final quantity = controller.coinCount[index] ?? 1;
// // //           final totalWeight = controller.getTotalWeightForCoin(index);

// // //           return Container(
// // //             decoration: BoxDecoration(
// // //               border: Border.all(color: const Color(0xFF09243D), width: 2.5),
// // //               borderRadius: BorderRadius.circular(16),
// // //               color: Colors.white,
// // //             ),
// // //             padding: const EdgeInsets.all(10),
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.center,
// // //               children: [
// // //                 ClipRRect(
// // //                   borderRadius: BorderRadius.circular(10),
// // //                   child: Image.asset(
// // //                     imagePath,
// // //                     height: 100,
// // //                     width: double.infinity,
// // //                     fit: BoxFit.contain,
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 8),
// // //                 Text(
// // //                   "$baseWeight GM Coin",
// // //                   style: GoogleFonts.lexend(
// // //                     fontSize: 16,
// // //                     fontWeight: FontWeight.w700,
// // //                     color: const Color(0xFF09243D),
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 6),
// // //                 Text(
// // //                   "₹${coinPrice.toStringAsFixed(2)}",
// // //                   style: GoogleFonts.lexend(
// // //                     fontSize: 18,
// // //                     fontWeight: FontWeight.w700,
// // //                     color: const Color(0xFFFFB700),
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 10),
// // //                 Row(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   children: [
// // //                     _quantityButton("-", () => controller.decreaseCount(index)),
// // //                     const SizedBox(width: 25),
// // //                     Text(
// // //                       "$quantity pcs",
// // //                       style: GoogleFonts.lexend(
// // //                         fontSize: 16,
// // //                         fontWeight: FontWeight.w700,
// // //                         color: const Color(0xFF09243D),
// // //                       ),
// // //                     ),
// // //                     const SizedBox(width: 25),
// // //                     _quantityButton("+", () => controller.increaseCount(index)),
// // //                   ],
// // //                 ),
// // //                 const SizedBox(height: 8),
// // //                 Text(
// // //                   "Total: ${totalWeight.toStringAsFixed(0)}g",
// // //                   style: GoogleFonts.lexend(
// // //                     fontSize: 14,
// // //                     fontWeight: FontWeight.w600,
// // //                     color: Colors.black54,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           );
// // //         });
// // //       },
// // //     );
// // //   }

// // //   Widget _quantityButton(String text, VoidCallback onTap) {
// // //     return InkWell(
// // //       onTap: onTap,
// // //       borderRadius: BorderRadius.circular(8),
// // //       child: Container(
// // //         height: 32,
// // //         width: 32,
// // //         alignment: Alignment.center,
// // //         decoration: BoxDecoration(
// // //           color: const Color(0xFFFFB700),
// // //           borderRadius: BorderRadius.circular(8),
// // //         ),
// // //         child: Text(
// // //           text,
// // //           style: GoogleFonts.lexend(
// // //             fontWeight: FontWeight.w700,
// // //             fontSize: 18,
// // //             color: Colors.black,
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildContinueButton() {
// // //     return ElevatedButton(
// // //       onPressed: () {
// // //         Get.snackbar(
// // //           "Gold Live Rate",
// // //           "Rs. ${controller.goldRate.value!.priceGram24k.toStringAsFixed(2)} / gram",
// // //           snackPosition: SnackPosition.BOTTOM,
// // //           backgroundColor: Colors.black87,
// // //           colorText: Colors.white,
// // //         );
// // //       },
// // //       style: ElevatedButton.styleFrom(
// // //         backgroundColor: const Color(0xFF09243D),
// // //         shape: RoundedRectangleBorder(
// // //           borderRadius: BorderRadius.circular(14),
// // //         ),
// // //         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
// // //       ),
// // //       child: Text(
// // //         "Continue",
// // //         style: GoogleFonts.lexend(
// // //           fontSize: 18,
// // //           fontWeight: FontWeight.w700,
// // //           color: Colors.white,
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:aesera_jewels/modules/Gold_Coin/goldcoin_controller.dart';
// // import 'package:aesera_jewels/services/storage_service.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';

// // class GoldCoinView extends GetView<GoldCoinController> {
// //   GoldCoinView({super.key});

// //   final GoldCoinController controller = Get.put(GoldCoinController());

// //   final List<String> goldImages = [
// //     'assets/images/1 gm coin.png',
// //     'assets/images/2 gm coin.png',
// //     'assets/images/4 gm.png',
// //     'assets/images/10 gm.png',
// //     'assets/images/20 gm.png',
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     final screenWidth = MediaQuery.of(context).size.width;

// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         centerTitle: true,
// //         title: Text(
// //           "Gold Coin Catalog",
// //           style: GoogleFonts.lexend(
// //             fontSize: 22,
// //             fontWeight: FontWeight.w700,
// //             color: const Color(0xFF1A0F12),
// //           ),
// //         ),
// //         actions: [
// //           Padding(
// //             padding: const EdgeInsets.only(right: 12),
// //             child: ElevatedButton(
// //               onPressed: () async {
// //                 await StorageService().erase();
// //                 Get.offNamed('/login');
// //               },
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: const Color(0xFF174873),
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(20),
// //                 ),
// //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// //               ),
// //               child: Text(
// //                 "Logout",
// //                 style: GoogleFonts.lexend(
// //                   fontSize: 16,
// //                   fontWeight: FontWeight.w700,
// //                   color: Colors.white,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),

// //       body: Obx(() {
// //         if (controller.isLoadingRate.value) {
// //           return const Center(child: CircularProgressIndicator());
// //         }

// //         if (controller.goldRate.value == null) {
// //           return const Center(child: Text("Unable to load gold rate"));
// //         }

// //         return SafeArea(
// //           child: Column(
// //             children: [
// //               Expanded(child: _buildGoldGrid(screenWidth)),
// //               const SizedBox(height: 20),
// //               _buildContinueButton(),
// //               const SizedBox(height: 12),
// //               Text(
// //                 "24k Pure Gold | 100% Safe & Secured",
// //                 style: GoogleFonts.lexend(
// //                   fontWeight: FontWeight.w500,
// //                   fontSize: 13,
// //                   color:const Color(0xFF09243D),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),
// //             ],
// //           ),
// //         );
// //       }),
// //     );
// //   }

// //   /// ✅ Grid layout using Catalog-style UI
// //   Widget _buildGoldGrid(double screenWidth) {
// //     return GridView.builder(
// //       padding: const EdgeInsets.all(12),
// //       itemCount: controller.weights.length,
// //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //         crossAxisCount: 2,
// //         childAspectRatio: 0.58,
// //         crossAxisSpacing: 12,
// //         mainAxisSpacing: 12,
// //       ),
// //       itemBuilder: (_, index) {
// //         final baseWeight = controller.weights[index];
// //         final imagePath = goldImages[index];
// //         final coinPrice = controller.getCoinPrice(baseWeight);

// //         return Obx(() {
// //           final quantity = controller.coinCount[index] ?? 1;
// //           final totalWeight = controller.getTotalWeightForCoin(index);

// //           return Container(
// //             decoration: BoxDecoration(
// //               border: Border.all(color: const Color(0xFF09243D), width: 2.2),
// //               borderRadius: BorderRadius.circular(16),
// //               color: Colors.white,
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.grey.withOpacity(0.15),
// //                   blurRadius: 6,
// //                   offset: const Offset(0, 3),
// //                 ),
// //               ],
// //             ),
// //             child: Padding(
// //               padding: const EdgeInsets.all(10),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: [
// //                   /// ✅ Coin image
// //                   ClipRRect(
// //                     borderRadius: BorderRadius.circular(10),
// //                     child: Image.asset(
// //                       imagePath,
// //                       height: 110,
// //                       width: double.infinity,
// //                       fit: BoxFit.contain,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 6),

// //                   /// ✅ Coin title
// //                   Text(
// //                     "$baseWeight GM Coin",
// //                     style: GoogleFonts.lexend(
// //                       fontSize: 15,
// //                       fontWeight: FontWeight.w700,
// //                       color: const Color(0xFF09243D),
// //                     ),
// //                   ),

// //                   /// ✅ Price label
// //                   const SizedBox(height: 6),
// //                   Container(
// //                     padding:
// //                         const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
// //                     decoration: BoxDecoration(
// //                       color: const Color(0xFF174873),
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                     child: Text(
// //                       "₹${coinPrice.toStringAsFixed(2)}",
// //                       style: GoogleFonts.lexend(
// //                         fontSize: 14,
// //                         fontWeight: FontWeight.w600,
// //                         color: Colors.white,
// //                       ),
// //                     ),
// //                   ),

// //                   const SizedBox(height: 10),

// //                   /// ✅ Quantity controls
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       _quantityButton("-", () => controller.decreaseCount(index)),
// //                       const SizedBox(width: 20),
// //                       Text(
// //                         "$quantity pcs",
// //                         style: GoogleFonts.lexend(
// //                           fontSize: 15,
// //                           fontWeight: FontWeight.w700,
// //                           color: const Color(0xFF09243D),
// //                         ),
// //                       ),
// //                       const SizedBox(width: 20),
// //                       _quantityButton("+", () => controller.increaseCount(index)),
// //                     ],
// //                   ),

// //                   const SizedBox(height: 8),

// //                   /// ✅ Total weight
// //                   Text(
// //                     "Total: ${totalWeight.toStringAsFixed(0)}g",
// //                     style: GoogleFonts.lexend(
// //                       fontSize: 13,
// //                       fontWeight: FontWeight.w600,
// //                       color: Colors.black54,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         });
// //       },
// //     );
// //   }

// //   /// ✅ Quantity +/- buttons
// //   Widget _quantityButton(String text, VoidCallback onTap) {
// //     return InkWell(
// //       onTap: onTap,
// //       borderRadius: BorderRadius.circular(8),
// //       child: Container(
// //         height: 32,
// //         width: 32,
// //         alignment: Alignment.center,
// //         decoration: BoxDecoration(
// //           color: const Color(0xFF174873),
// //           borderRadius: BorderRadius.circular(8),
// //         ),
// //         child: Text(
// //           text,
// //           style: GoogleFonts.lexend(
// //             fontWeight: FontWeight.w700,
// //             fontSize: 18,
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   /// ✅ Continue Button
// //   Widget _buildContinueButton() {
// //     return ElevatedButton(
      
// //       onPressed: () {
// //         Get.snackbar(
// //           "Gold Live Rate",
// //           "Rs. ${controller.goldRate.value!.priceGram24k.toStringAsFixed(2)} / gram",
// //           snackPosition: SnackPosition.BOTTOM,
// //           backgroundColor:const Color(0xFF09243D),
// //           colorText: Colors.white,
// //         );
// //       },
// //       style: ElevatedButton.styleFrom(
// //         backgroundColor: const Color(0xFF09243D),
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //         padding: const EdgeInsets.symmetric(vertical:14, horizontal: 80),
// //       ),
// //       child: Text(
// //         "Continue",
// //         style: GoogleFonts.lexend(
// //           fontSize: 18,
// //           fontWeight: FontWeight.w700,
// //           color: Colors.white,
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:aesera_jewels/modules/Gold_Coin/goldcoin_controller.dart';
// import 'package:aesera_jewels/services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class GoldCoinView extends GetView<GoldCoinController> {
//   GoldCoinView({super.key});

//   final GoldCoinController controller = Get.put(GoldCoinController());

//   final List<String> goldImages = [
//     'assets/images/1 gm coin.png',
//     'assets/images/2 gm coin.png',
//     'assets/images/4 gm.png',
//     'assets/images/10 gm.png',
//     'assets/images/20 gm.png',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: const Color(0xFFFDFBF6), // soft warm background
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 1,
//         centerTitle: true,
//         title: Text(
//           "Gold Coin Catalog",
//           style: GoogleFonts.lexend(
//             fontSize: 22,
//             fontWeight: FontWeight.w700,
//             color: const Color(0xFF1A0F12),
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 12),
//             child: ElevatedButton(
//               onPressed: () async {
//                 await StorageService().erase();
//                 Get.offNamed('/login');
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF09243D),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//               ),
//               child: Text(
//                 "Logout",
//                 style: GoogleFonts.lexend(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),

//       /// ✅ Main Body
//       body: Obx(() {
//         if (controller.isLoadingRate.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (controller.goldRate.value == null) {
//           return const Center(child: Text("Unable to load gold rate"));
//         }

//         return SafeArea(
//           child: Column(
//             children: [
//               Expanded(child: _buildGoldGrid(screenWidth)),
//               const SizedBox(height: 16),
//               _buildContinueButton(),
//               const SizedBox(height: 10),
//               Text(
//                 "24k Pure Gold | 100% Safe & Secured",
//                 style: GoogleFonts.lexend(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 13,
//                   color: const Color(0xFF09243D),
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   /// ✅ Catalog-style grid layout
//   Widget _buildGoldGrid(double screenWidth) {
//     return GridView.builder(
//       padding: const EdgeInsets.all(12),
//       itemCount: controller.weights.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 0.60,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//       itemBuilder: (_, index) {
//         final baseWeight = controller.weights[index];
//         final imagePath = goldImages[index];
//         final coinPrice = controller.getCoinPrice(baseWeight);

//         return Obx(() {
//           final quantity = controller.coinCount[index] ?? 1;
//           final totalWeight = controller.getTotalWeightForCoin(index);

//           return Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: const Color(0xFF09243D), width: 2),
//               borderRadius: BorderRadius.circular(16),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.15),
//                   blurRadius: 8,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   /// ✅ Coin Image
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.asset(
//                       imagePath,
//                       height: 110,
//                       width: double.infinity,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   const SizedBox(height: 8),

//                   /// ✅ Coin Title
//                   Text(
//                     "$baseWeight GM Coin",
//                     style: GoogleFonts.lexend(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w700,
//                       color: const Color(0xFF09243D),
//                     ),
//                   ),
//                   const SizedBox(height: 6),

//                   /// ✅ Price Label
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFFFB700),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Text(
//                       "₹${coinPrice.toStringAsFixed(2)}",
//                       style: GoogleFonts.lexend(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 10),

//                   /// ✅ Quantity Controls
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _quantityButton("-", () => controller.decreaseCount(index),
//                           const Color(0xFFFFB700)),
//                       const SizedBox(width: 18),
//                       Text(
//                         "$quantity pcs",
//                         style: GoogleFonts.lexend(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700,
//                           color: const Color(0xFF09243D),
//                         ),
//                       ),
//                       const SizedBox(width: 18),
//                       _quantityButton("+", () => controller.increaseCount(index),
//                           const Color(0xFF09243D)),
//                     ],
//                   ),

//                   const SizedBox(height: 8),

//                   /// ✅ Total Weight
//                   Text(
//                     "Total: ${totalWeight.toStringAsFixed(0)}g",
//                     style: GoogleFonts.lexend(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//       },
//     );
//   }

//   /// ✅ Quantity Buttons
//   Widget _quantityButton(String text, VoidCallback onTap, Color color) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(8),
//       child: Container(
//         height: 30,
//         width: 30,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           text,
//           style: GoogleFonts.lexend(
//             fontWeight: FontWeight.w700,
//             fontSize: 18,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }

//   /// ✅ Continue Button
//   Widget _buildContinueButton() {
//     return ElevatedButton(
//       onPressed: () {
//         Get.snackbar(
//           "Gold Live Rate",
//           "Rs. ${controller.goldRate.value!.priceGram24k.toStringAsFixed(2)} / gram",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: const Color(0xFF09243D),
//           colorText: Colors.white,
//         );
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFF09243D),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 80),
//       ),
//       child: Text(
//         "Continue",
//         style: GoogleFonts.lexend(
//           fontSize: 18,                   
//           fontWeight: FontWeight.w700,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
import 'package:aesera_jewels/modules/Gold_Coin/goldcoin_controller.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GoldCoinView extends GetView<GoldCoinController> {
  GoldCoinView({super.key});

  final GoldCoinController controller = Get.put(GoldCoinController());

  final List<String> goldImages = [
    'assets/images/1 gm coin.png',
    'assets/images/2 gm coin.png',
    'assets/images/4 gm.png',
    'assets/images/10 gm.png',
    'assets/images/20 gm.png',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Gold Coin Catalog",
          style: GoogleFonts.lexend(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A0F12),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
              onPressed: () async {
                await StorageService().erase();
                Get.offNamed('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF09243D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Text(
                "Logout",
                style: GoogleFonts.lexend(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoadingRate.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.goldRate.value == null) {
          return const Center(child: Text("Unable to load gold rate"));
        }

        return SafeArea(
          child: Column(
            children: [
              Expanded(child: _buildGoldGrid(screenWidth)),
              const SizedBox(height: 16),
              _buildContinueButton(),
              const SizedBox(height: 10),
              Text(
                "24k Pure Gold | 100% Safe & Secured",
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: const Color(0xFF09243D),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildGoldGrid(double screenWidth) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: controller.weights.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.60,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (_, index) {
        final baseWeight = controller.weights[index];
        final imagePath = goldImages[index];
        final coinPrice = controller.getCoinPrice(baseWeight);

        return Obx(() {
          final quantity = controller.coinCount[index] ?? 0;
          final totalWeight = controller.getTotalWeightForCoin(index);

          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF09243D), width: 2),
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imagePath,
                      height: 110,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "$baseWeight GM Coin",
                    style: GoogleFonts.lexend(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF09243D),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB700),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "₹${coinPrice.toStringAsFixed(2)}",
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _quantityButton("-", () => controller.decreaseCount(index),
                          const Color(0xFFFFB700)),
                      const SizedBox(width: 18),
                      Text(
                        "$quantity pcs",
                        style: GoogleFonts.lexend(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF09243D),
                        ),
                      ),
                      const SizedBox(width: 18),
                      _quantityButton("+", () => controller.increaseCount(index),
                          const Color(0xFF09243D)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Total: ${totalWeight.toStringAsFixed(0)}g",
                    style: GoogleFonts.lexend(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Widget _quantityButton(String text, VoidCallback onTap, Color color) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return ElevatedButton(
      onPressed: () {
        Get.snackbar(
          "Gold Live Rate",
          "Rs. ${controller.goldRate.value!.priceGram24k.toStringAsFixed(2)} / gram",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF09243D),
          colorText: Colors.white,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF09243D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 80),
      ),
      child: Text(
        "Continue",
        style: GoogleFonts.lexend(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
