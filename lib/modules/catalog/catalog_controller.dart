
// // import 'dart:convert';
// // import 'package:aesera_jewels/models/Addresses_model.dart';
// // import 'package:aesera_jewels/models/catalog_model.dart';
// // import 'package:aesera_jewels/services/storage_service.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:http/http.dart' as http;

// // // ✅ Import your dashboard screen
// // import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';

// // class CatalogController extends GetxController {
// //   var isLoading = true.obs;
// //   var productList = <ProductModel>[].obs;

// //   final addressController = TextEditingController();
// //   final cityController = TextEditingController();
// //   final postalCodeController = TextEditingController();
// //   final productAmountController = TextEditingController();

// //   var selectedProduct = Rxn<ProductModel>();

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchProducts();
// //   }

// //   /// Fetch products
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
// //         print("Fetched ${productList.length} products");
// //       } else {
// //         Get.snackbar(
// //           "Error",
// //           "Failed to fetch products",
// //           backgroundColor: Colors.red,
// //           colorText: Colors.white,
// //         );
// //       }
// //     } catch (e) {
// //       Get.snackbar(
// //         "Error",
// //         e.toString(),
// //         backgroundColor: Colors.red,
// //         colorText: Colors.white,
// //       );
// //     } finally {
// //       isLoading(false);
// //     }
// //   }

// //   /// Open Address BottomSheet
// //   void openAddressBottomSheet(ProductModel product) async {
// //     selectedProduct.value = product;

// //     // Pre-fill Product Amount (non-editable)
// //     productAmountController.text =
// //         "₹ ${product.price}   (${product.grams ?? 0} gm)";

// //     // Fetch delivery addresses
// //     List<AddressModel> addresses = [];
// //     try {
// //       final userId = await StorageService.getUserId();
// //       if (userId != null) {
// //         final headers = await StorageService().getAuthHeaders();
// //         final uri = Uri.parse("http://13.204.96.244:3000/api/getDeliveryAddress");
// //         final body = json.encode({"userid": userId});
// //         final response = await http.post(uri, headers: headers, body: body);

// //         if (response.statusCode == 200) {
// //           final jsonData = jsonDecode(await response.body);
// //           if (jsonData["status"] == "true") {
// //             final List data = jsonData["data"];
// //             addresses = data.map((e) => AddressModel.fromJson(e)).toList();
// //           }
// //         }
// //       }
// //     } catch (e) {
// //       Get.snackbar("Error", e.toString(),
// //           backgroundColor: Colors.red, colorText: Colors.white);
// //     }

// //     var selectedAddressIndex = 0.obs; // default select first address

// //     // Show BottomSheet
// //     Get.bottomSheet(
// //       StatefulBuilder(
// //         builder: (context, setState) {
// //           return SingleChildScrollView(
// //             padding:
// //                 EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
// //             child: Container(
// //               padding: const EdgeInsets.all(20),
// //               decoration: const BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Text(
// //                         "Delivery Address",
// //                         style: GoogleFonts.plusJakartaSans(
// //                           fontSize: 22,
// //                           fontWeight: FontWeight.w700,
// //                           color: const Color(0xFF0D0F1C),
// //                         ),
// //                       ),
// //                       IconButton(
// //                         onPressed: () => Get.back(),
// //                         icon: const Icon(Icons.close, color: Colors.black),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 16),

// //                   // Display only address names with radio button
// //                   ...List.generate(addresses.length, (index) {
// //                     final addr = addresses[index];
// //                     return Obx(() => RadioListTile<int>(
// //                           value: index,
// //                           groupValue: selectedAddressIndex.value,
// //                           title: Text(addr.name ?? ""),
// //                           onChanged: (val) {
// //                             selectedAddressIndex.value = val!;
// //                             // Store full address in controller (hidden from UI)
// //                             final selected = addresses[val];
// //                             addressController.text = selected.address ?? "";
// //                             cityController.text = selected.city ?? "";
// //                             postalCodeController.text = selected.postalCode ?? "";
// //                           },
// //                         ));
// //                   }),

