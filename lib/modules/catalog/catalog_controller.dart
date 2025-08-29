
// // import 'dart:convert';
// // import 'package:aesera_jewels/models/catalog_model.dart';
// // import 'package:aesera_jewels/modules/payment_selection/payment_selection_view.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:http/http.dart' as http;

// // class CatalogController extends GetxController {
// //   var isLoading = true.obs;
// //   var productList = <ProductModel>[].obs;

// //   final addressController = TextEditingController();
// //   final cityController = TextEditingController();
// //   final postalCodeController = TextEditingController();

// //   final selectedValue = 0.0.obs;

// //   @override
// //   void onInit() {
// //     fetchProducts();
// //     super.onInit();
// //   }

// //   /// ✅ Fetch products from API
// //   Future<void> fetchProducts() async {
// //     try {
// //       isLoading(true);

// //       var response = await http.get(
// //         Uri.parse("http://13.204.96.244:3000/api/get-products"),
// //       );

// //       if (response.statusCode == 200) {
// //         final List decoded = jsonDecode(response.body);
// //         productList.value =
// //             decoded.map((json) => ProductModel.fromJson(json)).toList();
// //       } else {
// //         Get.snackbar("Error", "Failed to fetch products",
// //             backgroundColor: Colors.red, colorText: Colors.white);
// //       }
// //     } catch (e) {
// //       Get.snackbar("Error", e.toString(),
// //           backgroundColor: Colors.red, colorText: Colors.white);
// //     } finally {
// //       isLoading(false);
// //     }
// //   }

// //   /// ✅ Bottom Sheet for Address Input
// //   void openAddressBottomSheet() {
// //     Get.bottomSheet(
// //       SingleChildScrollView(
// //         padding: EdgeInsets.only(
// //           bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
// //         ),
// //         child: Container(
// //           padding: const EdgeInsets.all(20),
// //           decoration: const BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
// //           ),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Text(
// //                     "Delivery Address",
// //                     style: GoogleFonts.plusJakartaSans(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.w700,
// //                       color: const Color(0xFF0D0F1C),
// //                     ),
// //                   ),
// //                   IconButton(
// //                     onPressed: () => Get.back(),
// //                     icon: const Icon(Icons.close, color: Colors.black87),
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 16),

// //               buildInputField("Address", addressController,
// //                   "Enter your address", TextInputType.text),
// //               const SizedBox(height: 12),

// //               buildInputField("City", cityController, "Enter your city",
// //                   TextInputType.text),
// //               const SizedBox(height: 12),

// //               buildInputField("Postal Code", postalCodeController,
// //                   "Enter postal code", TextInputType.number),

// //               const SizedBox(height: 20),
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: submitAddress,
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: const Color(0xFF09243D),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                     padding: const EdgeInsets.symmetric(vertical: 14),
// //                   ),
// //                   child: Text(
// //                     "Confirm Order",
// //                     style: GoogleFonts.plusJakartaSans(
// //                       fontSize: 15,
// //                       fontWeight: FontWeight.w700,
// //                       color: Colors.white,
// //                     ),
// //                   ),
// //                 ),
// //               )
// //             ],
// //           ),
// //         ),
// //       ),
// //       isScrollControlled: true,
// //     );
// //   }

// //   /// ✅ Input Field Builder
// //   Widget buildInputField(String label, TextEditingController controller,
// //       String hint, TextInputType type) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           label,
// //           style: GoogleFonts.plusJakartaSans(
// //             fontSize: 14,
// //             fontWeight: FontWeight.w600,
// //             color: Colors.black,
// //           ),
// //         ),
// //         const SizedBox(height: 6),
// //         TextField(
// //           controller: controller,
// //           keyboardType: type,
// //           maxLength: label == "Postal Code" ? 7 : 40,
// //           decoration: InputDecoration(
// //             hintText: hint,
// //             counterText: "",
// //             contentPadding:
// //                 const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
// //             border: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(10),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   /// ✅ Address Validation + Navigate to Payment
// //   void submitAddress() {
// //     final address = addressController.text.trim();
// //     final city = cityController.text.trim();
// //     final postal = postalCodeController.text.trim();

