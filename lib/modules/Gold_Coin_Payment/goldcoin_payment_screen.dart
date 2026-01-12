import 'package:aesera_jewels/modules/Gold_Coin_Payment/goldcoin_payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GoldCoinPaymentScreen extends StatelessWidget {
  final List<Map<String, dynamic>> selectedCoins;

  const GoldCoinPaymentScreen({super.key, required this.selectedCoins});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final GoldCoinPaymentController controller = Get.put(
      GoldCoinPaymentController(),
    );

    // Set selected coins when screen builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setSelectedCoins(selectedCoins);
    });

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
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Obx(() {
        if (controller.goldRate.value == 0) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gold Rate Card
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

              // Table Header
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

              // Coin Items
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
                    final weight = item["weight"] ?? 0.0;
                    final pieces = item["pieces"] ?? 0;
                    final grams = weight * pieces;
                    final amount = grams * controller.goldRate.value;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _cellText("${weight.toStringAsFixed(1)} gm"),
                              _cellText("$pieces"),
                              _cellText(
                                "₹${amount.toStringAsFixed(2)}",
                                highlight: true,
                              ),
                            ],
                          ),
                        ),
                        if (i != selectedCoins.length - 1)
                          const Divider(
                            color: Color(0xFF1E3A5C),
                            thickness: 0.8,
                            height: 8,
                          ),
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(height: 5),

              // Price Summary
              Obx(
                () => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A2A4D),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _row(
                        "Total Amount",
                        "₹${controller.subtotalAmount.value.toStringAsFixed(2)}",
                      ),
                      _row(
                        "Tax (${controller.taxPercent.value.toStringAsFixed(0)}%)",
                        "₹${controller.taxAmount.value.toStringAsFixed(2)}",
                      ),
                      _row(
                        "Delivery",
                        "₹${controller.deliveryCharge.value.toStringAsFixed(2)}",
                      ),
                      const Divider(color: Colors.white54),
                      _row(
                        "Total Payable",
                        "₹${controller.totalPayable.value.toStringAsFixed(2)}",
                        isBold: true,
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Proceed to Pay Button
              Obx(
                () => GestureDetector(
                  onTap: controller.isLoading.value
                      ? null
                      : () {
                          // Make sure to call the payment method from your button like this:
                          controller.showPaymentMethodDialog();
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