// //                   const SizedBox(height: 24),
// //                   SizedBox(
// //                     width: double.infinity,
// //                     height: 48,
// //                     child: ElevatedButton(
// //                       onPressed: () {
// //                         if (addresses.isEmpty) return;
// //                         final selected = addresses[selectedAddressIndex.value];
// //                         // Update controller fields for API
// //                         addressController.text = selected.address ?? "";
// //                         cityController.text = selected.city ?? "";
// //                         postalCodeController.text = selected.postalCode ?? "";
// //                         // Submit catalog payment
// //                         submitCatalogPayment();
// //                       },
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: const Color(0xFF09243D),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(25),
// //                         ),
// //                       ),
// //                       child: const Text(
// //                         "Submit",
// //                         style: TextStyle(color: Colors.white, fontSize: 18),
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 12),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //       isScrollControlled: true,
// //     );
// //   }

// //   /// Submit Catalog Payment API
// //   Future<void> submitCatalogPayment() async {
// //     final product = selectedProduct.value;
// //     if (product == null) return;

// //     final address = addressController.text.trim();
// //     final city = cityController.text.trim();
// //     final postal = postalCodeController.text.trim();

// //     if (address.isEmpty || city.isEmpty || postal.isEmpty) {
// //       Get.snackbar(
// //         "Validation",
// //         "Please select a delivery address",
// //         backgroundColor: Colors.red,
// //         colorText: Colors.white,
// //       );
// //       return;
// //     }

// //     final mobile = StorageService().getMobile() ?? "Unknown";

// //     final body = {
// //       "mobileNumber": mobile,
// //       "tagid": product.tagId,
// //       "goldType": product.goldtype,
// //       "description": product.description,
// //       "amount": product.price,
// //       "grams": product.grams ?? 0,
// //       "address": address,
// //       "city": city,
// //       "postCode": postal,
// //       "Paidamount": product.price,
// //       "Paidgrams": product.grams ?? 0,
// //     };

// //     try {
// //       var headers = {'Content-Type': 'application/json'};
// //       var request = http.Request(
// //         'POST',
// //         Uri.parse('http://13.204.96.244:3000/api/catalogPayment'),
// //       );
// //       request.body = json.encode(body);
// //       request.headers.addAll(headers);

// //       http.StreamedResponse response = await request.send();
// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         final responseData = jsonDecode(await response.stream.bytesToString());
// //         CatalogPaymentModel payment =
// //             CatalogPaymentModel.fromJson(responseData["data"]);

// //         // Close bottomsheet
// //         Get.back();

// //         // Show success message
// //         Get.snackbar(
// //           "Success",
// //           "Catalog Payment Created Successfully",
// //           backgroundColor: const Color(0xFF09243D),
// //           colorText: Colors.white,
// //         );

// //         // Navigate to DashboardScreen
// //         Get.offAll(() => DashboardScreen());

// //         print("✅ Catalog Payment ID: ${payment.id}");
// //         print("✅ Grams: ${payment.grams}, Paid Grams: ${payment.paidGrams}");
// //       } else {
// //         Get.snackbar(
// //           "Error",
// //           response.reasonPhrase ?? "Failed",
// //           backgroundColor: Colors.red,
// //           colorText: Colors.white,
// //         );
// //       }
// //     } catch (e) {
// //       Get.snackbar(
// //         "Error",
// //         e.toString(),
// //         backgroundColor: Colors.red,
// //         colorText: Colors.white,
// //       );
// //     }
// //   }
// // }
// import 'dart:convert';
// import 'package:aesera_jewels/models/Addresses_model.dart';
// import 'package:aesera_jewels/models/catalog_model.dart';
// import 'package:aesera_jewels/services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;

// // ✅ Import your dashboard & address screen
// import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
// import 'package:aesera_jewels/modules/address/address_screen.dart';

// class CatalogController extends GetxController {
//   var isLoading = true.obs;
//   var productList = <ProductModel>[].obs;

//   final addressController = TextEditingController();
//   final cityController = TextEditingController();
//   final postalCodeController = TextEditingController();
//   final productAmountController = TextEditingController();

//   var selectedProduct = Rxn<ProductModel>();

//   @override
//   void onInit() {
//     super.onInit();
//     fetchProducts();
//   }

