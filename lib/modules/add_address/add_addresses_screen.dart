// import 'package:aesera_jewels/modules/add_address/add_addresses_controller.dart';
// import 'package:aesera_jewels/services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AddAddressScreen extends GetView<AddAddressController> {
//   AddAddressScreen({super.key});

//   final controller = Get.put(AddAddressController());

//   @override
//   Widget build(BuildContext context) {
//     final args = Get.arguments ?? {};
//     final bool isEdit = args["isEdit"] ?? false;
//     final String? id = args["id"];

//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F4FA),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           isEdit ? "Edit Address" : "Add Address",
//           style: const TextStyle(
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
//         actions: [
//           ElevatedButton(
//             onPressed: () async {
//               await StorageService().erase();
//               Get.offAllNamed('/login');
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFFFB700),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(18),
//               ),
//             ),
//             child: Text(
//               "Logout",
//               style: GoogleFonts.lexend(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//         ],
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
//                 inputFormatters: [LengthLimitingTextInputFormatter(35)],
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
//                   onPressed: () {
//                     final name = controller.nameController.text.trim();
//                     final address = controller.addressController.text.trim();
//                     final city = controller.cityController.text.trim();
//                     final postalCode =
//                         controller.postalCodeController.text.trim();

//                     if (name.isEmpty ||
//                         address.isEmpty ||
//                         city.isEmpty ||
//                         postalCode.isEmpty) {
//                       Get.snackbar(
//                         "Validation",
//                         "All fields are required",
//                         backgroundColor: Colors.red,
//                         colorText: Colors.white,
//                       );
//                       return;
//                     }

//                     if (isEdit && id != null) {
//                       controller.updateAddress(
//                           id, name, address, city, postalCode);
//                     } else {
//                       controller.addAddress(name, address, city, postalCode);
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF09243D),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   child: Text(
//                     isEdit ? "Update" : "Submit",
//                     style: const TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   /// Custom reusable input field
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
        title: const Text(
          "Add Address",
          style: TextStyle(
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
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 18),
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
          style: GoogleFonts.plusJakartaSans(
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
