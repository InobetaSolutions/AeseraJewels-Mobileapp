
// // import 'package:aesera_jewels/modules/Gold_Coin_Payment/goldcoin_payment_controller.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';

// // class GoldCoinPaymentScreen extends StatelessWidget {
// //   final List<Map<String, dynamic>> selectedCoins;

// //   GoldCoinPaymentScreen({super.key, required this.selectedCoins});

// //   final GoldCoinPaymentController controller =
// //       Get.put(GoldCoinPaymentController());

// //   @override
// //   Widget build(BuildContext context) {
// //     controller.fetchAPIs();

// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF9F4FA),
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //         centerTitle: true,
// //         title: const Text(
// //           'Gold Coin Payment',
// //           style: TextStyle(
// //               color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
// //         ),
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back, color: Colors.black),
// //           onPressed: () => Get.back(),
// //         ),
// //       ),
// //       body: Obx(() {
// //         if (controller.goldRate.value == 0) {
// //           return const Center(child: CircularProgressIndicator());
// //         }

// //         double totalAmount = 0;
// //         for (var item in selectedCoins) {
// //           final grams = item["weight"] * item["pieces"];
// //           totalAmount += grams * controller.goldRate.value;
// //         }

// //         final taxAmt = (controller.taxPercent.value / 100) * totalAmount;
// //         final totalPayable =
// //             totalAmount + taxAmt + controller.deliveryCharge.value;

// //         return Padding(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               /// Gold Rate Card
// //               Container(
// //                 width: double.infinity,
// //                 padding: const EdgeInsets.all(20),
// //                 decoration: BoxDecoration(
// //                   color: const Color(0xFF0A2A4D),
// //                   borderRadius: BorderRadius.circular(16),
// //                 ),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text("Current Rate Gold (24K)",
// //                         style: GoogleFonts.lexend(
// //                           fontWeight: FontWeight.w500,
// //                           fontSize: 16,
// //                           color: const Color(0xFFFFB700),
// //                         )),
// //                     const SizedBox(height: 8),
// //                     Text(
// //                       "₹${controller.goldRate.value.toStringAsFixed(2)}",
// //                       style: GoogleFonts.lexend(
// //                         fontWeight: FontWeight.w700,
// //                         fontSize: 24,
// //                         color: const Color(0xFFFFB700),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),

// //               const SizedBox(height: 20),

// //               /// Coins Card (All coins in one)
// //               Expanded(
// //                 child: SingleChildScrollView(
// //                   child: Container(
// //                     width: double.infinity,
// //                     padding: const EdgeInsets.all(20),
// //                     decoration: BoxDecoration(
// //                       color: const Color(0xFF0A2A4D),
// //                       borderRadius: BorderRadius.circular(16),
// //                     ),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         ...List.generate(selectedCoins.length, (i) {
// //                           final item = selectedCoins[i];
// //                           final grams = item["weight"] * item["pieces"];
// //                           final amt = grams * controller.goldRate.value;

// //                           return Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Row(
// //                                 mainAxisAlignment:
// //                                     MainAxisAlignment.spaceBetween,
// //                                 children: [
// //                                   Text("${item["weight"]} GM Coin",
// //                                       style: GoogleFonts.lexend(
// //                                           fontSize: 16,
// //                                           color: Colors.white,
// //                                           fontWeight: FontWeight.w600)),
// //                                   Text("₹${amt.toStringAsFixed(2)}",
// //                                       style: GoogleFonts.lexend(
// //                                           fontSize: 16,
// //                                           color: const Color(0xFFFFB700),
// //                                           fontWeight: FontWeight.bold)),
// //                                 ],
// //                               ),
// //                               const SizedBox(height: 6),
// //                               _row("Pieces", "${item["pieces"]}"),
// //                               _row("Total Grams",
// //                                   "${grams.toStringAsFixed(2)} g"),
// //                               if (i != selectedCoins.length - 1)
// //                                 const Divider(color: Colors.white54),
// //                               const SizedBox(height: 10),
// //                             ],
// //                           );
// //                         }),

