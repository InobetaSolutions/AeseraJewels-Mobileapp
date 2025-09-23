
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'payment_controller.dart';

// class Payment_Screen extends GetView<Payment_Controller> {
//   Payment_Screen({super.key});

//   final Payment_Controller controller = Get.put(Payment_Controller());

//   @override
//   Widget build(BuildContext context) {
//     final textController = TextEditingController(
//       text: controller.enteredAmount.value > 0
//           ? controller.enteredAmount.value.toString()
//           : controller.selectedValue.value,
//     );

//     final mobileController = TextEditingController();

//     textController.addListener(() {
//       final txt = textController.text.trim();
//       final intVal = int.tryParse(txt) ?? 0;
//       controller.updateEnteredAmount(intVal);
//     });

//     return Scaffold(
//       backgroundColor: const Color(0xFFFAF8FC),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text("Payment", style: TextStyle(color: Colors.black)),
//         leading: BackButton(color: Colors.black, onPressed: () => Get.back()),
//       ),
//       body: Obx(
//         () => Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               _buildToggleBar(
//                 controller.isRupees.value,
//                 "Rupees",
//                 "Grams",
//                 (rupees) => controller.toggleMode(rupees),
//               ),
//               const SizedBox(height: 20),

//               if (!controller.isOwnNumber.value)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Payment Mobile Number",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Container(
//                       width: double.infinity,
//                       height: 56,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF6FDFF),
//                         borderRadius: BorderRadius.circular(8),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.25),
//                             offset: const Offset(0, 3),
//                             blurRadius: 4,
//                           ),
//                         ],
//                       ),
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       alignment: Alignment.center,
//                       child: TextField(
//                         controller: mobileController,
//                         keyboardType: TextInputType.phone,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                         ],
//                         onChanged: (v) => controller.enteredMobile.value = v,
//                         style: GoogleFonts.plusJakartaSans(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                           fontStyle: FontStyle.normal,
//                           height: 24 / 16,
//                         ),
//                         decoration: InputDecoration(
//                           hintText: 'Enter Payment Mobile Number',
//                           hintStyle: GoogleFonts.plusJakartaSans(
//                             color: const Color(0xFF2596BE),
//                             fontSize: 15,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           border: InputBorder.none,
//                           contentPadding: EdgeInsets.zero,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),

