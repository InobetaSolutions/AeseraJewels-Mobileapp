// // // import 'package:aesera_jewels/models/summary_model.dart';
// // // import 'package:aesera_jewels/modules/summary/summary_controller.dart';
// // // import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
// // // import 'package:aesera_jewels/services/storage_service.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:google_fonts/google_fonts.dart';

// // // class SummaryScreen extends StatelessWidget {
// // //   final SummaryModel summary;
// // //   SummaryScreen({super.key, required this.summary});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final SummaryController controller = Get.put(SummaryController(summary));
// // //     final data = controller.summary.value;

// // //     if (data == null) {
// // //       return const Scaffold(
// // //         body: Center(child: Text("No summary data found")),
// // //       );
// // //     }

// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFFF9F4FA),
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.transparent,
// // //         elevation: 0,
// // //         centerTitle: true,
// // //         title: const Text(
// // //           'Booking Summary',
// // //           style: TextStyle(
// // //             color: Colors.black,
// // //             fontWeight: FontWeight.bold,
// // //             fontSize: 22,
// // //           ),
// // //         ),
// // //         leading: IconButton(
// // //           icon: const Icon(Icons.arrow_back, color: Colors.black),
// // //           onPressed: () => Get.to(() => DashboardScreen()),
// // //         ),
// // //         actions: [
// // //           ElevatedButton(
// // //             onPressed: () async {
// // //               await StorageService().erase();
// // //               Get.offAllNamed('/login');
// // //             },
// // //             style: ElevatedButton.styleFrom(
// // //               backgroundColor: const Color(0xFFFFB700),
// // //               shape: RoundedRectangleBorder(
// // //                 borderRadius: BorderRadius.circular(18),
// // //               ),
// // //             ),
// // //             child: Text(
// // //               "Logout",
// // //               style: GoogleFonts.lexend(
// // //                 fontSize: 14,
// // //                 fontWeight: FontWeight.w700,
// // //                 color: Colors.black,
// // //               ),
// // //             ),
// // //           ),
// // //           const SizedBox(width: 10),
// // //         ],
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             /// ✅ Booking Summary Card
// // //             Obx(() => _buildSummaryCard(
// // //                   data.goldQuantity,
// // //                   data.goldValue,
// // //                   controller.gstPercentage.value,
// // //                   controller.gstAmount.value,
// // //                   controller.totalPayable.value,
// // //                 )),

// // //             const SizedBox(height: 20),

// // //             /// ✅ Offers & Rewards
// // //             Container(
// // //               width: double.infinity,
// // //               padding: const EdgeInsets.all(20),
// // //               decoration: BoxDecoration(
// // //                 color: Colors.white,
// // //                 borderRadius: BorderRadius.circular(12),
// // //                 border: Border.all(color: Colors.grey.shade300),
// // //               ),
// // //               child: Row(
// // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                 children: [
// // //                   Text("Offers & Rewards",
// // //                       style: GoogleFonts.lexend(
// // //                           fontSize: 16, fontWeight: FontWeight.w600)),
// // //                   Text("View more coupons",
// // //                       style: GoogleFonts.lexend(
// // //                           fontSize: 14,
// // //                           color: Colors.blue,
// // //                           fontWeight: FontWeight.w400)),
// // //                 ],
// // //               ),
// // //             ),

// // //             const Spacer(),

