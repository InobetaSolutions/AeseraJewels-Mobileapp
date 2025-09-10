// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'payment_controller.dart';

// // class Payment_Screen extends GetView<Payment_Controller> {
// //   Payment_Screen({super.key});

// //   final Payment_Controller controller = Get.put(Payment_Controller());

// //   @override
// //   Widget build(BuildContext context) {
// //     final textController = TextEditingController(
// //       text: controller.enteredAmount.value > 0
// //           ? controller.enteredAmount.value.toString()
// //           : controller.selectedValue.value,
// //     );

// //     final mobileController = TextEditingController();

// //     textController.addListener(() {
// //       final txt = textController.text.trim();
// //       final intVal = int.tryParse(txt) ?? 0;
// //       controller.updateEnteredAmount(intVal);
// //     });

// //     return Scaffold(
// //       backgroundColor: const Color(0xFFFAF8FC),
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //         centerTitle: true,
// //         title: const Text("Payment", style: TextStyle(color: Colors.black)),
// //         leading: BackButton(color: Colors.black, onPressed: () => Get.back()),
// //       ),
// //       body: Obx(
// //         () => Padding(
// //           padding: const EdgeInsets.all(20),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               // _buildToggleBar(
// //               //   controller.isOwnNumber.value,
// //               //   "Own Number",
// //               //   "Others Number",
// //               //   (own) => controller.toggleNumber(own),
// //               // ),
// //               const SizedBox(height: 20),
// //               _buildToggleBar(
// //                 controller.isRupees.value,
// //                 "Rupees",
// //                 "Grams",
// //                 (rupees) => controller.toggleMode(rupees),
// //               ),
// //               const SizedBox(height: 20),

// //               if (!controller.isOwnNumber.value)
// //                 Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     const Text(
// //                       "Payment Mobile Number",
// //                       style: TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 6),
// //                     Container(
// //                       width: double.infinity,
// //                       height: 56,
// //                       decoration: BoxDecoration(
// //                         color: const Color(0xFFF6FDFF),
// //                         borderRadius: BorderRadius.circular(8),
// //                         boxShadow: [
// //                           BoxShadow(
// //                             color: Colors.black.withOpacity(0.25),
// //                             offset: const Offset(0, 3),
// //                             blurRadius: 4,
// //                           ),
// //                         ],
// //                       ),
// //                       padding: const EdgeInsets.symmetric(horizontal: 16),
// //                       alignment: Alignment.center,
// //                       child: TextField(
// //                         controller: mobileController,
// //                         keyboardType: TextInputType.phone,
// //                         inputFormatters: [
// //                           FilteringTextInputFormatter.digitsOnly,
// //                         ],
// //                         onChanged: (v) => controller.enteredMobile.value = v,
// //                         style: GoogleFonts.plusJakartaSans(
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.w400,
// //                           fontStyle: FontStyle.normal,
// //                           height: 24 / 16,
// //                         ),
// //                         decoration: InputDecoration(
// //                           hintText: 'Enter Payment Mobile Number',
// //                           hintStyle: GoogleFonts.plusJakartaSans(
// //                             color: const Color(0xFF2596BE),
// //                             fontSize: 15,
// //                             fontWeight: FontWeight.w400,
// //                           ),
// //                           border: InputBorder.none,
// //                           contentPadding: EdgeInsets.zero,
// //                         ),
// //                       ),
// //                     ),
// //                     const SizedBox(height: 20),
// //                   ],
// //                 ),

