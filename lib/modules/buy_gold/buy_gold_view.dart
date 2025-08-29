import 'package:aesera_jewels/modules/buy_gold/buy_gold_controller.dart';
import 'package:aesera_jewels/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class BuyGoldScreen extends   GetWidget<BuyGoldController> {
   BuyGoldScreen({super.key});
final BuyGoldController controller = Get.put(BuyGoldController());
  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final controller = Get.find<BuyGoldController>();

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Buy Gold", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: BackButton(color: Colors.black, onPressed: () => Get.back()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Toggle Rupees/Grams
            Obx(
              () => Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xFF0A2A4D),
                ),
                child: Row(
                  children: [
                    _buildToggleButton("Rupees", true),
                    _buildToggleButton("Grams", false),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// Input
            Obx(() {
              String displayValue = controller.enteredAmount.value > 0
                  ? controller.isRupees.value
                        ? "₹${controller.enteredAmount.value}"
                        : "${controller.enteredAmount.value} gm"
                  : controller.isRupees.value
                  ? "₹${controller.selectedValue.value}"
                  : "${controller.selectedValue.value} gm";

              textController.text = displayValue;

              return Card(
                elevation: 4,
                child: TextField(
                  controller: textController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Enter amount",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  onChanged: (val) {
                    controller.enteredAmount.value =
                        double.tryParse(
                          val.replaceAll("₹", "").replaceAll("gm", "").trim(),
                        ) ??
                        0;
                  },
                ),
              );
            }),
            const SizedBox(height: 20),

            const Text(
              "Quick Select",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            /// Quick Select
            Obx(
              () => Wrap(
                spacing: 12,
                children:
                    (controller.isRupees.value
                            ? controller.rupeesOptions
                            : controller.gramsOptions)
                        .map((option) {
                          bool isSelected =
                              controller.selectedValue.value == option;
                          return GestureDetector(
                            onTap: () {
                              controller.selectValue(option);
                              controller.enteredAmount.value = 0;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.amber
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                controller.isRupees.value
                                    ? "₹$option"
                                    : "$option gm",
                                style: TextStyle(
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        })
                        .toList(),
              ),
            ),

            const Spacer(),

            /// Proceed
            ElevatedButton(
              onPressed: () {
                Get.toNamed(
                  AppRoutes.payment,
                  arguments: {
                    "amount": controller.getPaymentData()["amount"],
                    "source": "buy_gold",
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A2A4D),
                minimumSize: const Size(double.infinity, 50),
                shape: const StadiumBorder(),
              ),
              child: const Text(
                "Proceed",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isRupeesTab) {
    final controller = Get.find<BuyGoldController>();
    bool selected = controller.isRupees.value == isRupeesTab;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.toggleMode(isRupeesTab),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: selected ? Colors.amber : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: selected ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