// //     if (address.isEmpty || city.isEmpty || postal.isEmpty) {
// //       _showError("All fields are required");
// //       return;
// //     }

// //     if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(city)) {
// //       _showError("City must contain only alphabets");
// //       return;
// //     }

// //     if (!RegExp(r'^\d{7}$').hasMatch(postal)) {
// //       _showError("Postal code must be exactly 7 digits");
// //       return;
// //     }

// //     Get.back(); // close sheet
// //     Get.to(() => PaymentScreen(sourceScreen: "catalog"), arguments: {
// //       "amount": selectedValue.value.toStringAsFixed(2),
// //     });
// //   }

// //   void _showError(String message) {
// //     Get.snackbar("Validation", message,
// //         backgroundColor: Colors.red, colorText: Colors.white);
// //   }

// //   } 
// import 'dart:convert';
// import 'package:aesera_jewels/models/catalog_model.dart';
// import 'package:aesera_jewels/modules/payment_selection/payment_selection_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;

// class CatalogController extends GetxController {
//   var isLoading = true.obs;
//   var productList = <ProductModel>[].obs;

//   final addressController = TextEditingController();
//   final cityController = TextEditingController();
//   final postalCodeController = TextEditingController();

//   final selectedValue = 0.0.obs;

//   @override
//   void onInit() {
//     fetchProducts();
//     super.onInit();
//   }

//   /// ✅ Fetch products from API
//   Future<void> fetchProducts() async {
//     try {
//       isLoading(true);

//       var response = await http.get(
//         Uri.parse("http://13.204.96.244:3000/api/get-products"),
//       );

//       if (response.statusCode == 200) {
//         final List decoded = jsonDecode(response.body);
//         productList.value =
//             decoded.map((json) => ProductModel.fromJson(json)).toList();
//       } else {
//         Get.snackbar("Error", "Failed to fetch products",
//             backgroundColor: Colors.red, colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar("Error", e.toString(),
//           backgroundColor: Colors.red, colorText: Colors.white);
//     } finally {
//       isLoading(false);
//     }
//   }

//   /// ✅ Bottom Sheet for Address Input
//   void openAddressBottomSheet() {
//     Get.bottomSheet(
//       SingleChildScrollView(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
//         ),
//         child: Container(
          
//           padding: const EdgeInsets.all(20),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Delivery Address",
//                     style: GoogleFonts.plusJakartaSans(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w700,
//                       color: const Color(0xFF0D0F1C),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () => Get.back(),
//                     icon: const Icon(Icons.close, color: Color( 0xFF0D0F1C) ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               buildInputField("Address", addressController,
//                   "Enter your address", TextInputType.text),
//               const SizedBox(height: 16),

//               buildInputField("City", cityController, "Enter your city",
//                   TextInputType.text),
//               const SizedBox(height: 16),

//               buildInputField("Postal Code", postalCodeController,
//                   "Enter your postal code", TextInputType.number),

//               const SizedBox(height: 20),
//               SizedBox(
//                 width: 358,
//                 height: 48,
//                 child: ElevatedButton(
//                   onPressed: submitAddress,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF09243D),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(24),
//                     ),
//                     elevation: 4,
//                     shadowColor: Colors.black.withOpacity(0.25),
//                   ),
//                   child: Text(
//                     "Submit",
//                     style: GoogleFonts.plusJakartaSans(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                       color: const Color(0xFFF7FAFC),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       isScrollControlled: true,
//     );
//   }

