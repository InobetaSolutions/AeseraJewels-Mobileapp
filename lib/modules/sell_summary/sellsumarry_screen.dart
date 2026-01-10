import 'package:aesera_jewels/modules/sell_summary/sellsummary_contoller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class SellsummaryScreen extends StatelessWidget {
  const SellsummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SellsummaryContoller controller = Get.put(SellsummaryContoller());

    final data = Get.arguments ?? {};
    final String value = data["value"] ?? "0";
    final bool isRupees = data["isRupees"] ?? true;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Selling Summary',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: const BackButton(color: Colors.black),
      ),
      body: Obx(() {
        // User typed value (always use this for display)
        String displayValue = value;

        // Wallet data only for validation
        bool hasSellData =
            controller.sellData.value.totalAmount != null &&
            controller.sellData.value.totalAmount!.isNotEmpty;

        double amount = 0;
        double grams = 0;

        if (isRupees) {
          amount = double.tryParse(displayValue) ?? 0;

          // Calculate grams when selling in rupees
          if (controller.goldRate.value != null &&
              controller.goldRate.value!.priceGram24k > 0) {
            grams = amount / controller.goldRate.value!.priceGram24k;
          } else {
            grams = 0;
          }
        } else {
          grams = double.tryParse(displayValue) ?? 0;

          // 🔥 Calculate amount when selling grams
          if (controller.goldRate.value != null &&
              controller.goldRate.value!.priceGram24k > 0) {
            amount = grams * controller.goldRate.value!.priceGram24k;
          } else {
            amount = 0;
          }
        }

        final double gst = (amount * controller.taxPercentage.value) / 100;
        final double delivery = controller.deliveryCharge.value.toDouble();
        final double gateway = controller.paymentGatewayCharge.value.toDouble();
        final double total = amount + gst + delivery + gateway;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // ✅ Add a note if using wallet balance
              if (hasSellData)
                // Container(
                //   width: double.infinity,
                //   padding: const EdgeInsets.all(12),
                //   margin: const EdgeInsets.only(bottom: 16),
                //   decoration: BoxDecoration(
                //     color: Colors.blue[50],
                //     borderRadius: BorderRadius.circular(10),
                //     border: Border.all(color: Colors.blue[100]!),
                //   ),
                //   child: Row(
                //     children: [
                //       Icon(Icons.info_outline, color: Colors.blue[600]),
                //       const SizedBox(width: 10),
                //       Expanded(
                //         child: Text(
                //           "Available Wallet Balance: ₹${controller.sellData.value.totalAmount}",
                //           style: GoogleFonts.lexend(
                //             color: Colors.blue[800],
                //             fontSize: 14,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A2A4D),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _buildRow(
                        "Gold Quantity",
                        "${grams.toStringAsFixed(4)} gm",
                      ),
                      _buildRow("Gold Value", "₹${amount.toStringAsFixed(2)}"),
                      _buildRow(
                        "GST (${controller.taxPercentage.value}%)",
                        "₹${gst.toStringAsFixed(2)}",
                      ),
                      _buildRow(
                        "Payment Gateway Charges",
                        "₹${gateway.toStringAsFixed(2)}",
                      ),
                      _buildRow(
                        "Other Charges",
                        "₹${delivery.toStringAsFixed(2)}",
                      ),
                      const Divider(color: Colors.white54),
                      _buildRow(
                        "Total payable",
                        "₹${total.toStringAsFixed(2)}",
                        isBold: true,
                      ),
                    ],
                  ),
                ),

              // Gold Rate Display Below Selling Summary
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Current Gold Rate",
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (controller.isLoadingRate.value)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    else if (controller.goldRate.value != null)
                      Text(
                        "₹${controller.goldRate.value!.priceGram24k.toStringAsFixed(2)}/gm",
                        style: GoogleFonts.lexend(
                          fontSize: 18,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    else
                      Text(
                        "₹0.00/gm",
                        style: GoogleFonts.lexend(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),

              // ✅ Additional Information Section (Wallet Details)
              if (hasSellData)
                // Container(
                //   width: double.infinity,
                //   padding: const EdgeInsets.all(16),
                //   margin: const EdgeInsets.only(top: 20),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(16),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.1),
                //         blurRadius: 10,
                //         spreadRadius: 2,
                //       ),
                //     ],
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         "Wallet Details",
                //         style: GoogleFonts.lexend(
                //           fontSize: 16,
                //           color: Colors.black87,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //       const SizedBox(height: 12),
                //       _buildInfoRow(
                //         "Available Balance",
                //         "₹${controller.sellData.value.totalAmount ?? "0.00"}",
                //         Icons.account_balance_wallet,
                //       ),
                //       if (controller.sellData.value.totalGrams != null)
                //         _buildInfoRow(
                //           "Gold in Grams",
                //           "${controller.sellData.value.totalGrams} gm",
                //           Icons.scale,
                //         ),
                //       if (controller.sellData.value.paymentDate != null)
                //         _buildInfoRow(
                //           "Last Transaction",
                //           controller.sellData.value.paymentDate!,
                //           Icons.calendar_today,
                //         ),
                //     ],
                //   ),
                // ),
                const Spacer(),
              GestureDetector(
                onTap: () {
                  // Wallet balance
                  double walletBalance =
                      double.tryParse(
                        controller.sellData.value.totalAmount ?? "0",
                      ) ??
                      0;

                  // Total payable amount
                  double payable = total;

                  // ❌ If wallet is less than payable
                  if (walletBalance < payable) {
                    Get.dialog(
                      AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: const Text("Insufficient Balance"),
                        content: Text(
                          "Your wallet balance is ₹${walletBalance.toStringAsFixed(2)} but payable amount is ₹${payable.toStringAsFixed(2)}",
                        ),
                      ),
                      barrierDismissible: true, // ✅ tap anywhere to close
                    );

                    // Auto close after 2 seconds
                    Future.delayed(const Duration(seconds: 2), () {
                      if (Get.isDialogOpen == true) {
                        Get.back();
                      }
                    });

                    return; // STOP here — do not proceed
                  }

                  // ✅ Wallet is enough → allow payment
                  _showConfirmationDialog(
                    context,
                    controller,
                    isRupees,
                    hasSellData ? displayValue : value,
                  );
                },

                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xFF09243D),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.payment, color: Colors.white, size: 22),
                            const SizedBox(width: 10),
                            Text(
                              "Proceed to Sell",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
    SellsummaryContoller controller,
    bool isRupees,
    String value,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.amber),
            const SizedBox(width: 10),
            const Text("Confirm Sell"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Are you sure you want to proceed with this sell?"),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.account_balance_wallet, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Amount: ₹$value",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close only dialog
              controller.proceedToPay(isRupees: isRupees, value: value);
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF09243D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check, size: 20),
                const SizedBox(width: 6),
                const Text("Confirm", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.lexend(
              color: Colors.white,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.lexend(
              color: Colors.amber,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // ✅ New method for wallet info rows
  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.lexend(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: GoogleFonts.lexend(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
