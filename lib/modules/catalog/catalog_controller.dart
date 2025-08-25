
// // import 'dart:convert';
// // import 'package:aesera_jewels/models/catalog_model.dart';
// // import 'package:aesera_jewels/modules/payment_selection/payment_selection_controller.dart';
// // //import 'package:aesera_jewels/modules/payment/payment_screen.dart';
// // import 'package:aesera_jewels/modules/payment_selection/payment_selection_view.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;

// // class CatalogController extends GetxController {
// //   var isLoading = true.obs;
// //   var productList = <ProductModel>[].obs;

// //   // Bottom sheet controllers
// //   final addressController = TextEditingController();
// //   final cityController = TextEditingController();
// //   final postalCodeController = TextEditingController();

// //   // Selected product price
// //   final selectedValue = 0.0.obs;

// //   @override
// //   void onInit() {
// //     fetchProducts();
// //     super.onInit();
// //   }

// //   /// Fetch products from API
// //   Future<void> fetchProducts() async {
// //     try {
// //       isLoading(true);

// //       var request = http.Request(
// //         'GET',
// //         Uri.parse('http://13.204.96.244:3000/api/get-products'),
// //       );

// //       http.StreamedResponse response = await request.send();

// //       if (response.statusCode == 200) {
// //         final body = await response.stream.bytesToString();
// //         final List decoded = jsonDecode(body);

// //         productList.value =
// //             decoded.map((json) => ProductModel.fromJson(json)).toList();
// //       } else {
// //         Get.snackbar("Error", "Failed to fetch products: ${response.reasonPhrase}",
// //             backgroundColor: Colors.redAccent, colorText: Colors.white);
// //       }
// //     } catch (e) {
// //       Get.snackbar("Exception", e.toString(),
// //           backgroundColor: Colors.redAccent, colorText: Colors.white);
// //     } finally {
// //       isLoading(false);
// //     }
// //   }

// //   /// Open bottom sheet for address entry
// //   void openAddressBottomSheet() {
// //     Get.bottomSheet(
// //       Scrollbar(
// //         thumbVisibility: true,
// //         thickness: 3,
// //         child: SingleChildScrollView(
// //           padding: EdgeInsets.only(
// //             bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
// //           ),
// //           child: Container(
// //             padding: const EdgeInsets.all(20),
// //             decoration: const BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
// //             ),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     const Text(
// //                       "Delivery Address",
// //                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                     ),
// //                     IconButton(
// //                       onPressed: () => Get.back(),
// //                       icon: const Icon(Icons.close),
// //                     ),
// //                   ],
// //                 ),
// //                 const SizedBox(height: 16),

// //                 _buildInput("Address", addressController, "Enter your address",
// //                     TextInputType.text),
// //                 const SizedBox(height: 12),

// //                 _buildInput("City", cityController, "Enter your city",
// //                     TextInputType.text),
// //                 const SizedBox(height: 12),

// //                 _buildInput("Postal Code", postalCodeController,
// //                     "Enter your postal code", TextInputType.number),
// //                 const SizedBox(height: 20),

// //                 SizedBox(
// //                   width: double.infinity,
// //                   child: ElevatedButton(
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: const Color(0xFF0A2A4D),
// //                       padding: const EdgeInsets.symmetric(vertical: 14),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(8),
// //                       ),
// //                     ),
// //                     onPressed: submitAddress,
// //                     child: const Text(
// //                       "Proceed to Payment",
// //                       style: TextStyle(
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.white),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //       isScrollControlled: true,
// //     );
// //   }

// //   /// Validate & Navigate
// //   void submitAddress() {
// //     final address = addressController.text.trim();
// //     final city = cityController.text.trim();
// //     final postal = postalCodeController.text.trim();

// //     if (address.isEmpty || city.isEmpty || postal.isEmpty) {
// //       Get.snackbar("Error", "All fields are required",
// //           backgroundColor: Colors.redAccent, colorText: Colors.white);
// //       return;
// //     }
// //     if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(city)) {
// //       Get.snackbar("Error", "City must contain only alphabets",
// //           backgroundColor: Colors.redAccent, colorText: Colors.white);
// //       return;
// //     }
// //     if (!RegExp(r'^[0-9]+$').hasMatch(postal)) {
// //       Get.snackbar("Error", "Postal code must contain only digits",
// //           backgroundColor: Colors.redAccent, colorText: Colors.white);
// //       return;
// //     }

// //     Get.back(); // close bottom sheet

// //     // Navigate to PaymentScreen
// //     // Get.to(
// //     //   () =>  PaymentScreen(sourceScreen: '',),
// //     //   arguments: {
// //     //     "amount": selectedValue.value.toStringAsFixed(2),
// //     //     "source": "catalog",
// //     //   },
// //     // );
// //     // From catalog screen:
// // Get.to(() => PaymentScreen(sourceScreen: "catalog"));



// //   }

// //   /// Input builder
// //   Widget _buildInput(String label, TextEditingController controller,
// //       String hint, TextInputType type) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
// //         const SizedBox(height: 6),
// //         TextField(
// //           controller: controller,
// //           keyboardType: type,
// //           decoration: InputDecoration(
// //             hintText: hint,
// //             hintStyle: const TextStyle(color: Colors.teal),
// //             filled: true,
// //             fillColor: const Color(0xFFF1FCFF),
// //             border: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(12),
// //               borderSide: BorderSide.none,
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// import 'dart:convert';
// import 'package:aesera_jewels/models/catalog_model.dart';
// import 'package:aesera_jewels/modules/payment_selection/payment_selection_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
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