//   /// ✅ Input Field Builder
//   Widget buildInputField(String label, TextEditingController controller,
//       String hint, TextInputType type) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.plusJakartaSans(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             color: Color(0xFF0D0F1C),
//           ),
//         ),
//         const SizedBox(height: 6),
//         Container(
//           width: 358,
//           height: 56,
//           decoration: BoxDecoration(
//             color: const Color(0xFFF6FDFF),
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: const [
//               BoxShadow(
//                 color: Color(0x40000000), // #00000040
//                 offset: Offset(-0, 4),
//                 blurRadius: 4,
//                 spreadRadius: 0,
//               ),
//             ],
//           ),
//           child: TextField(
//             controller: controller,
//             keyboardType: type,
//             maxLength: label == "Postal Code" ? 7 : 40,
//             style: GoogleFonts.plusJakartaSans(
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//               color: const Color(0xFF2596BE),
//             ),
//             decoration: InputDecoration(
//               hintText: hint,
//               hintStyle: GoogleFonts.plusJakartaSans(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//                 color: const Color(0xFF2596BE),
//               ),
//               counterText: "",
//               border: InputBorder.none,
//               contentPadding:
//                   const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   /// ✅ Address Validation + Navigate to Payment
//   void submitAddress() {
//     final address = addressController.text.trim();
//     final city = cityController.text.trim();
//     final postal = postalCodeController.text.trim();

//     if (address.isEmpty || city.isEmpty || postal.isEmpty) {
//       _showError("All fields are required");
//       return;
//     }

//     if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(city)) {
//       _showError("City must contain only alphabets");
//       return;
//     }

//     if (!RegExp(r'^\d{7}$').hasMatch(postal)) {
//       _showError("Postal code must be exactly 7 digits");
//       return;
//     }

//     Get.back(); 
//     Get.to(() => PaymentScreen(), arguments: {
//   "source": "catalog",
//   "amount": selectedValue.value.toStringAsFixed(2),
// });

//     // close sheet
//     // Get.to(() => PaymentScreen(sourceScreen: "catalog"), arguments: {
//     //   "amount": selectedValue.value.toStringAsFixed(2),
//     // });
//   }

//   void _showError(String message) {
//     Get.snackbar("Validation", message,
//         backgroundColor: Colors.red, colorText: Colors.white);
//   }
// }
import 'dart:convert';
import 'package:aesera_jewels/models/catalog_model.dart';
import 'package:aesera_jewels/modules/payment_selection/payment_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Ensure get package is properly imported
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CatalogController extends GetxController {
  var isLoading = true.obs;
  var productList = <ProductModel>[].obs;

  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();

  final selectedValue = 0.0.obs;

  @override
  void onInit() {
    fetchProducts();
  }

  /// Fetch products
  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      var response =
          await http.get(Uri.parse("http://13.204.96.244:3000/api/get-products"));

      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body);
        productList.value =
            decoded.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        Get.snackbar("Error", "Failed to fetch products",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  /// Address BottomSheet
  void openAddressBottomSheet() {
    Get.bottomSheet(
      SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Delivery Address",
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close, color: Colors.black))
                ],
              ),
              const SizedBox(height: 12),

              buildInputField("Address", addressController, "Enter your address"),
              const SizedBox(height: 12),
              buildInputField("City", cityController, "Enter your city"),
              const SizedBox(height: 12),
              buildInputField("Postal Code", postalCodeController,
                  "Enter your postal code",
                  type: TextInputType.number),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submitAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF09243D),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Submit",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget buildInputField(String label, TextEditingController controller,
      String hint, {TextInputType type = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
            hintText: hint,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        )
      ],
    );
  }

  void submitAddress() {
    final address = addressController.text.trim();
    final city = cityController.text.trim();
    final postal = postalCodeController.text.trim();

    if (address.isEmpty || city.isEmpty || postal.isEmpty) {
      _showError("All fields are required");
      return;
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(city)) {
      _showError("City must contain only alphabets");
      return;
    }
    if (!RegExp(r'^\d{7}$').hasMatch(postal)) {
      _showError("Postal must be 7 digits");
      return;
    }

    Get.back();
    Get.to(() => PaymentScreen(), arguments: {
      "amount": selectedValue.value.toStringAsFixed(2),
      "source": "catalog",
    });
  }

  void _showError(String msg) {
    Get.snackbar("Validation", msg,
        backgroundColor: Colors.red, colorText: Colors.white);
  }
}
