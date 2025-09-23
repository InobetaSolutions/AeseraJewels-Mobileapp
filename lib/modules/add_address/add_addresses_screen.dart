
// import 'package:aesera_jewels/modules/add_address/add_addresses_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AddAddressScreen extends GetView<AddAddressController> {
//   AddAddressScreen({super.key});
//   final controller = Get.put(AddAddressController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F4FA),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text(
//           "Add Address",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               buildInputField(
//                 "Name",
//                 controller.nameController,
//                 "Enter your name",
//                 inputFormatters: [
//                   LengthLimitingTextInputFormatter(35),
//                   FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s]")),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               buildInputField(
//                 "Address",
//                 controller.addressController,
//                 "Enter your address",
//                 inputFormatters: [LengthLimitingTextInputFormatter(100)],
//               ),
//               const SizedBox(height: 16),

//               buildInputField(
//                 "City",
//                 controller.cityController,
//                 "Enter your city",
//                 inputFormatters: [
//                   LengthLimitingTextInputFormatter(35),
//                   FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s]")),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               buildInputField(
//                 "Postal Code",
//                 controller.postalCodeController,
//                 "Enter your postal code",
//                 type: TextInputType.number,
//                 inputFormatters: [
//                   LengthLimitingTextInputFormatter(6),
//                   FilteringTextInputFormatter.digitsOnly,
//                 ],
//               ),
//               const SizedBox(height: 24),

//               SizedBox(
//                 width: double.infinity,
//                 height: 48,
//                 child: ElevatedButton(
//                   onPressed: controller.addAddress,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF09243D),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   child: const Text(
//                     "Submit",
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   Widget buildInputField(
//     String label,
//     TextEditingController controller,
//     String hint, {
//     TextInputType type = TextInputType.text,
//     List<TextInputFormatter>? inputFormatters,
//     bool readOnly = false,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.plusJakartaSans(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: const Color(0xFF0D0F1C),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             color: const Color(0xFFF6FDFF),
//             borderRadius: BorderRadius.circular(8),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 4,
//                 offset: Offset(0, 3),
//                 spreadRadius: 0.02,
//               ),
//             ],
//           ),
//           child: TextField(
//             controller: controller,
//             keyboardType: type,
//             inputFormatters: inputFormatters,
//             readOnly: readOnly,
//             decoration: InputDecoration(
//               hintText: hint,
//               hintStyle: GoogleFonts.plusJakartaSans(
//                 fontSize: 14,
//                 color: const Color(0xFF2596BE),
//               ),
//               border: InputBorder.none,
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 16,
//               ),
//               counterText: "",
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:aesera_jewels/modules/add_address/add_addresses_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAddressScreen extends GetView<AddAddressController> {
  AddAddressScreen({super.key});
  final controller = Get.put(AddAddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Add Address",
          style: GoogleFonts.lexend(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildInputField(
                "Name",
                controller.nameController,
                "Enter your name",
                inputFormatters: [
                  LengthLimitingTextInputFormatter(35),
                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s]")),
                ],
              ),
              const SizedBox(height: 16),
              buildInputField(
                "Address",
                controller.addressController,
                "Enter your address",
                inputFormatters: [LengthLimitingTextInputFormatter(100)],
              ),
              const SizedBox(height: 16),
              buildInputField(
                "City",
                controller.cityController,
                "Enter your city",
                inputFormatters: [
                  LengthLimitingTextInputFormatter(35),
                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s]")),
                ],
              ),
              const SizedBox(height: 16),
              buildInputField(
                "Postal Code",
                controller.postalCodeController,
                "Enter your postal code",
                type: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: controller.addAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF09243D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.lexend(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildInputField(
    String label,
    TextEditingController controller,
    String hint, {
    TextInputType type = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0D0F1C),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF6FDFF),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 3),
                spreadRadius: 0.02,
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: type,
            inputFormatters: inputFormatters,
            readOnly: readOnly,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF2596BE),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              counterText: "",
            ),
          ),
        ),
      ],
    );
  }
}