//   /// Fetch products
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
//         print("Fetched ${productList.length} products");
//       } else {
//         Get.snackbar(
//           "Error",
//           "Failed to fetch products",
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         e.toString(),
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading(false);
//     }
//   }

//   /// Open Address BottomSheet
//   void openAddressBottomSheet(ProductModel product) async {
//     selectedProduct.value = product;

//     // Pre-fill Product Amount (non-editable)
//     productAmountController.text =
//         "₹ ${product.price}   (${product.grams ?? 0} gm)";

//     // Fetch delivery addresses
//     List<AddressModel> addresses = [];
//     try {
//       final userId = await StorageService.getUserId();
//       if (userId != null) {
//         final headers = await StorageService().getAuthHeaders();
//         final uri = Uri.parse("http://13.204.96.244:3000/api/getDeliveryAddress");
//         final body = json.encode({"userid": userId});
//         final response = await http.post(uri, headers: headers, body: body);

//         if (response.statusCode == 200) {
//           final jsonData = jsonDecode(await response.body);
//           if (jsonData["status"] == "true") {
//             final List data = jsonData["data"];
//             addresses = data.map((e) => AddressModel.fromJson(e)).toList();
//           }
//         }
//       }
//     } catch (e) {
//       Get.snackbar("Error", e.toString(),
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }

//     var selectedAddressIndex = 0.obs; // default select first address

//     // Show BottomSheet
//     Get.bottomSheet(
//       StatefulBuilder(
//         builder: (context, setState) {
//           return SingleChildScrollView(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Delivery Address",
//                         style: GoogleFonts.plusJakartaSans(
//                           fontSize: 22,
//                           fontWeight: FontWeight.w700,
//                           color: const Color(0xFF0D0F1C),
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () => Get.back(),
//                         icon: const Icon(Icons.close, color: Colors.black),
//                       ),
//                     ],
//                   ),
                  
//                   const SizedBox(height: 16),

//                   // 👉 If no addresses found, show message
//                   if (addresses.isEmpty)
//                     Center(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 20),
//                         child: Text(
//                           "Please update the delivery address",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey[700],
//                           ),
//                         ),
//                       ),
//                     ),

//                   // 👉 Otherwise show radio buttons
//                   if (addresses.isNotEmpty)
//                     ...List.generate(addresses.length, (index) {
//                       final addr = addresses[index];
//                       return Obx(() => RadioListTile<int>(
//                             value: index,
//                             groupValue: selectedAddressIndex.value,
//                             title: Text(addr.name ?? ""),
//                             onChanged: (val) {
//                               selectedAddressIndex.value = val!;
//                               // Store full address in controller (hidden from UI)
//                               final selected = addresses[val];
//                               addressController.text = selected.address ?? "";
//                               cityController.text = selected.city ?? "";
//                               postalCodeController.text =
//                                   selected.postalCode ?? "";
//                             },
//                           ));
//                     }),

//                   const SizedBox(height: 24),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (addresses.isEmpty) {
//                           // 👉 No addresses → go to AddAddressScreen
//                           Get.back();
//                           Get.to(() => AddressScreen());
//                         } else {
//                           // 👉 Normal flow: select & submit
//                           final selected = addresses[selectedAddressIndex.value];
//                           addressController.text = selected.address ?? "";
//                           cityController.text = selected.city ?? "";
//                           postalCodeController.text =
//                               selected.postalCode ?? "";
//                           submitCatalogPayment();
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF09243D),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                       ),
//                       child: Text(
//                         addresses.isEmpty ? "Add Address" : "Submit",
//                         style:
//                             const TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       isScrollControlled: true,
//     );
//   }

//   /// Submit Catalog Payment API
//   Future<void> submitCatalogPayment() async {
//     final product = selectedProduct.value;
//     if (product == null) return;

//     final address = addressController.text.trim();
//     final city = cityController.text.trim();
//     final postal = postalCodeController.text.trim();

//     if (address.isEmpty || city.isEmpty || postal.isEmpty) {
//       Get.snackbar(
//         "Validation",
//         "Please select a delivery address",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }

//     final mobile = StorageService().getMobile() ?? "Unknown";