// //                         const Divider(color: Colors.white54),
// //                         _row("Subtotal", "₹${totalAmount.toStringAsFixed(2)}"),
// //                         _row(
// //                             "Tax (${controller.taxPercent.value.toStringAsFixed(0)}%)",
// //                             "₹${taxAmt.toStringAsFixed(2)}"),
// //                         _row(
// //                             "Delivery",
// //                             "₹${controller.deliveryCharge.value.toStringAsFixed(2)}"),
// //                         const Divider(color: Colors.white54),
// //                         _row("Total Payable",
// //                             "₹${totalPayable.toStringAsFixed(2)}",
// //                             isBold: true),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),

// //               const SizedBox(height: 20),

// //               /// Submit Button
// //               Obx(() => GestureDetector(
// //                     onTap: controller.isLoading.value
// //                         ? null
// //                         : () => controller.confirmPayment(
// //                               () => controller.submitPayment(selectedCoins),
// //                             ),
// //                     child: Container(
// //                       width: double.infinity,
// //                       height: 55,
// //                       decoration: BoxDecoration(
// //                         color: controller.isLoading.value
// //                             ? Colors.grey
// //                             : const Color(0xFF09243D),
// //                         borderRadius: BorderRadius.circular(30),
// //                         boxShadow: [
// //                           BoxShadow(
// //                             color: Colors.black.withOpacity(0.2),
// //                             blurRadius: 6,
// //                             offset: const Offset(0, 3),
// //                           )
// //                         ],
// //                       ),
// //                       alignment: Alignment.center,
// //                       child: controller.isLoading.value
// //                           ? const CircularProgressIndicator(color: Colors.white)
// //                           : const Text(
// //                               "Submit Payment",
// //                               style: TextStyle(
// //                                   color: Colors.white, fontSize: 18),
// //                             ),
// //                     ),
// //                   )),
// //             ],
// //           ),
// //         );
// //       }),
// //     );
// //   }

// //   Widget _row(String title, String value, {bool isBold = false}) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 2),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Text(title,
// //               style: GoogleFonts.lexend(
// //                 fontSize: 14,
// //                 color: Colors.white,
// //                 fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
// //               )),
// //           Text(value,
// //               style: GoogleFonts.lexend(
// //                 fontSize: 14,
// //                 color: const Color(0xFFFFB700),
// //                 fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
// //               )),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:aesera_jewels/modules/Gold_Coin_Payment/goldcoin_payment_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class GoldCoinPaymentScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> selectedCoins;

//   GoldCoinPaymentScreen({super.key, required this.selectedCoins});

//   final GoldCoinPaymentController controller =
//       Get.put(GoldCoinPaymentController());

//   @override
//   Widget build(BuildContext context) {
//     controller.fetchAPIs();

//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F4FA),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           'Gold Coin Payment',
//           style: TextStyle(
//               color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       body: Obx(() {
//         if (controller.goldRate.value == 0) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         double subtotal = 0;
//         for (var item in selectedCoins) {
//           final grams = item["weight"] * item["pieces"];
//           subtotal += grams * controller.goldRate.value;
//         }

//         final taxAmt = (controller.taxPercent.value / 100) * subtotal;
//         final totalPayable =
//             subtotal + taxAmt + controller.deliveryCharge.value;

//         return Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// 🔹 Gold Rate Card
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
//                     Text("Current Rate Gold (24K)",
//                         style: GoogleFonts.lexend(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 16,
//                           color: const Color(0xFFFFB700),
//                         )),
//                     const SizedBox(height: 8),
//                     Text(
//                       "₹${controller.goldRate.value.toStringAsFixed(2)} / gm",
//                       style: GoogleFonts.lexend(
//                         fontWeight: FontWeight.w700,
//                         fontSize: 22,
//                         color: const Color(0xFFFFB700),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),