//   /// Fetch products from API
//   Future<void> fetchProducts() async {
//     try {
//       isLoading(true);

//       var request = http.Request(
//         'GET',
//         Uri.parse('http://13.204.96.244:3000/api/get-products'),
//       );

//       http.StreamedResponse response = await request.send();

//       if (response.statusCode == 200) {
//         final body = await response.stream.bytesToString();
//         final List decoded = jsonDecode(body);

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

//   /// Simulated Original Price (e.g., 20% more)
//   double calculateOriginalPrice(double price) {
//     return (price * 1.2);
//   }

//   /// Bottom sheet for address input
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
//             borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Center(
//                 child: Container(
//                   width: 40,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade300,
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text("Delivery Address",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   IconButton(
//                     onPressed: () => Get.back(),
//                     icon: const Icon(Icons.close),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               _buildInput("Address", addressController, "Enter your address",
//                   TextInputType.text),
//               const SizedBox(height: 12),

//               _buildInput(
//                   "City", cityController, "Enter your city", TextInputType.text),
//               const SizedBox(height: 12),

//               _buildInput("Postal Code", postalCodeController,
//                   "Enter your postal code", TextInputType.number),
//               const SizedBox(height: 20),

//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF0A2A4D),
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   onPressed: submitAddress,
//                   child: const Text(
//                     "Submit",
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       isScrollControlled: true,
//     );
//   }

//   /// Address form input builder
//   Widget _buildInput(String label, TextEditingController controller,
//       String hint, TextInputType type) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label,
//             style:
//                 const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//         const SizedBox(height: 6),
//         TextField(
//           controller: controller,
//           keyboardType: type,
//           maxLength: label == "Postal Code" ? 7 : 30,
//           decoration: InputDecoration(
//             counterText: "",
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.teal),
//             filled: true,
//             fillColor: const Color(0xFFF1FCFF),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   /// Validate and navigate to payment
//   void submitAddress() {
//     final address = addressController.text.trim();
//     final city = cityController.text.trim();
//     final postal = postalCodeController.text.trim();

//     if (address.isEmpty || city.isEmpty || postal.isEmpty) {
//       _showError("All fields are required");
//       return;
//     }

//     if (address.length > 30) {
//       _showError("Address must not exceed 30 characters");
//       return;
//     }

//     if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(city)) {
//       _showError("City must contain only alphabets");
//       return;
//     }

//     if (city.length > 30) {
//       _showError("City must not exceed 30 characters");
//       return;
//     }

//     if (!RegExp(r'^\d{7}$').hasMatch(postal)) {
//       _showError("Postal code must be exactly 7 digits");
//       return;
//     }

//     Get.back(); // Close bottom sheet

//     Get.to(() => PaymentScreen(sourceScreen: "catalog"), arguments: {
//       "amount": selectedValue.value.toStringAsFixed(2),
//     });
//   }

//   /// Display error message
//   void _showError(String message) {
//     Get.snackbar("Validation", message,
//         backgroundColor: Colors.redAccent, colorText: Colors.white);
//   }
// }
import 'dart:convert';
import 'package:aesera_jewels/models/catalog_model.dart';
import 'package:aesera_jewels/modules/payment_selection/payment_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    super.onInit();
  }

  /// Fetch products from API
  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      var request = http.Request(
        'GET',
        Uri.parse('http://13.204.96.244:3000/api/get-products'),
      );

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final body = await response.stream.bytesToString();
        final List decoded = jsonDecode(body);

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

  /// Calculate original price (20% markup)
  double calculateOriginalPrice(double price) {
    return price * 1.2;
  }

  /// Open bottom sheet
  void openAddressBottomSheet() {
    Get.bottomSheet(
      SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Delivery Address",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              buildInputField("Address", addressController,
                  "Enter your address", TextInputType.text),
              const SizedBox(height: 12),

              buildInputField("City", cityController, "Enter your city",
                  TextInputType.text),
              const SizedBox(height: 12),

              buildInputField("Postal Code", postalCodeController,
                  "Enter your postal code", TextInputType.number),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submitAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A2A4D),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 4,
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  /// Input Field Builder Styled as Card
  Widget buildInputField(String label, TextEditingController controller,
      String hint, TextInputType type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF1FCFF),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: type,
            maxLength: label == "Postal Code" ? 7 : 30,
            decoration: InputDecoration(
              counterText: "",
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.teal),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),
        ),
      ],
    );
  }

  /// Submit address and navigate
  void submitAddress() {
    final address = addressController.text.trim();
    final city = cityController.text.trim();
    final postal = postalCodeController.text.trim();

    if (address.isEmpty || city.isEmpty || postal.isEmpty) {
      _showError("All fields are required");
      return;
    }

    if (address.length > 30) {
      _showError("Address must not exceed 30 characters");
      return;
    }

    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(city)) {
      _showError("City must contain only alphabets");
      return;
    }

    if (city.length > 30) {
      _showError("City must not exceed 30 characters");
      return;
    }

    if (!RegExp(r'^\d{7}$').hasMatch(postal)) {
      _showError("Postal code must be exactly 7 digits");
      return;
    }

    Get.back(); // close sheet

    Get.to(() => PaymentScreen(sourceScreen: "catalog"), arguments: {
      "amount": selectedValue.value.toStringAsFixed(2),
    });
  }

  void _showError(String message) {
    Get.snackbar("Validation", message,
        backgroundColor: Colors.redAccent, colorText: Colors.white);
  }
}
