// import 'package:aesera_jewels/models/goldcoin_payment_model.dart';
// import 'package:aesera_jewels/modules/Gold_Coin_Payment/goldcoin_payment_controller.dart';
// import 'package:aesera_jewels/services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class GoldCoinPaymentScreen extends StatelessWidget {
//   final GoldCoinPaymentModel summary;
//   const GoldCoinPaymentScreen({super.key, required this.summary});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(GoldCoinPaymentController(summary));

//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F4FA),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text('Gold Coin Payment',
//             style: TextStyle(
//                 color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Get.back(),
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: () async {
//               await StorageService().erase();
//               Get.offAllNamed('/login');
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFFFB700),
//               shape:
//                   RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//             ),
//             child: Text("Logout",
//                 style: GoogleFonts.lexend(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.black)),
//           ),
//           const SizedBox(width: 10),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Obx(() {
//           if (controller.goldRate.value == null) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// Current Gold Rate Card
//                 Align(
//                   alignment: Alignment.center,
//                   child: Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF0A2A4D),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Current Rate Gold (24K)",
//                             style: GoogleFonts.lexend(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16,
//                               color: const Color(0xFFFFB700),
//                             )),
//                         const SizedBox(height: 8),
//                         Text(
//                           "₹${controller.goldRate.value!.priceGram24k.toStringAsFixed(2)} / gram",
//                           style: GoogleFonts.lexend(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 /// Selected Coins Summary
//                 Text("Selected Gold Coins",
//                     style: GoogleFonts.lexend(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black)),
//                 const SizedBox(height: 12),

//                 Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.15),
//                         blurRadius: 8,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: summary.selectedCoins.map((coin) {
//                       return ListTile(
//                         leading: const Icon(Icons.circle, color: Colors.amber),
//                         title: Text(
//                           "${coin.weight} gm × ${coin.quantity} pcs",
//                           style: GoogleFonts.lexend(
//                               fontSize: 16, fontWeight: FontWeight.w600),
//                         ),
//                         subtitle: Text(
//                             "Total Weight: ${coin.totalWeight.toStringAsFixed(1)}g"),
//                         trailing: Text(
//                           "₹${coin.totalPrice.toStringAsFixed(2)}",
//                           style: GoogleFonts.lexend(
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                               color: const Color(0xFF0A2A4D)),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 /// Totals Section
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFFDFBF6),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: const Color(0xFF09243D), width: 1.2),
//                   ),
//                   child: Column(
//                     children: [
//                       _buildRow(
//                           "Total Weight", "${summary.totalGrams.toStringAsFixed(1)} g"),
//                       const SizedBox(height: 8),
//                       _buildRow("Subtotal", "₹${summary.totalAmount.toStringAsFixed(2)}"),
//                       const SizedBox(height: 8),
//                       _buildRow("GST (${controller.gstPercentage.value.toStringAsFixed(1)}%)",
//                           "₹${controller.gstAmount.value.toStringAsFixed(2)}"),
//                       const SizedBox(height: 8),
//                       _buildRow("Delivery Charge",
//                           "₹${controller.deliveryCharge.value.toStringAsFixed(2)}"),
//                       const Divider(height: 20, thickness: 1),
//                       _buildRow(
//                         "Total Payable",
//                         "₹${controller.totalPayable.value.toStringAsFixed(2)}",
//                         isBold: true,
//                         color: const Color(0xFF0A2A4D),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 40),

//                 /// Confirm Payment Button
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () => controller.confirmPayment(),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF0A2A4D),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 60, vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: Text(
//                       "Confirm Payment",
//                       style: GoogleFonts.lexend(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }

//   /// Helper Row for displaying payment details
//   Widget _buildRow(String label, String value,
//       {bool isBold = false, Color? color}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(label,
//             style: GoogleFonts.lexend(
//                 fontSize: 15,
//                 fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
//                 color: color ?? Colors.black)),
//         Text(value,
//             style: GoogleFonts.lexend(
//                 fontSize: 15,
//                 fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
//                 color: color ?? Colors.black)),
//       ],
//     );
//   }
// }
import 'package:aesera_jewels/models/goldcoin_payment_model.dart';
import 'package:aesera_jewels/modules/Gold_Coin_Payment/goldcoin_payment_controller.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GoldCoinPaymentScreen extends GetView<GoldCoinPaymentController> {
  final GoldCoinPaymentModel model;
  const GoldCoinPaymentScreen({super.key, required this.model, required summary});

  @override
  Widget build(BuildContext context) {
    final GoldCoinPaymentController controller =
        Get.put(GoldCoinPaymentController(model));

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
        actions: [
          ElevatedButton(
            onPressed: () async {
              await StorageService().erase();
              Get.offAllNamed('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFB700),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
            ),
            child: Text(
              "Logout",
              style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.isLoadingRate.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Gold Rate Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: const Color(0xFF0A2A4D),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Current Gold Rate (24K)",
                        style: GoogleFonts.lexend(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: const Color(0xFFFFB700))),
                    const SizedBox(height: 8),
                    Obx(() => Text(
                          controller.goldRate.value != null
                              ? "₹${controller.goldRate.value!.priceGram24k.toStringAsFixed(2)} / gram"
                              : "No Data",
                          style: GoogleFonts.lexend(
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                              color: const Color(0xFFFFB700)),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              /// Coin Details
              Expanded(
                child: ListView(
                  children: model.coinQuantities.keys.map((key) {
                    final pcs = model.coinQuantities[key]!;
                    final grams = model.totalWeights[key]!;
                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: Text("$key Coin",
                            style: GoogleFonts.lexend(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF09243D))),
                        subtitle: Text("Quantity: $pcs pcs",
                            style: GoogleFonts.lexend(fontSize: 14)),
                        trailing: Text("${grams.toStringAsFixed(2)} g",
                            style: GoogleFonts.lexend(
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFFFB700))),
                      ),
                    );
                  }).toList(),
                ),
              ),

              /// Booking Summary Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: const Color(0xFF0A2A4D),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _row("Total Weight", "${model.totalGrams} gms"),
                    const SizedBox(height: 8),
                    Obx(() => _row("Gold Value",
                        "₹${(model.totalGrams * (controller.goldRate.value?.priceGram24k ?? 0)).toStringAsFixed(2)}")),
                    const SizedBox(height: 8),
                    Obx(() => _row("GST (${controller.gstPercentage.value.toStringAsFixed(0)}%)",
                        "₹${controller.gstAmount.value.toStringAsFixed(2)}")),
                    const SizedBox(height: 8),
                    Obx(() => _row("Delivery Charge",
                        "₹${controller.deliveryCharge.value.toStringAsFixed(2)}")),
                    const Divider(color: Colors.white54),
                    Obx(() => _row("Total Payable",
                        "₹${controller.totalPayable.value.toStringAsFixed(2)}",
                        bold: true)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              /// Proceed Button
              Obx(
                () => GestureDetector(
                  onTap:
                      controller.isLoading.value ? null : controller.confirmPayment,
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    alignment: Alignment.center,
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
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Proceed to Pay",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _row(String title, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: GoogleFonts.lexend(
                fontSize: 16,
                color: Colors.white,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        Text(value,
            style: GoogleFonts.lexend(
                fontSize: 16,
                color: Colors.amber,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }
}