//     final body = {
//       "mobileNumber": mobile,
//       "tagid": product.tagId,
//       "goldType": product.goldtype,
//       "description": product.description,
//       "amount": product.price,
//       "grams": product.grams ?? 0,
//       "address": address,
//       "city": city,
//       "postCode": postal,
//       "Paidamount": product.price,
//       "Paidgrams": product.grams ?? 0,
//     };

//     try {
//       var headers = {'Content-Type': 'application/json'};
//       var request = http.Request(
//         'POST',
//         Uri.parse('http://13.204.96.244:3000/api/catalogPayment'),
//       );
//       request.body = json.encode(body);
//       request.headers.addAll(headers);

//       http.StreamedResponse response = await request.send();
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final responseData = jsonDecode(await response.stream.bytesToString());
//         CatalogPaymentModel payment =
//             CatalogPaymentModel.fromJson(responseData["data"]);

//         // Close bottomsheet
//         Get.back();

//         // Show success message
//         Get.snackbar(
//           "Success",
//           "Catalog Payment Created Successfully",
//           backgroundColor: const Color(0xFF09243D),
//           colorText: Colors.white,
//         );

//         // Navigate to DashboardScreen
//         Get.offAll(() => DashboardScreen());

//         print("✅ Catalog Payment ID: ${payment.id}");
//         print("✅ Grams: ${payment.grams}, Paid Grams: ${payment.paidGrams}");
//       } else {
//         Get.snackbar(
//           "Error",
//           response.reasonPhrase ?? "Failed",
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         e.toString(),
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
// }
import 'dart:convert';
import 'package:aesera_jewels/models/Addresses_model.dart';
import 'package:aesera_jewels/models/catalog_model.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

// ✅ Import your dashboard & address screen
import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
import 'package:aesera_jewels/modules/address/address_screen.dart';

class CatalogController extends GetxController {
  var isLoading = true.obs;
  var productList = <ProductModel>[].obs;

  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final productAmountController = TextEditingController();

  var selectedProduct = Rxn<ProductModel>();

