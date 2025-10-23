
import 'package:aesera_jewels/modules/welcome_screen3/jewels_of_occasion_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'payment_selection_controller.dart';
import 'package:aesera_jewels/modules/scan_to_pay/scan_to_pay_view.dart';
class PaymentSelectionScreen extends StatelessWidget {
  final PaymentSelectionController controller = Get.put(PaymentSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Selection"), leading: const BackButton()),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              /// Own / Others toggle
              Row(
                children: [
                  _toggleButton("Own Number", controller.isOwnNumber.value, () {
                    controller.isOwnNumber.value = true;
                  }),
                  const SizedBox(width: 12),
                  _toggleButton("Others Number", !controller.isOwnNumber.value, () {
                    controller.isOwnNumber.value = false;
                  }),
                ],
              ),
              const SizedBox(height: 20),

              /// Rupees / Grams toggle
              Row(
                children: [
                  _toggleButton("Rupees", controller.isRupees.value, () {
                    controller.isRupees.value = true;
                  }),
                  const SizedBox(width: 12),
                  _toggleButton("Grams", !controller.isRupees.value, () {
                    controller.isRupees.value = false;
                  }),
                ],
              ),
              const SizedBox(height: 20),

              /// Display
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(controller.displayAmount,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(controller.displayGrams,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const Spacer(),

              ElevatedButton(
                onPressed: () => Get.to(() => ScanToPayScreen()),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.indigo.shade900,
                  shape: const StadiumBorder(),
                ),
                child: const Text("Show QR Code"),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Get.to(() => UPIPaymentScreen()),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.indigo.shade900,
                  shape: const StadiumBorder(),
                ),
                child: const Text("Pay with UPI"),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _toggleButton(String text, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Colors.amber : Colors.grey,
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
