import 'package:aesera_jewels/modules/sell_summary/sellsumarry_screen.dart';
import 'package:aesera_jewels/modules/sells_coin/sellcoin_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SellcoinScreen extends StatelessWidget {
  SellcoinScreen({super.key});

  final SellcoinController controller = Get.put(SellcoinController());

  final TextEditingController amountController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Sell Coin", style: TextStyle(color: Colors.black)),
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            /// 🔹 Toggle Bar
            _buildToggleBar(),

            const SizedBox(height: 25),
            const SizedBox(height: 6),
            const SizedBox(height: 20),

            /// 🔹 Amount Field
            const Text("Sell the Coin", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 6),
            _buildAmountField(),

            const SizedBox(height: 25),

            /// 🔹 Quick Select
            const Text(
              "Quick Select",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildQuickSelect(),

            const SizedBox(height: 30),
            const Spacer(),

            /// 🔹 Next Button
            _buildNextButton(context),
          ],
        ),
      ),
    );
  }

  // ================= TOGGLE BAR =================

  Widget _buildToggleBar() {
    return Obx(() {
      return Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF0A2A4D),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            _toggleButton("Rupees", controller.isRupeesSelected.value, true),
            _toggleButton("Grams", !controller.isRupeesSelected.value, false),
          ],
        ),
      );
    });
  }

  Widget _toggleButton(String text, bool selected, bool isRupees) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.toggle(isRupees);
          amountController.clear();
          controller.selectedQuick.value = '';
        },
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: selected ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
  // ================= AMOUNT FIELD =================

  Widget _buildAmountField() {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 4,
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
        child: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          onChanged: (_) {
            controller.selectedQuick.value = '';
          },
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.teal,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 15, top: 5),
              child: Text(
                controller.isRupeesSelected.value ? "₹" : "gm",
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  // Widget _buildAmountField() {
  //   return Obx(() {
  //     // amountController.text = controller.displayValue;

  //     return Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  //       decoration: BoxDecoration(
  //         color: Colors.blue.shade50,
  //         borderRadius: BorderRadius.circular(12),
  //         boxShadow: [
  //           BoxShadow(
  //             offset: const Offset(0, 3),
  //             blurRadius: 4,
  //             color: Colors.black.withOpacity(0.2),
  //           ),
  //         ],
  //       ),
  //       child: TextField(
  //         controller: amountController,
  //         keyboardType: TextInputType.number,
  //         style: const TextStyle(
  //           fontSize: 25,
  //           fontWeight: FontWeight.w600,
  //           color: Colors.teal,
  //         ),
  //         decoration: InputDecoration(
  //           border: InputBorder.none,
  //           prefixIcon: Padding(
  //             padding: const EdgeInsets.only(left: 15, top: 5),
  //             child: Text(
  //               controller.isRupeesSelected.value
  //                   ? "₹"
  //                   : "gm", // Show ₹ for rupees, gm for grams
  //               style: const TextStyle(
  //                 fontSize: 25,
  //                 fontWeight: FontWeight.w600,
  //                 color: Colors.teal,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   });
  // }

  // ================= QUICK SELECT =================

  Widget _buildQuickSelect() {
    return Obx(() {
      // Define quick select options based on whether rupees or grams is selected
      final options = controller.isRupeesSelected.value
          ? ["500", "1000", "2000", "5000"] // Rupee values
          : ["0.1", "0.5", "1", "5"]; // Gram values

      return Wrap(
        spacing: 12,
        children: options.map((e) {
          return GestureDetector(
            onTap: () {
              amountController.text = e;
              controller.selectQuick(e);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: controller.selectedQuick.value == e
                    ? Colors.amber
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                controller.isRupeesSelected.value ? "₹$e" : "${e}gm",
                style: TextStyle(
                  color: controller.selectedQuick.value == e
                      ? Colors.black
                      : Colors.black87,
                ),
              ),
            ),
          );
        }).toList(),
      );
    });
  }

  // ================= NEXT BUTTON =================

  Widget _buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => const SellsummaryScreen(),
          arguments: {
            "value": amountController.text,
            "isRupees": controller.isRupeesSelected.value,
          },
        );
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: const BoxDecoration(
          color: Color(0xFF0A2A4D),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        alignment: Alignment.center,
        child: const Text(
          "Next",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
