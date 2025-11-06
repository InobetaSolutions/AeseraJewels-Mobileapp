
import 'package:aesera_jewels/models/catalog_model.dart';
import 'package:aesera_jewels/modules/Gold_Coin_Payment/goldcoin_payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GoldCoinPaymentScreen extends StatelessWidget {
  final List<Map<String, dynamic>> selectedCoins;

  GoldCoinPaymentScreen({super.key, required this.selectedCoins});

  final GoldCoinPaymentController controller = Get.put(
    GoldCoinPaymentController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Gold Coin Payment',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
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
        final finalTotal = subtotal + taxAmt + controller.deliveryCharge.value;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    Text(
                      "Current Rate Gold (24K)",
                      style: GoogleFonts.lexend(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: const Color(0xFFFFB700),
                      ),
                    ),
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

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB700),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
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
                              _cellText(
                                "₹${amt.toStringAsFixed(2)}",
                                highlight: true,
                              ),
                            ],
                          ),
                        ),
                        if (i != selectedCoins.length - 1)
                          const Divider(
                            color: Color(0xFF0A2A4D),
                            thickness: 0.8,
                            height: 8,
                          ),
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(height: 5),

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
                      "₹${taxAmt.toStringAsFixed(2)}",
                    ),
                    _row(
                      "Delivery",
                      "₹${controller.deliveryCharge.value.toStringAsFixed(2)}",
                    ),
                    const Divider(color: Colors.white54),
                    _row(
                      "Total Payable",
                      "₹${finalTotal.toStringAsFixed(2)}",
                      isBold: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Obx(
                () => GestureDetector(
                  onTap: controller.isLoading.value
                      ? null
                      : () {
                          if (controller.productList.isNotEmpty) {
                            controller.showPaymentMethodDialog(
                              controller.productList.first,
                            );
                          }
                        },
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
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Proceed to Pay",
                            style: TextStyle(color: Colors.white, fontSize: 20),
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
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
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
          Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 15,
              color: Colors.white,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.lexend(
              fontSize: 15,
              color: const Color(0xFFFFB700),
              fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}