//               /// 🧾 Table Header
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _headerText("Coin"),
                  
//                     _headerText("Pcs"),
      
//                     _headerText("Amount"),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 8),

//               /// 💎 Coins List
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: selectedCoins.length,
//                   itemBuilder: (_, i) {
//                     final item = selectedCoins[i];
//                     final grams = item["weight"] * item["pieces"];
//                     final amt = grams * controller.goldRate.value;
//                     final rateText =
//                         "₹${controller.goldRate.value.toStringAsFixed(0)}×${grams.toStringAsFixed(1)}";

//                     return Container(
//                       margin: const EdgeInsets.symmetric(vertical: 4),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF0A2A4D),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           _cellText("${item["weight"]} gm"),
//                           _cellText("${item["pieces"]}"),
//                           _cellText("₹${amt.toStringAsFixed(2)}",
//                               highlight: true),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),

//               /// 💰 Summary Card
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
//                     _row("total Amount", "₹${subtotal.toStringAsFixed(2)}"),
//                     _row(
//                         "Tax (${controller.taxPercent.value.toStringAsFixed(0)}%)",
//                         "₹${taxAmt.toStringAsFixed(2)}"),
//                     _row("Delivery",
//                         "₹${controller.deliveryCharge.value.toStringAsFixed(2)}"),
//                     const Divider(color: Colors.white54),
//                     _row("Total Payable", "₹${totalPayable.toStringAsFixed(2)}",
//                         isBold: true),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),

//               /// ✅ Proceed Button
//               Obx(
//                 () => GestureDetector(
//                   onTap: controller.isLoading.value
//                       ? null
//                       : () => controller.confirmPayment(totalPayable),
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
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 6,
//                             offset: const Offset(0, 3))
//                       ],
//                     ),
//                     alignment: Alignment.center,
//                     child: controller.isLoading.value
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                             "Proceed to Pay",
//                             style:
//                                 TextStyle(color: Colors.white, fontSize: 18),
//                           ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   Text _headerText(String text) => Text(
//         text,
//         style: GoogleFonts.lexend(
//             fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
//       );

//   Text _cellText(String text, {bool highlight = false}) => Text(
//         text,
//         style: GoogleFonts.lexend(
//           fontSize: 13,
//           fontWeight: FontWeight.w500,
//           color: highlight ? const Color(0xFFFFB700) : Colors.white,
//         ),
//       );

//   Widget _row(String label, String value, {bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label,
//               style: GoogleFonts.lexend(
//                 fontSize: 15,
//                 color: Colors.white,
//                 fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
//               )),
//           Text(value,
//               style: GoogleFonts.lexend(
//                 fontSize: 15,
//                 color: const Color(0xFFFFB700),
//                 fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
//               )),
//         ],
//       ),
//     );
//   }
// }
import 'package:aesera_jewels/modules/Gold_Coin_Payment/goldcoin_payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GoldCoinPaymentScreen extends StatelessWidget {
  final List<Map<String, dynamic>> selectedCoins;

  GoldCoinPaymentScreen({super.key, required this.selectedCoins});

  final GoldCoinPaymentController controller =
      Get.put(GoldCoinPaymentController());

  @override
  Widget build(BuildContext context) {
    controller.fetchAPIs();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Gold Coin Payment',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.goldRate.value == 0) {
          return const Center(child: CircularProgressIndicator());
        }

        double subtotal = 0;
        for (var item in selectedCoins) {
          final grams = item["weight"] * item["pieces"];
          subtotal += grams * controller.goldRate.value;
        }

        final taxAmt = (controller.taxPercent.value / 100) * subtotal;
        final totalPayable =
            subtotal + taxAmt + controller.deliveryCharge.value;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 Gold Rate Card
              Container(
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
                    Text(
                      "₹${controller.goldRate.value.toStringAsFixed(2)} / gm",
                      style: GoogleFonts.lexend(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: const Color(0xFFFFB700),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
/// 💎 Coins List (single card with dividers between coin rows)
Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color:  const Color(0xFFFFB700) ,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _headerText("Coin"),
                    _headerText("QTY"),
                    _headerText("Amount"),
                  ],
                ),
              ),
              const SizedBox(height: 8),