// // //             /// ✅ Proceed Button
// // //             Obx(() => GestureDetector(
// // //                   onTap: controller.isLoading.value
// // //                       ? null
// // //                       : controller.confirmPayment,
// // //                   child: Container(
// // //                     width: double.infinity,
// // //                     height: 55,
// // //                     decoration: BoxDecoration(
// // //                       color: controller.isLoading.value
// // //                           ? Colors.grey
// // //                           : const Color(0xFF09243D),
// // //                       borderRadius: BorderRadius.circular(30),
// // //                       boxShadow: [
// // //                         BoxShadow(
// // //                           color: Colors.black.withOpacity(0.2),
// // //                           blurRadius: 6,
// // //                           offset: const Offset(0, 3),
// // //                         )
// // //                       ],
// // //                     ),
// // //                     alignment: Alignment.center,
// // //                     child: controller.isLoading.value
// // //                         ? const CircularProgressIndicator(color: Colors.white)
// // //                         : const Text(
// // //                             "Proceed to Pay",
// // //                             style: TextStyle(color: Colors.white, fontSize: 18),
// // //                           ),
// // //                   ),
// // //                 )),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   /// ✅ Booking Summary Card
// // //   Widget _buildSummaryCard(double goldQty, double goldValue, double gstPercent,
// // //       double gstAmount, double totalPayable) {
// // //     return Container(
// // //       width: double.infinity,
// // //       padding: const EdgeInsets.all(20),
// // //       decoration: BoxDecoration(
// // //         color: const Color(0xFF0A2A4D),
// // //         borderRadius: BorderRadius.circular(16),
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           _buildRow("Gold Quantity", "${goldQty.toStringAsFixed(4)} gm"),
// // //           const SizedBox(height: 8),
// // //           _buildRow("Gold Value", "₹${goldValue.toStringAsFixed(2)}"),
// // //           const SizedBox(height: 8),
// // //           _buildRow("GST ($gstPercent%)", "₹${gstAmount.toStringAsFixed(2)}"),
// // //           const Divider(color: Colors.white54),
// // //           _buildRow("Amount Payable", "₹${totalPayable.toStringAsFixed(2)}",
// // //               isBold: true),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   /// ✅ Row Widget
// // //   Widget _buildRow(String label, String value, {bool isBold = false}) {
// // //     return Row(
// // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //       children: [
// // //         Text(label,
// // //             style: GoogleFonts.lexend(
// // //               fontSize: 16,
// // //               color: Colors.white,
// // //               fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
// // //             )),
// // //         Text(value,
// // //             style: GoogleFonts.lexend(
// // //               fontSize: 16,
// // //               color: Colors.amber,
// // //               fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
// // //             )),
// // //       ],
// // //     );
// // //   }
// // // }
// // import 'package:aesera_jewels/models/summary_model.dart';
// // import 'package:aesera_jewels/modules/summary/summary_controller.dart';
// // import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
// // import 'package:aesera_jewels/services/storage_service.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';

// // class SummaryScreen extends StatelessWidget {
// //   final SummaryModel summary;
// //   SummaryScreen({super.key, required this.summary});

// //   @override
// //   Widget build(BuildContext context) {
// //     final SummaryController controller = Get.put(SummaryController(summary));
// //     final data = controller.summary.value;

// //     if (data == null) {
// //       return const Scaffold(
// //         body: Center(child: Text("No summary data found")),
// //       );
// //     }

// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF9F4FA),
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //         centerTitle: true,
// //         title: const Text(
// //           'Booking Summary',
// //           style: TextStyle(
// //             color: Colors.black,
// //             fontWeight: FontWeight.bold,
// //             fontSize: 22,
// //           ),
// //         ),
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back, color: Colors.black),
// //           onPressed: () => Get.to(() => DashboardScreen()),
// //         ),
// //         actions: [
// //           ElevatedButton(
// //             onPressed: () async {
// //               await StorageService().erase();
// //               Get.offAllNamed('/login');
// //             },
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: const Color(0xFFFFB700),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(18),
// //               ),
// //             ),
// //             child: Text(
// //               "Logout",
// //               style: GoogleFonts.lexend(
// //                 fontSize: 14,
// //                 fontWeight: FontWeight.w700,
// //                 color: Colors.black,
// //               ),
// //             ),
// //           ),
// //           const SizedBox(width: 10),
// //         ],
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             /// ✅ Gold Rate Card
// //             Align(
// //               alignment: Alignment.center,
// //               child: Container(
// //                 width: 297,
// //                 height: 120,
// //                 decoration: BoxDecoration(
// //                   color: const Color(0xFF09243D),
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //                 padding: const EdgeInsets.all(16),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       "Current Rate Gold (24K)",
// //                       style: GoogleFonts.lexend(
// //                         fontWeight: FontWeight.w500,
// //                         fontSize: 16,
// //                         color: const Color(0xFFFFB700),
// //                       ),
// //                     ),
// //                     const SizedBox(height: 8),
// //                     Obx(() {
// //                       if (controller.goldRate.value != null) {
// //                         return Text(
// //                           "Rs. ${controller.goldRate.value!.priceGram24k.toStringAsFixed(2)}",
// //                           style: GoogleFonts.lexend(
// //                             fontWeight: FontWeight.w700,
// //                             fontSize: 24,
// //                             color: const Color(0xFFFFB700),
// //                           ),
// //                         );
// //                       } else {
// //                         return const Text("No Data",
// //                             style:
// //                                 TextStyle(fontSize: 18, color: Colors.white));
// //                       }
// //                     }),
// //                   ],
// //                 ),
// //               ),
// //             ),

// //             const SizedBox(height: 20),

// //             /// ✅ Booking Summary Card
// //             Obx(() {
// //               final s = controller.summary.value!;
// //               return _buildSummaryCard(s);
// //             }),

// //             const SizedBox(height: 20),

// //             /// ✅ Offers & Rewards
// //             Container(
// //               width: double.infinity,
// //               padding: const EdgeInsets.all(20),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(12),
// //                 border: Border.all(color: Colors.grey.shade300),
// //               ),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Text("Offers & Rewards",
// //                       style: GoogleFonts.lexend(
// //                           fontSize: 16, fontWeight: FontWeight.w600)),
// //                   Text("View more coupons",
// //                       style: GoogleFonts.lexend(
// //                           fontSize: 14,
// //                           color: Colors.blue,
// //                           fontWeight: FontWeight.w400)),
// //                 ],
// //               ),
// //             ),