// //               Text(controller.isRupees.value ? "Amount Paid" : "Weight (gm)"),
// //               const SizedBox(height: 6),
// //               Container(
// //                 padding: const EdgeInsets.symmetric(
// //                   horizontal: 12,
// //                   vertical: 2,
// //                 ),
// //                 decoration: BoxDecoration(
// //                   color: Colors.blue.shade50,
// //                   borderRadius: BorderRadius.circular(12),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       offset: const Offset(0, 3),
// //                       blurRadius: 4,
// //                       color: Colors.black.withOpacity(0.2),
// //                     ),
// //                   ],
// //                 ),
// //                 child: TextField(
// //                   controller: textController,
// //                   keyboardType: TextInputType.number,
// //                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
// //                   style: const TextStyle(
// //                     fontSize: 25,
// //                     fontWeight: FontWeight.w600,
// //                     color: Colors.teal,
// //                   ),
// //                   decoration: InputDecoration(
// //                     border: InputBorder.none,
// //                     prefixIcon: Padding(
// //                       padding: const EdgeInsets.only(
// //                         left: 10,
// //                         right: 8,
// //                         top: 10,
// //                       ),
// //                       child: Text(
// //                         controller.isRupees.value ? "₹" : "gm",
// //                         style: const TextStyle(
// //                           fontSize: 25,
// //                           fontWeight: FontWeight.w600,
// //                           color: Colors.teal,
// //                         ),
// //                       ),
// //                     ),
// //                     suffix: Padding(
// //                       padding: const EdgeInsets.only(right: 12, top: 10),
// //                       child: Text(
// //                         controller.getConversion(),
// //                         style: const TextStyle(
// //                           fontSize: 25,
// //                           fontWeight: FontWeight.w600,
// //                           color: Colors.teal,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),
// //               const Text(
// //                 "Quick Select",
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //               ),
// //               const SizedBox(height: 12),
// //               Wrap(
// //                 spacing: 12,
// //                 children:
// //                     (controller.isRupees.value
// //                             ? controller.rupeesOptions
// //                             : controller.gramsOptions)
// //                         .map((option) {
// //                           final isSelected =
// //                               controller.enteredAmount.value.toString() ==
// //                               option;
// //                           return GestureDetector(
// //                             onTap: () {
// //                               controller.selectValue(option);
// //                               textController.text = option;
// //                               textController.selection =
// //                                   TextSelection.collapsed(
// //                                     offset: option.length,
// //                                   );
// //                             },
// //                             child: Container(
// //                               padding: const EdgeInsets.symmetric(
// //                                 horizontal: 16,
// //                                 vertical: 8,
// //                               ),
// //                               decoration: BoxDecoration(
// //                                 color: isSelected
// //                                     ? Colors.amber
// //                                     : Colors.grey[200],
// //                                 borderRadius: BorderRadius.circular(30),
// //                               ),
// //                               child: Text(
// //                                 controller.isRupees.value
// //                                     ? "₹$option"
// //                                     : "$option gm",
// //                                 style: TextStyle(
// //                                   fontWeight: isSelected
// //                                       ? FontWeight.bold
// //                                       : FontWeight.normal,
// //                                 ),
// //                               ),
// //                             ),
// //                           );
// //                         })
// //                         .toList(),
// //               ),
// //               const Spacer(),
// //               GestureDetector(
// //                 onTap: () {
// //                   Get.defaultDialog(
// //                     title: "Confirmation",
// //                     middleText: "Hope you proceed payment",
// //                     barrierDismissible: false,
// //                     textCancel: "Cancel",
// //                     textConfirm: "OK",
// //                     cancelTextColor: Colors.red,
// //                     confirmTextColor: Colors.white,
// //                     buttonColor: const Color(0xFF0A2A4D),

// //                     onConfirm: () async {
// //                       Get.back(); // close dialog
// //                       await controller.createPayment(); // call API
// //                     },
// //                   );
// //                 },
// //                 child: Container(
// //                   width: double.infinity,
// //                   height: 50,
// //                   decoration: const BoxDecoration(
// //                     color: Color(0xFF0A2A4D),
// //                     borderRadius: BorderRadius.all(
// //                       Radius.circular(30),
// //                     ), // Stadium shape
// //                   ),
// //                   alignment: Alignment.center,
// //                   child: const Text(
// //                     "Proceed Payment",
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.w500,
// //                     ),
// //                   ),
// //                 ),
// //               ),

