// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'buy_gold_controller.dart';
// import '../../routes/app_routes.dart';

// class BuyGoldScreen extends GetView<BuyGoldController> {
//   const BuyGoldScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Buy Gold"),
//         centerTitle: true,
//         leading: BackButton(onPressed: () => Get.back()),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// Toggle Buttons (Rupees / Grams)
//             Obx(
//               () => Container(
//                width: MediaQuery.of(context).size.width*0.9,
//                 height:MediaQuery.of(context).size.height*0.07,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   color: const Color(0xFF0A2A4D), // Background color
//                 ),
//                 child: Row(
//                   children: [
//                     /// Rupees Button
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () => controller.toggleMode(true),
//                         child: Container(
//                           margin: const EdgeInsets.all(4),
//                           decoration: BoxDecoration(
//                             color: controller.isRupees.value
//                                 ? const Color(0xFFFFB700) // Yellow color
//                                 : Colors.transparent,
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           alignment: Alignment.center,
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           child: Text(
//                             "Rupees",
//                             style: TextStyle(
//                               color: controller.isRupees.value
//                                   ? Colors.black
//                                   : Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     /// Grams Button
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () => controller.toggleMode(false),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: controller.isRupees.value
//                                 ? Colors.transparent
//                                 : const Color(0xFFFFB700), // Yellow color
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           alignment: Alignment.center,
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           child: Text(
//                             "Grams",
//                             style: TextStyle(
//                               color: controller.isRupees.value
//                                   ? Colors.white
//                                   : Colors.black,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             /// Input Field for Amount or Grams
//             _buildInputField(
//                 controller: controller.mobileController,(
//               decoration: InputDecoration(
//                 labelText:
//                     controller.isRupees.value ? "Enter Amount (₹)" : "Enter Grams",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               keyboardType: TextInputType.number,
//               onChanged: (val) {
//                 controller.enteredAmount.value = double.tryParse(val) ?? 0;
//               },
//             ),

//             const SizedBox(height: 20),

//             const Text(
//               "Quick Select",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 12),

//             /// Quick Select Buttons
//             Obx(
//               () => Wrap(
//                 spacing: 12,
//                 runSpacing: 12,
//                 children:
//                     (controller.isRupees.value
//                             ? controller.rupeesOptions
//                             : controller.gramsOptions)
//                         .map((option) {
//                           bool isSelected =
//                               controller.selectedValue.value == option;
//                           return GestureDetector(
//                             onTap: () => controller.selectValue(option),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 8,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: isSelected
//                                     ? Colors.amber
//                                     : const Color(0xFFF1EEF6),
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               child: Text(
//                                 controller.isRupees.value
//                                     ? "₹$option"
//                                     : "$option gm",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           );
//                         })
//                         .toList(),
//               ),
//             ),

//             const Spacer(),

//             /// Proceed Button
//             ElevatedButton(
//               onPressed: () {
//                 Get.toNamed(AppRoutes.payment, arguments: {
//                   "amount": controller.enteredAmount.value,
//                   "source": "buy_gold"
//                 });
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF0A2A4D),
//                 shape: const StadiumBorder(),
//                 minimumSize: const Size(double.infinity, 48),
//               ),
//               child: const Text(
//                 "Proceed",
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'buy_gold_controller.dart';
import '../../routes/app_routes.dart';

class BuyGoldScreen extends GetView<BuyGoldController> {
  const BuyGoldScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            /// Toggle Buttons
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

            /// Input Field with shadow
            Obx(
              () => Card(
                elevation: 4,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: controller.isRupees.value
                        ? "₹200"
                        : "gm ${controller.selectedValue.value}",
                    hintStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                      fontWeight: FontWeight.w600,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF1FCFF),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  onChanged: (val) {
                    controller.enteredAmount.value = double.tryParse(val) ?? 0;
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Quick Select",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            /// Quick Select Chips
            Obx(
              () => Wrap(
                spacing: 12,
                runSpacing: 12,
                children: (controller.isRupees.value
                        ? controller.rupeesOptions
                        : controller.gramsOptions)
                    .map((option) {
                  bool isSelected = controller.selectedValue.value == option;
                  return GestureDetector(
                    onTap: () => controller.selectValue(option),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.amber
                            : const Color(0xFFF1EEF6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        controller.isRupees.value ? "₹$option" : "$option gm",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.black : Colors.grey[800],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const Spacer(),

            /// Proceed Button
            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.payment,
                    arguments: controller.getPaymentData());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A2A4D),
                shape: const StadiumBorder(),
                minimumSize: const Size(double.infinity, 50),
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

  /// Toggle button builder
  Widget _buildToggleButton(String text, bool isRupeesTab) {
    final controller = Get.find<BuyGoldController>();
    bool isSelected = controller.isRupees.value == isRupeesTab;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.toggleMode(isRupeesTab),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFFB700) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