// //             const SizedBox(height: 20),

// //             /// ✅ Text Summary
// //             if (data.textSummary.isNotEmpty)
// //               Text(
// //                 data.textSummary,
// //                 style: GoogleFonts.lexend(
// //                   fontSize: 14,
// //                   fontWeight: FontWeight.w400,
// //                   color: Colors.black87,
// //                 ),
// //               ),

// //             const Spacer(),

// //             /// ✅ Proceed Button
// //             Obx(() => GestureDetector(
// //                   onTap: controller.isLoading.value
// //                       ? null
// //                       : controller.confirmPayment,
// //                   child: Container(
// //                     width: double.infinity,
// //                     height: 55,
// //                     decoration: BoxDecoration(
// //                       color: controller.isLoading.value
// //                           ? Colors.grey
// //                           : const Color(0xFF09243D),
// //                       borderRadius: BorderRadius.circular(30),
// //                       boxShadow: [
// //                         BoxShadow(
// //                           color: Colors.black.withOpacity(0.2),
// //                           blurRadius: 6,
// //                           offset: const Offset(0, 3),
// //                         )
// //                       ],
// //                     ),
// //                     alignment: Alignment.center,
// //                     child: controller.isLoading.value
// //                         ? const CircularProgressIndicator(color: Colors.white)
// //                         : const Text(
// //                             "Proceed to Pay",
// //                             style:
// //                                 TextStyle(color: Colors.white, fontSize: 18),
// //                           ),
// //                   ),
// //                 )),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   /// ✅ Booking Summary Card
// //   Widget _buildSummaryCard(SummaryModel data) {
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.all(20),
// //       decoration: BoxDecoration(
// //         color: const Color(0xFF0A2A4D),
// //         borderRadius: BorderRadius.circular(16),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           _buildRow(
// //               "Gold Quantity", "${data.goldQuantity.toStringAsFixed(4)} gm"),
// //           const SizedBox(height: 8),
// //           _buildRow("Gold Value", "₹${data.goldValue.toStringAsFixed(2)}"),
// //           const SizedBox(height: 8),
// //           _buildRow("GST", "₹${data.gst.toStringAsFixed(2)}"),
// //           const Divider(color: Colors.white54),
// //           _buildRow("Amount Payable", "₹${data.amountPayable.toStringAsFixed(2)}",
// //               isBold: true),
// //         ],
// //       ),
// //     );
// //   }

// //   /// ✅ Row Widget
// //   Widget _buildRow(String label, String value, {bool isBold = false}) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         Text(label,
// //             style: GoogleFonts.lexend(
// //               fontSize: 16,
// //               color: Colors.white,
// //               fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
// //             )),
// //         Text(value,
// //             style: GoogleFonts.lexend(
// //               fontSize: 16,
// //               color: Colors.amber,
// //               fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
// //             )),
// //       ],
// //     );
// //   }
// // }
// import 'package:aesera_jewels/models/summary_model.dart';
// import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
// import 'package:aesera_jewels/services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'summary_controller.dart';

// class SummaryScreen extends StatelessWidget {
//   final SummaryModel summary;
//   SummaryScreen({super.key, required this.summary});

//   @override
//   Widget build(BuildContext context) {
//     final SummaryController controller = Get.put(SummaryController(summary));

//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F4FA),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           'Booking Summary',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Get.to(() => DashboardScreen()),
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: () async {
//               await StorageService().erase();
//               Get.offAllNamed('/login');
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFFFB700),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(18),
//               ),
//             ),
//             child: Text(
//               "Logout",
//               style: GoogleFonts.lexend(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(width: 10),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Obx(() {
//           if (controller.summary.value == null) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final s = controller.summary.value!;

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// Gold Rate Card
//               Align(
//                 alignment: Alignment.center,
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF0A2A4D),
//                     borderRadius: BorderRadius.circular(16),
//                   ),

