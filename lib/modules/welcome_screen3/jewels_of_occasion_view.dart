
import 'package:aesera_jewels/modules/welcome_screen3/jewels_for_occasion_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UPIPaymentScreen extends StatelessWidget {
  final UPIPaymentController controller = Get.put(UPIPaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Redirecting to UPI app"), leading: const BackButton()),
      body: Obx(() {
        switch (controller.status.value) {
          case UPIStatus.selectApp:
            return _buildAppSelection();
          case UPIStatus.waiting:
            return const Center(child: Text("Waiting for payment confirmation..."));
          case UPIStatus.success:
            return _buildSuccess();
          case UPIStatus.failed:
            return _buildFailed();
        }
      }),
    );
  }

  Widget _buildAppSelection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Please select any UPI app to pay"),
        const SizedBox(height: 20),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _appButton("Google Pay"),
            _appButton("PhonePe"),
            _appButton("Paytm"),
          ],
        ),
      ],
    );
  }

  Widget _appButton(String app) {
    return GestureDetector(
      onTap: () => controller.selectApp(app),
      child: Container(
        width: 120,
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
        child: Text(app),
      ),
    );
  }

  Widget _buildSuccess() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Payment Successful!", style: TextStyle(color: Colors.green, fontSize: 20)),
          const SizedBox(height: 10),
          const Text("Amount Paid: ₹2500"),
          const Text("Weight: 10.5 gm"),
          const Text("Transaction ID: 1234567890"),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () => Get.back(), child: const Text("Back to Home")),
        ],
      ),
    );
  }

  Widget _buildFailed() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Payment Failed", style: TextStyle(color: Colors.red, fontSize: 20)),
          const Text("Please try again."),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () => controller.status.value = UPIStatus.selectApp, child: const Text("Retry")),
        ],
      ),
    );
  }
}