// //               // ElevatedButton(
// //               //   onPressed: () => controller.createPayment(),
// //               //   style: ElevatedButton.styleFrom(
// //               //     backgroundColor: const Color(0xFF0A2A4D),
// //               //     minimumSize: const Size(double.infinity, 50),
// //               //     shape: const StadiumBorder(),
// //               //   ),
// //               //   child: const Text(
// //               //     "Proceed Payment",
// //               //     style: TextStyle(color: Colors.white, fontSize: 18),
// //               //   ),
// //               // ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildToggleBar(
// //     bool isFirstSelected,
// //     String first,
// //     String second,
// //     Function(bool) onTap,
// //   ) {
// //     return Container(
// //       height: 50,
// //       decoration: BoxDecoration(
// //         color: const Color(0xFF0A2A4D),
// //         borderRadius: BorderRadius.circular(30),
// //       ),
// //       child: Row(
// //         children: [
// //           _buildToggleButton(first, isFirstSelected, () => onTap(true)),
// //           _buildToggleButton(second, !isFirstSelected, () => onTap(false)),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildToggleButton(String text, bool selected, VoidCallback onTap) {
// //     return Expanded(
// //       child: GestureDetector(
// //         onTap: onTap,
// //         child: Container(
// //           margin: const EdgeInsets.all(4),
// //           decoration: BoxDecoration(
// //             color: selected ? Colors.amber : Colors.transparent,
// //             borderRadius: BorderRadius.circular(30),
// //           ),
// //           alignment: Alignment.center,
// //           child: Text(
// //             text,
// //             style: TextStyle(
// //               fontSize: 20,
// //               color: selected ? Colors.black : Colors.white,
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
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
//                           final isSelected =
//                               controller.enteredAmount.value.toString() ==
//                                   option;
//                           return GestureDetector(
//                             onTap: () {
//                               controller.selectValue(option);
//                               textController.text = option;
//                               textController.selection =
//                                   TextSelection.collapsed(
//                                 offset: option.length,
//                               );
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 8,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: isSelected
//                                     ? Colors.amber
//                                     : Colors.grey[200],
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               child: Text(
//                                 controller.isRupees.value
//                                     ? "₹$option"
//                                     : "$option gm",
//                                 style: TextStyle(
//                                   fontWeight: isSelected
//                                       ? FontWeight.bold
//                                       : FontWeight.normal,
//                                 ),
//                               ),
//                             ),
//                           );
//                         })
//                         .toList(),
//               ),
//               const SizedBox(height: 20),
                          
                             
//                              Align(
//                     alignment: Alignment.center,
//                     child: Container(
//                       width: 310,
//                       decoration: BoxDecoration(
//                         color: const Color(
//                           0xFF09243D,
//                         ), // Same dark blue as other cards
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: const EdgeInsets.all(16),
//                       child:
                        
                        
//                             Text(
//                               "Pay to below Number: 9952168352",
//                               textAlign:TextAlign.start,
//                               style: GoogleFonts.lexend(
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 18,
//                                 color: const Color(0xFFFFB700),
//                               ),
//                             ),
                            
//                     ),
//                   ),
//               const Spacer(),
//               GestureDetector(
//                 onTap: () {
//                   final entered = textController.text.trim();

//                   // ✅ Validation 1: Empty or starts with 0
//                   if (entered.isEmpty || entered.startsWith('0')) {
//                     Get.snackbar(
//                       "Invalid Amount",
//                       "Amount should not start with 0",
//                       backgroundColor: Colors.red.shade100,
//                       colorText: Colors.black,
//                     );
//                     return;
//                   }

//                   // ✅ Validation 2: Below 100
//                   final value = int.tryParse(entered) ?? 0;
//                   if (value < 100) {
//                     Get.snackbar(
//                       "Invalid Amount",
//                       "Please enter amount above 100",
//                       backgroundColor: Colors.red.shade100,
//                       colorText: Colors.black,
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
//                     cancelTextColor: Colors.white,
//                     confirmTextColor: Colors.white,
//                     buttonColor: const Color(0xFF0A2A4D),
//                     onCancel: () {
//                       if (Get.isDialogOpen == true) Get.back();
//                     },
//                     onConfirm: () async {
//                       if (Get.isDialogOpen == true) Get.back();
//                       await controller.createPayment(); // call API
//                     },
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

/// ✅ Strict Input Formatter for Amount
class AmountInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    // allow empty (so user can clear input)
    if (text.isEmpty) return newValue;

    // only digits
    if (!RegExp(r'^[0-9]+$').hasMatch(text)) {
      return oldValue;
    }

    // prevent starting with 0
    if (text.startsWith('0')) {
      return oldValue;
    }

    // limit to 10 digits
    if (text.length > 10) {
      return oldValue;
    }

    // disallow values below 100
    int? value = int.tryParse(text);
    if (value != null && value < 100) {
      return oldValue;
    }

    return newValue;
  }
}

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
                    AmountInputFormatter(), // ✅ strict rules here
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
              const SizedBox(height: 60),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 310,
                  decoration: BoxDecoration(
                    color: const Color(0xFF09243D),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Pay to below Number: 9952168352",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.lexend(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: const Color(0xFFFFB700),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                    title: "Confirmation",
                    middleText: "Hope you proceed payment",
                    barrierDismissible: false,
                    textCancel: "Cancel",
                    textConfirm: "OK",
                    cancelTextColor: Colors.white,
                    confirmTextColor: Colors.white,
                    buttonColor: const Color(0xFF0A2A4D),
                    onCancel: () {
                      if (Get.isDialogOpen == true) Get.back();
                    },
                    onConfirm: () async {
                      if (Get.isDialogOpen == true) Get.back();
                      await controller.createPayment(); // call API
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
