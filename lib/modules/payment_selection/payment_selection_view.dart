
import 'package:aesera_jewels/modules/investment_details/portfolio_controller.dart';
import 'package:aesera_jewels/modules/payment_selection/payment_selection_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends GetWidget<PaymentController> {
  final controller = Get.put(PaymentController());
  final investmentController = Get.put(InvestmentController());

  PaymentScreen({super.key, required String amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF9FD),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Payment",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Toggle Tabs
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF0C1D36),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    _tabButton("Own Number", 0),
                    _tabButton("Others Number", 1),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // Mobile Number Field (if "Others Number")
              if (controller.selectedTab.value == 1) ...[
                _label("Payment Mobile Number"),
                const SizedBox(height: 8),
                _inputField(
                  hint: "Enter Payment Mobile Number",
                  controller: controller.mobileController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
              ],

              // Amount Field
              _label("Amount Paid"),
              const SizedBox(height: 8),
              _inputField(
                hint: "Enter Paid Amount",
                controller: controller.amountController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              // Upload Button
              _label("Upload Screenshot (Optional)"),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: controller.pickImageSource,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.cloud_upload, color: Colors.blue),
                      SizedBox(width: 8),
                      Text("Upload", style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Optional display of selected file name
              Obx(() {
                if (controller.screenshot.value != null) {
                  return Text(
                    "Selected: ${controller.screenshot.value!.name}",
                    style: const TextStyle(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  );
                }
                return const SizedBox.shrink();
              }),

              const Spacer(),

              // Submit Button
              GestureDetector(
                onTap: controller.submitPayment,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C1D36),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Text(
                      "Payment Completed",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
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

  // Helper Widgets
  Widget _tabButton(String title, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.switchTab(index),
        child: Container(
          decoration: BoxDecoration(
            color: controller.selectedTab.value == index
                ? Colors.amber
                : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: controller.selectedTab.value == index
                    ? Colors.black
                    : Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _inputField({
    required String hint,
    required TextEditingController controller,
    required TextInputType keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
