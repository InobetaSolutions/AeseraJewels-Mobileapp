// import 'package:aesera_jewels/modules/payment_selection/payment_selection_view.dart';
// import 'package:aesera_jewels/modules/scan_to_pay/scan_to_pay_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CatalogController extends GetxController {
//   final items = List.generate(
//     6,
//     (index) => {
//       'tag': 'PD1303925',
//       'desc': '0.5025 Cto Petzte Amour Schtaire Pendant 18KT Yellow Gold',
//       'price': 'Rs. 13329.78',
//       'image': 'assets/images/Depth 5, Frame 0.png',
//     },
//   );

//   final addressController = TextEditingController();
//   final cityController = TextEditingController();
//   final postalCodeController = TextEditingController();

//   void openAddressBottomSheet() {
//     Get.bottomSheet(
//       Scrollbar(
//         thumbVisibility: true,
//         thickness: 4,
//         child: SingleChildScrollView(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
//           ),
//           child: Container(
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Center(
//                   child: Container(
//                     width: 40,
//                     height: 4,
//                     margin: EdgeInsets.only(bottom: 16),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[400],
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                 ),
//                 Text(
//                   "Delivery Address",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 16),

//                 _buildInput("Address", addressController, "Enter your address"),
//                 SizedBox(height: 12),
//                 _buildInput("City", cityController, "Enter your city"),
//                 SizedBox(height: 12),
//                 _buildInput(
//                   "Postal Code",
//                   postalCodeController,
//                   "Enter your postal code",
//                 ),
//                 SizedBox(height: 24),

//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       final address = addressController.text.trim();
//                       final city = cityController.text.trim();
//                       final postal = postalCodeController.text.trim();

//                       if (address.isEmpty || city.isEmpty || postal.isEmpty) {
//                         Get.snackbar(
//                           "Error",
//                           "All fields are required",
//                           backgroundColor: Colors.redAccent,
//                           colorText: Colors.white,
//                         );
//                         return;
//                       }

//                       Get.to(() => PaymentScreen()); // Close the bottom sheet
//                       Get.snackbar(
//                         "Success",
//                         "Address submitted",
//                         backgroundColor: Colors.green,
//                         colorText: Colors.white,
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF0A2A4D),
//                     ),
//                     child: Text("Submit"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       isScrollControlled: true,
//     );
//   }

//   Widget _buildInput(
//     String label,
//     TextEditingController controller,
//     String hint,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
//         SizedBox(height: 6),
//         TextField(
//           controller: controller,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: TextStyle(color: Colors.teal),
//             filled: true,
//             fillColor: Color(0xFFF1FCFF),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:aesera_jewels/modules/payment_selection/payment_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatalogController extends GetxController {
  final items = List.generate(
    6,
    (index) => {
      'tag': 'PD1303925',
      'desc': '0.5025 Cto Petzte Amour Schtaire Pendant 18KT Yellow Gold',
      'price': 'Rs. 13329.78',
      'image': 'assets/images/Depth 5, Frame 0.png',
    },
  );

  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();

  // Add these observable variables to fix the error
  final isRupees = true.obs;
  final selectedValue = ''.obs;

  void openAddressBottomSheet() {
    Get.bottomSheet(
      Scrollbar(
        thumbVisibility: true,
        thickness: 4,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  "Delivery Address",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),

                // Address Field
                _buildInput(
                  "Address",
                  addressController,
                  "Enter your address",
                  TextInputType.text,
                ),
                SizedBox(height: 12),

                // City Field
                _buildInput(
                  "City",
                  cityController,
                  "Enter your city",
                  TextInputType.text,
                ),
                SizedBox(height: 12),

                // Postal Code Field with Numeric Keyboard
                _buildInput(
                  "Postal Code",
                  postalCodeController,
                  "Enter your postal code",
                  TextInputType.number,
                ),
                SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final address = addressController.text.trim();
                      final city = cityController.text.trim();
                      final postal = postalCodeController.text.trim();

                      if (address.isEmpty || city.isEmpty || postal.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "All fields are required",
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                        );
                        return;
                      }

                      Get.to(
                        () => PaymentScreen(
                          amount: isRupees.value
                              ? selectedValue.value
                              : '${selectedValue.value} grams',
                        ),
                      ); // Close the bottom sheet
                      Get.snackbar(
                        "Success",
                        "Address submitted",
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0A2A4D),
                    ),
                    child: Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  // Helper function to build the input fields
  Widget _buildInput(
    String label,
    TextEditingController controller,
    String hint,
    TextInputType keyboardType,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType, // Set the keyboard type here
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.teal),
            filled: true,
            fillColor: Color(0xFFF1FCFF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
