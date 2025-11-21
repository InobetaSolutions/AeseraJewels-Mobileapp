
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
