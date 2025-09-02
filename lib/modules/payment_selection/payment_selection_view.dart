
import 'package:aesera_jewels/modules/payment_selection/payment_selection_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final String source = args["source"] ?? "";
    final String amount = args["amount"]?.toString() ?? "0";

    controller.amountController.text = amount;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF9FD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Payment", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildTabs(),
                  const SizedBox(height: 20),

                  // 🔹 Mobile Number field if "Others Number" selected
                  if (controller.selectedTab.value == 1) ...[
                    _label("Payment Mobile Number"),
                    const SizedBox(height: 8),
                    _inputField(controller.mobileController,
                        "Enter Payment Mobile Number", TextInputType.phone),
                    const SizedBox(height: 20),
                  ],

                  _label("Amount Paid"),
                  const SizedBox(height: 8),
                  _inputField(controller.amountController, "Enter Paid Amount",
                      TextInputType.number),
                  const SizedBox(height: 20),

                  _label("Upload Screenshot (Optional)"),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: controller.pickImageSource,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6F7FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cloud_upload,
                                color: Colors.blue, size: 20),
                            SizedBox(width: 8),
                            Text(
                              "Upload",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Show selected file
                  Obx(() {
                    if (controller.screenshot.value != null) {
                      return Text(
                        "Selected: ${controller.screenshot.value!.name}",
                        style: const TextStyle(color: Colors.grey),
                      );
                    }
                    return const SizedBox.shrink();
                  }),

                  const Spacer(),

                  // 🔹 Submit button
                  GestureDetector(
                    onTap: () async {
                      await controller.submitPayment(sourceScreen: source);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0C1D36),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Center(
                        child: Text("Payment Completed",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Loader overlay
            if (controller.isLoading.value)
              Container(
                color: Colors.black45,
                child: const Center(
                    child: CircularProgressIndicator(color: Colors.white)),
              ),
          ],
        );
      }),
    );
  }

  Widget _buildTabs() {
    return Container(
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
    );
  }

  Widget _tabButton(String text, int index) {
    bool selected = controller.selectedTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.switchTab(index),
        child: Container(
          decoration: BoxDecoration(
            color: selected ? Colors.amber : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(text,
                style: TextStyle(
                    color: selected ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Align(
        alignment: Alignment.centerLeft,
        child: Text(text,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.black)),
      );

  Widget _inputField(
      TextEditingController controller, String hint, TextInputType type) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5FEFF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.teal),
          ),
        ),
      ),
    );
  }
}