Container(
  width: double.infinity,
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  decoration: BoxDecoration(
    color: const Color(0xFF0A2A4D),
    borderRadius: BorderRadius.circular(10),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(selectedCoins.length, (i) {
      final item = selectedCoins[i];
      final grams = item["weight"] * item["pieces"];
      final amt = grams * controller.goldRate.value;

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _cellText("${item["weight"]} gm"),
                _cellText("${item["pieces"]} "),
                _cellText("₹${amt.toStringAsFixed(2)}", highlight: true),
              ],
            ),
          ),
          if (i != selectedCoins.length - 1)
            const Divider(
              color:  const Color(0xFF0A2A4D),
              thickness: 0.8,
              height: 8,
            ),
        ],
      );
    }),
  ),
),
SizedBox(height: 5,),
              // /// 🧾 Table Header (Removed weight column)
              // Container(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              //   decoration: BoxDecoration(
              //     color:  const Color(0xFFFFB700) ,
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       _headerText("Coin"),
              //       _headerText("Pcs"),
              //       _headerText("Amount"),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 8),

              // /// 💎 Coins List (non-scroll, constant cards)
              // Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: List.generate(selectedCoins.length, (i) {
              //     final item = selectedCoins[i];
              //     final grams = item["weight"] * item["pieces"];
              //     final amt = grams * controller.goldRate.value;

              //     return Container(
              //       margin: const EdgeInsets.symmetric(vertical: 4),
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 12, vertical: 10),
              //       decoration: BoxDecoration(
              //         color: const Color(0xFF0A2A4D),
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           _cellText("${item["weight"]} gm"),
              //           _cellText("${item["pieces"]}"),
              //           _cellText("₹${amt.toStringAsFixed(2)}",
              //               highlight: true),
              //         ],
              //       ),
              //     );
              //   }),
              // ),

              /// 💰 Summary Card (moved up, no space)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A2A4D),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _row("Total Amount", "₹${subtotal.toStringAsFixed(2)}"),
                    _row(
                        "Tax (${controller.taxPercent.value.toStringAsFixed(0)}%)",
                        "₹${taxAmt.toStringAsFixed(2)}"),
                    _row("Delivery",
                        "₹${controller.deliveryCharge.value.toStringAsFixed(2)}"),
                    const Divider(color: Colors.white54),
                    _row("Total Payable", "₹${totalPayable.toStringAsFixed(2)}",
                        isBold: true),
                  ],
                ),
              ),

              /// ✅ Proceed Button
              const SizedBox(height: 16),
              Obx(
                () => GestureDetector(
                  onTap: controller.isLoading.value
                      ? null
                      : () => controller.confirmPayment(totalPayable),
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: controller.isLoading.value
                          ? Colors.grey
                          : const Color(0xFF09243D),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3))
                      ],
                    ),
                    alignment: Alignment.center,
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Proceed to Pay",
                            style:
                                TextStyle(color: Colors.white, fontSize:20),
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Text _headerText(String text) => Text(
        text,
        style: GoogleFonts.lexend(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
      );

  Text _cellText(String text, {bool highlight = false}) => Text(
        text,
        style: GoogleFonts.lexend(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: highlight ? const Color(0xFFFFB700) : Colors.white,
        ),
      );

  Widget _row(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: GoogleFonts.lexend(
                fontSize: 15,
                color: Colors.white,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
              )),
          Text(value,
              style: GoogleFonts.lexend(
                fontSize: 15,
                color: const Color(0xFFFFB700),
                fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
              )),
        ],
      ),
    );
  }
}