  // Tax and Delivery Charges
  var taxPercentage = 0.0.obs;
  var deliveryCharge = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchTax();
    fetchDeliveryCharge();
  }

  /// Fetch products
  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse("http://13.204.96.244:3000/api/get-products"),
      );

      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body);
        productList.value =
            decoded.map((json) => ProductModel.fromJson(json)).toList();
        print("Fetched ${productList.length} products");
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

  /// Fetch Tax %
  Future<void> fetchTax() async {
    try {
      var request = http.Request(
          'GET', Uri.parse('http://13.204.96.244:3000/api/getTax'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(await response.stream.bytesToString());
        if (jsonData["status"] == true) {
          taxPercentage.value =
              (jsonData["data"]["percentage"] ?? 0).toDouble();
        }
      }
    } catch (e) {
      print("❌ Tax Fetch Error: $e");
    }
  }

  /// Fetch Delivery Charges
  Future<void> fetchDeliveryCharge() async {
    try {
      var request = http.Request(
          'GET', Uri.parse('http://13.204.96.244:3000/api/getDeliveryCharge'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(await response.stream.bytesToString());
        if (jsonData["status"] == true) {
          deliveryCharge.value =
              (jsonData["data"]["amount"] ?? 0).toDouble();
        }
      }
    } catch (e) {
      print("❌ Delivery Charge Fetch Error: $e");
    }
  }

  /// Open Address BottomSheet
  void openAddressBottomSheet(ProductModel product) async {
    selectedProduct.value = product;

    // Pre-fill Product Amount (non-editable)
    productAmountController.text =
        "₹ ${product.price}   (${product.grams ?? 0} gm)";

    // Fetch delivery addresses
    List<AddressModel> addresses = [];
    try {
      final userId = await StorageService.getUserId();
      if (userId != null) {
        final headers = await StorageService().getAuthHeaders();
        final uri =
            Uri.parse("http://13.204.96.244:3000/api/getDeliveryAddress");
        final body = json.encode({"userid": userId});
        final response = await http.post(uri, headers: headers, body: body);

        if (response.statusCode == 200) {
          final jsonData = jsonDecode(await response.body);
          if (jsonData["status"] == "true") {
            final List data = jsonData["data"];
            addresses = data.map((e) => AddressModel.fromJson(e)).toList();
          }
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }

    var selectedAddressIndex = 0.obs;

    // Show BottomSheet
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          double price = product.price?.toDouble() ?? 0.0;
          double tax = (price * taxPercentage.value) / 100;
          double total = price + tax + deliveryCharge.value;

          return SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
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
                      Text("Order Details",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0D0F1C),
                          )),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.close, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 👉 Price Card
                  _buildPriceCard(price, tax, deliveryCharge.value, total),

                  const SizedBox(height: 16),
                    Text("Select Delivary Location",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0D0F1C),
                          )),
                  // 👉 If no addresses found, just show message
                  if (addresses.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text("Please update the delivery address",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700])),
                      ),
                    ),
                   
                  // 👉 Show only name with radio button
                  if (addresses.isNotEmpty)
                    ...List.generate(addresses.length, (index) {
                      final addr = addresses[index];
                      return Obx(() => RadioListTile<int>(
                            value: index,
                            groupValue: selectedAddressIndex.value,
                            title: Text(addr.name ?? ""),
                            onChanged: (val) {
                              selectedAddressIndex.value = val!;
                              final selected = addresses[val];
                              addressController.text = selected.address ?? "";
                              cityController.text = selected.city ?? "";
                              postalCodeController.text =
                                  selected.postalCode ?? "";
                            },
                          ));
                    }),

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (addresses.isEmpty) {
                          // 👉 No addresses → go to AddAddressScreen
                          Get.back();
                          Get.to(() => AddressScreen());
                        } else {
                          // 👉 Normal flow
                          final selected = addresses[selectedAddressIndex.value];
                          addressController.text = selected.address ?? "";
                          cityController.text = selected.city ?? "";
                          postalCodeController.text =
                              selected.postalCode ?? "";
                          submitCatalogPayment();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF09243D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        addresses.isEmpty ? "Add Address" : "Submit",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      ),
      isScrollControlled: true,
    );
  }

  /// Card Widget for showing Price + Tax + Delivery + Total
  Widget _buildPriceCard(
      double price, double tax, double delivery, double total) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0A2A4D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow("Product Price", "₹ ${price.toStringAsFixed(2)}"),
          const SizedBox(height: 8),
          _buildRow("Tax (${taxPercentage.value.toStringAsFixed(0)}%)",
              "₹ ${tax.toStringAsFixed(2)}"),
          const SizedBox(height: 8),
          _buildRow("Delivery Charges", "₹ ${delivery.toStringAsFixed(2)}"),
          const Divider(color: Colors.white70),
          _buildRow("Total Amount", "₹ ${total.toStringAsFixed(2)}",
              isBold: true),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                color: Colors.amber,
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text(value,
            style: TextStyle(
                color: Colors.amber,
                fontSize: 18,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w600)),
      ],
    );
  }

  /// Submit Catalog Payment API
  Future<void> submitCatalogPayment() async {
    final product = selectedProduct.value;
    if (product == null) return;

    final address = addressController.text.trim();
    final city = cityController.text.trim();
    final postal = postalCodeController.text.trim();

    if (address.isEmpty || city.isEmpty || postal.isEmpty) {
      Get.snackbar("Validation", "Please select a delivery address",
          backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
      return;
    }

    final mobile = StorageService().getMobile() ?? "Unknown";

    final body = {
      "mobileNumber": mobile,
      "tagid": product.tagId,
      "goldType": product.goldtype,
      "description": product.description,
      "amount": product.price,
      "grams": product.grams ?? 0,
      "address": address,
      "city": city,
      "postCode": postal,
      "Paidamount": product.price,
      "Paidgrams": product.grams ?? 0,
    };

    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
        'POST',
        Uri.parse('http://13.204.96.244:3000/api/catalogPayment'),
      );
      request.body = json.encode(body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(await response.stream.bytesToString());
        CatalogPaymentModel payment =
            CatalogPaymentModel.fromJson(responseData["data"]);

        Get.back();
        Get.snackbar("Success", "Catalog Payment Created Successfully",
            backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
        Get.offAll(() => DashboardScreen());

        print("✅ Catalog Payment ID: ${payment.id}");
      } else {
        Get.snackbar("Error", response.reasonPhrase ?? "Failed",
            backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
        backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
    }
  }
}
