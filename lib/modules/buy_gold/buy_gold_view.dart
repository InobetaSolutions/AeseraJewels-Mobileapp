
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'buy_gold_controller.dart';

class BuyGoldScreen extends GetView<BuyGoldController> {
  const BuyGoldScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buy Gold"),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Toggle Buttons (Rupees / Grams)
            Obx(
              () => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xFF0A2A4D), // Background color
                ),
                child: Row(
                  children: [
                    /// Rupees Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.toggleMode(true),
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.isRupees.value
                                ? const Color(0xFFFFB700) // Yellow color
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            "Rupees",
                            style: TextStyle(
                              color: controller.isRupees.value
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// Grams Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.toggleMode(false),
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.isRupees.value
                                ? Colors.transparent
                                : const Color(0xFFFFB700), // Yellow color
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            "Grams",
                            style: TextStyle(
                              color: controller.isRupees.value
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// Input Display (Amount or Grams)
            Obx(
              () => Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade400, blurRadius: 4),
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text(
                      controller.isRupees.value ? "₹" : "gm",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        controller.selectedValue.value,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    if (!controller.isRupees.value)
                      const Text(
                        "₹17.000",
                        style: TextStyle(fontSize: 20, color: Colors.teal),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "Quick Select",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            /// Quick Select Buttons
            Obx(
              () => Wrap(
                spacing: 12,
                runSpacing: 12,
                children: (controller.isRupees.value
                        ? controller.rupeesOptions
                        : controller.gramsOptions)
                    .map((option) {
                  bool isSelected =
                      controller.selectedValue.value == option;
                  return GestureDetector(
                    onTap: () => controller.selectValue(option),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.amber
                            : const Color(0xFFF1EEF6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        controller.isRupees.value
                            ? "₹$option"
                            : "$option gm",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const Spacer(),

            /// Proceed Button
            ElevatedButton(
              onPressed: () => controller.makePayment(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A2A4D),
                shape: const StadiumBorder(),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text("Proceed"),
            ),
          ],
        ),
      ),
    );
  }
}
