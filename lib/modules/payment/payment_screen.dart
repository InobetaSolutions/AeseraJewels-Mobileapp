import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'payment_controller.dart';

class Payment_Screen extends GetView<Payment_Controller> {
  Payment_Screen({super.key});

  final Payment_Controller controller = Get.put(Payment_Controller());

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController(
      text: controller.enteredAmount.value > 0
          ? controller.enteredAmount.value.toString()
          : controller.selectedValue.value,
    );

    final mobileController = TextEditingController();

    textController.addListener(() {
      final txt = textController.text.trim();
      final intVal = int.tryParse(txt) ?? 0;
      controller.updateEnteredAmount(intVal);
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Payment", style: TextStyle(color: Colors.black)),
        leading: BackButton(color: Colors.black, onPressed: () => Get.back()),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _buildToggleBar(
              //   controller.isOwnNumber.value,
              //   "Own Number",
              //   "Others Number",
              //   (own) => controller.toggleNumber(own),
              // ),
              const SizedBox(height: 20),
              _buildToggleBar(
                controller.isRupees.value,
                "Rupees",
                "Grams",
                (rupees) => controller.toggleMode(rupees),
              ),
              const SizedBox(height: 20),

              if (!controller.isOwnNumber.value)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Payment Mobile Number",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6FDFF),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 3),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      child: TextField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (v) => controller.enteredMobile.value = v,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          height: 24 / 16,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter Payment Mobile Number',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF2596BE),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),

              Text(controller.isRupees.value ? "Amount Paid" : "Weight (gm)"),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 2,
                ),
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
                  controller: textController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 8,
                        top: 10,
                      ),
                      child: Text(
                        controller.isRupees.value ? "₹" : "gm",
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    suffix: Padding(
                      padding: const EdgeInsets.only(right: 12, top: 10),
                      child: Text(
                        controller.getConversion(),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Quick Select",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                children:
                    (controller.isRupees.value
                            ? controller.rupeesOptions
                            : controller.gramsOptions)
                        .map((option) {
                          final isSelected =
                              controller.enteredAmount.value.toString() ==
                              option;
                          return GestureDetector(
                            onTap: () {
                              controller.selectValue(option);
                              textController.text = option;
                              textController.selection =
                                  TextSelection.collapsed(
                                    offset: option.length,
                                  );
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
              const Spacer(),
              ElevatedButton(
                onPressed: () => controller.createPayment(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A2A4D),
                  minimumSize: const Size(double.infinity, 50),
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  "Proceed Payment",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleBar(
    bool isFirstSelected,
    String first,
    String second,
    Function(bool) onTap,
  ) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF0A2A4D),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildToggleButton(first, isFirstSelected, () => onTap(true)),
          _buildToggleButton(second, !isFirstSelected, () => onTap(false)),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
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
              color: selected ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