//               Text(controller.isRupees.value ? "Amount Paid" : "Weight (gm)"),
//               const SizedBox(height: 6),
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 2,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.shade50,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       offset: const Offset(0, 3),
//                       blurRadius: 4,
//                       color: Colors.black.withOpacity(0.2),
//                     ),
//                   ],
//                 ),
//                 child: TextField(
//                   controller: textController,
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     LengthLimitingTextInputFormatter(10), // ✅ max 10 digits
//                   ],
//                   style: const TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.teal,
//                   ),
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     prefixIcon: Padding(
//                       padding: const EdgeInsets.only(
//                         left: 10,
//                         right: 8,
//                         top: 10,
//                       ),
//                       child: Text(
//                         controller.isRupees.value ? "₹" : "gm",
//                         style: const TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.teal,
//                         ),
//                       ),
//                     ),
//                     suffix: Padding(
//                       padding: const EdgeInsets.only(right: 12, top: 10),
//                       child: Text(
//                         controller.getConversion(),
//                         style: const TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.teal,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 "Quick Select",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 12),
//               Wrap(
//                 spacing: 12,
//                 children:
//                     (controller.isRupees.value
//                             ? controller.rupeesOptions
//                             : controller.gramsOptions)
//                         .map((option) {
//                   final isSelected =
//                       controller.enteredAmount.value.toString() == option;
//                   return GestureDetector(
//                     onTap: () {
//                       controller.selectValue(option);
//                       textController.text = option;
//                       textController.selection =
//                           TextSelection.collapsed(offset: option.length);
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 8,
//                       ),
//                       decoration: BoxDecoration(
//                         color:
//                             isSelected ? Colors.amber : Colors.grey[200],
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Text(
//                         controller.isRupees.value
//                             ? "₹$option"
//                             : "$option gm",
//                         style: TextStyle(
//                           fontWeight: isSelected
//                               ? FontWeight.bold
//                               : FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 20),

//               /// ✅ Phone number container with copy option
//               Align(
//                 alignment: Alignment.center,
//                 child: Container(
//                   width: 310,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF09243D), // Same dark blue
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: const EdgeInsets.all(16),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           "Pay to below Number: 9952168352",
//                           style: GoogleFonts.lexend(
//                             fontWeight: FontWeight.w700,
//                             fontSize: 18,
//                             color: const Color(0xFFFFB700),
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.copy,
//                             color: Colors.white, size: 22),
//                         onPressed: () {
//                           Clipboard.setData(
//                               const ClipboardData(text: "9952168352"));
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text("Phone number copied!"),
//                               duration: Duration(seconds: 2),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const Spacer(),
//               GestureDetector(
//                 onTap: () {
//                   final entered = textController.text.trim();

//                   // ✅ Validation 1: Empty or starts with 0
//                   if (entered.isEmpty || entered.startsWith('0')) {
//                     Get.snackbar(
//                       "Invalid Amount",
//                       "Amount should not start with 0",
//                       backgroundColor: const Color(0xFF0A2A4D),
//                       colorText: Colors.white,
//                     );
//                     return;
//                   }

//                   // ✅ Validation 2: Below 100
//                   final value = int.tryParse(entered) ?? 0;
//                   if (value < 100) {
//                     Get.snackbar(
//                       "Invalid Amount",
//                       "Please enter amount above 100",
//                       backgroundColor: const Color(0xFF0A2342),
//                       colorText: Colors.white,
//                     );
//                     return;
//                   }

//                   // ✅ If valid -> show confirmation
//                   Get.defaultDialog(
//                     title: "Confirmation",
//                     middleText: "Hope you proceed payment",
//                     barrierDismissible: false,
//                     textCancel: "Cancel",
//                     textConfirm: "OK",
//                     cancelTextColor: Colors.black,
//                     confirmTextColor: Colors.white,
//                     buttonColor: const Color(0xFF0A2A4D),
//                    onCancel: () {
//   // ❌ No navigation, only close dialog
//   if (Get.isDialogOpen == true) Get.back();
// },
// onConfirm: () async {
//   // ✅ Close dialog first
//   if (Get.isDialogOpen == true) Get.back();

//   // ✅ Call API
//   await controller.createPayment();

//   Get.offAllNamed("/dashboard");
// },

//                   );
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 50,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFF0A2A4D),
//                     borderRadius: BorderRadius.all(Radius.circular(30)),
//                   ),
//                   alignment: Alignment.center,
//                   child: const Text(
//                     "Proceed Payment",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildToggleBar(
//     bool isFirstSelected,
//     String first,
//     String second,
//     Function(bool) onTap,
//   ) {
//     return Container(
//       height: 50,
//       decoration: BoxDecoration(
//         color: const Color(0xFF0A2A4D),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Row(
//         children: [
//           _buildToggleButton(first, isFirstSelected, () => onTap(true)),
//           _buildToggleButton(second, !isFirstSelected, () => onTap(false)),
//         ],
//       ),
//     );
//   }

//   Widget _buildToggleButton(String text, bool selected, VoidCallback onTap) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           margin: const EdgeInsets.all(4),
//           decoration: BoxDecoration(
//             color: selected ? Colors.amber : Colors.transparent,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           alignment: Alignment.center,
//           child: Text(
//             text,
//             style: TextStyle(
//               fontSize: 20,
//               color: selected ? Colors.black : Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
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
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
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
                      controller.enteredAmount.value.toString() == option;
                  return GestureDetector(
                    onTap: () {
                      controller.selectValue(option);
                      textController.text = option;
                      textController.selection =
                          TextSelection.collapsed(offset: option.length);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.amber : Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        controller.isRupees.value
                            ? "₹$option"
                            : "$option gm",
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 310,
                  decoration: BoxDecoration(
                    color: const Color(0xFF09243D),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Pay to below Number: 9952168352",
                          style: GoogleFonts.lexend(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: const Color(0xFFFFB700),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy,
                            color: Colors.white, size: 22),
                        onPressed: () {
                          Clipboard.setData(
                              const ClipboardData(text: "9952168352"));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Phone number copied!"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),
              GestureDetector(
                onTap: () {
                  final entered = textController.text.trim();

                  // ✅ Common validation: not empty or starting with 0
                  if (entered.isEmpty || entered.startsWith('0')) {
                    Get.snackbar(
                      "Invalid Amount",
                      "Amount should not start with 0",
                      backgroundColor: const Color(0xFF0A2A4D),
                      colorText: Colors.white,
                    );
                    return;
                  }

                //   // ✅ Only for Rupees: check minimum 100
                //   if (controller.isRupees.value) {
                //     final value = int.tryParse(entered) ?? 0;
                //     if (value < 100) {
                //       Get.snackbar(
                //         "Invalid Amount",
                //         "Please enter amount above 100",
                //         backgroundColor: const Color(0xFF0A2342),
                //         colorText: Colors.white,
                //       );
                //       return;
                //     }
                //   }

                //   // ✅ Confirmation dialog
                //   Get.defaultDialog(
                //     title: "Confirmation",
                //     middleText: "Hope you proceed payment",
                //     barrierDismissible: false,
                //     textCancel: "Cancel",
                //     textConfirm: "OK",
                //     cancelTextColor: Colors.black,
                //     confirmTextColor: Colors.white,
                //     buttonColor: const Color(0xFF0A2A4D),
                //     onCancel: () {
                //       if (Get.isDialogOpen == true) Get.back();
                //     },
                //     onConfirm: () async {
                //       if (Get.isDialogOpen == true) Get.back();
                //       await controller.createPayment();
                //       Get.offAllNamed("/dashboard");
                //     },
                //   );
                // },
                // ✅ Only for Rupees: check minimum 100
if (controller.isRupees.value) {
  final value = int.tryParse(entered) ?? 0;
  if (value < 100) {
    Get.snackbar(
      "Invalid Amount",
      "Please enter amount above 100",
      backgroundColor: const Color(0xFF0A2342),
      colorText: Colors.white,
    );
    return;
  }
}

// ✅ Confirmation dialog
Get.defaultDialog(
  backgroundColor: Colors.white, // popup background
  title: "Confirmation",
  middleText: "Hope you proceed payment",
  barrierDismissible: false,
  titleStyle: const TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
  middleTextStyle: const TextStyle(color: Colors.black87,fontSize: 16),
  actions: [
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFB700), // amber cancel button
      ),
      onPressed: () {
        if (Get.isDialogOpen == true) Get.back();
      },
      child: const Text(
        "Cancel",
        style: TextStyle(color: Colors.black,fontSize: 15),
      ),
    ),
    const SizedBox(width: 10),
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0A2A4D), // blue confirm button
      ),
      onPressed: () async {
        if (Get.isDialogOpen == true) Get.back();
        await controller.createPayment();
        Get.offAllNamed("/dashboard");
      },
      child: const Text(
        "OK",
        style: TextStyle(color: Colors.white,fontSize:  15),
      ),
    ),
  ],
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
                    "Proceed Payment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