//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Current Rate Gold (24K)",
//                         style: GoogleFonts.lexend(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 16,
//                           color: const Color(0xFFFFB700),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Obx(() {
//                         if (controller.goldRate.value != null) {
//                           return Text(
//                             "Rs. ${controller.goldRate.value!.priceGram24k.toStringAsFixed(2)}",
//                             style: GoogleFonts.lexend(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 24,
//                               color: const Color(0xFFFFB700),
//                             ),
//                           );
//                         } else {
//                           return const Text(
//                             "No Data",
//                             style: TextStyle(fontSize: 18, color: Colors.white),
//                           );
//                         }
//                       }),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               /// Booking Summary Card
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF0A2A4D),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildRow(
//                       "Gold Quantity",
//                       "${s.goldQuantity.toStringAsFixed(4)} gm",
//                     ),
//                     const SizedBox(height: 8),
//                     _buildRow(
//                       "Gold Value",
//                       "₹${s.goldValue.toStringAsFixed(2)}",
//                     ),
//                     const SizedBox(height: 8),

//                     // /// GST Row with % & Amount
//                     // Obx(() => _buildRow(
//                     //       "GST (${controller.gstPercentage.value.toStringAsFixed(2)}%)",
//                     //       "₹${controller.gstAmount.value.toStringAsFixed(2)}",
//                     //     )),

//                     /// GST Row with % & Amount
//                     Obx(
//                       () => _buildRow(
//                         "GST (${controller.gstPercentage.value.toStringAsFixed(0)}%)", // <-- show integer only
//                         "₹${controller.gstAmount.value.toStringAsFixed(2)}",
//                       ),
//                     ),

//                     const Divider(color: Colors.white54),
//                     Obx(
//                       () => _buildRow(
//                         "Amount Payable",
//                         "₹${controller.totalPayable.value.toStringAsFixed(2)}",
//                         isBold: true,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const Spacer(),

//               /// Proceed Button
//               Obx(
//                 () => GestureDetector(
//                   onTap: controller.isLoading.value
//                       ? null
//                       : controller.confirmPayment,
//                   child: Container(
//                     width: double.infinity,
//                     height: 55,
//                     decoration: BoxDecoration(
//                       color: controller.isLoading.value
//                           ? Colors.grey
//                           : const Color(0xFF09243D),
//                       borderRadius: BorderRadius.circular(30),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           blurRadius: 6,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     alignment: Alignment.center,
//                     child: controller.isLoading.value
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                             "Proceed to Pay",
//                             style: TextStyle(color: Colors.white, fontSize: 18),
//                           ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }

//   Widget _buildRow(String label, String value, {bool isBold = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.lexend(
//             fontSize: 16,
//             color: Colors.white,
//             fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//         Text(
//           value,
//           style: GoogleFonts.lexend(
//             fontSize: 16,
//             color: Colors.amber,
//             fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:aesera_jewels/models/summary_model.dart';
import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'summary_controller.dart';

class SummaryScreen extends StatelessWidget {
  final SummaryModel summary;
  SummaryScreen({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final SummaryController controller = Get.put(SummaryController(summary));

    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Booking Summary',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.to(() => DashboardScreen()),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await StorageService().erase();
              Get.offAllNamed('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFB700),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            ),
            child: Text(
              "Logout",
              style: GoogleFonts.lexend(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.summary.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final s = controller.summary.value!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Gold Rate Card
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A2A4D),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Current Rate Gold (24K)",
                          style: GoogleFonts.lexend(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: const Color(0xFFFFB700),
                          )),
                      const SizedBox(height: 8),
                      Obx(() {
                        if (controller.goldRate.value != null) {
                          return Text(
                            "Rs. ${controller.goldRate.value!.priceGram24k.toStringAsFixed(2)}",
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: const Color(0xFFFFB700),
                            ),
                          );
                        } else {
                          return const Text("No Data", style: TextStyle(fontSize: 18, color: Colors.white));
                        }
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// Booking Summary Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: const Color(0xFF0A2A4D), borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow("Gold Quantity", "${s.goldQuantity.toStringAsFixed(4)} gm"),
                    const SizedBox(height: 8),
                    _buildRow("Gold Value", "₹${s.goldValue.toStringAsFixed(2)}"),
                    const SizedBox(height: 8),
                    Obx(() => _buildRow(
                          "GST (${controller.gstPercentage.value.toStringAsFixed(0)}%)",
                          "₹${controller.gstAmount.value.toStringAsFixed(2)}",
                        )),
                    const SizedBox(height: 8),
                   // Obx(() => _buildRow("Delivery Charge", "₹${controller.deliveryCharge.value.toStringAsFixed(2)}")),
                    const Divider(color: Colors.white54),
                    Obx(() => _buildRow("Total Amount", "₹${controller.totalPayable.value.toStringAsFixed(2)}",
                        isBold: true)),
                  ],
                ),
              ),
              const Spacer(),

              /// Proceed Button
              Obx(
                () => GestureDetector(
                  onTap: controller.isLoading.value ? null : controller.confirmPayment,
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: controller.isLoading.value ? Colors.grey : const Color(0xFF09243D),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 3))],
                    ),
                    alignment: Alignment.center,
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Proceed to Pay", style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: GoogleFonts.lexend(
              fontSize: 16,
              color: Colors.white,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            )),
        Text(value,
            style: GoogleFonts.lexend(
              fontSize: 16,
              color: Colors.amber,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            )),
      ],
    );
  }
}
