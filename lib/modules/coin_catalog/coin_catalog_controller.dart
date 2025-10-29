// import 'dart:convert';
// import 'package:aesera_jewels/modules/address/address_screen.dart';
// import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
// import 'package:aesera_jewels/modules/investment_details/investment_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;

// import '../../Api/base_url.dart';
// import '../../models/catalog_model.dart';
// import '../../models/Addresses_model.dart';
// import '../../services/storage_service.dart';

// class CoinCatalogController extends GetxController {
//   var isLoading = true.obs;
//   var productList = <ProductModel>[].obs;

//   final addressController = TextEditingController();
//   final cityController = TextEditingController();
//   final postalCodeController = TextEditingController();
//   final productAmountController = TextEditingController();
//   final revertAmountController = TextEditingController();

//   var selectedProduct = Rxn<ProductModel>();
//   var taxPercentage = 0.0.obs;
//   var deliveryCharge = 0.0.obs;

//   var totalInvestment = 0.0.obs;
//   var remainingAmount = 0.0.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchProducts();
//     fetchTax();
//     fetchDeliveryCharge();
//     fetchTotalInvestment();
//   }

//   Future<void> fetchProducts() async {
//     try {
//       isLoading(true);
//       final response =
//           await http.get(Uri.parse("${BaseUrl.baseUrl}get-products"));
//       if (response.statusCode == 200) {
//         final List decoded = jsonDecode(response.body);
//         productList.value =
//             decoded.map((e) => ProductModel.fromJson(e)).toList();
//       } else {
//         Get.snackbar("Error", "Failed to fetch products",
//             backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
//       }
//     } catch (_) {
//       Get.snackbar("Error", "Please check your internet connection",
//           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<void> fetchTax() async {
//     try {
//       var request = http.Request('GET', Uri.parse('${BaseUrl.baseUrl}getTax'));
//       final response = await request.send();
//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(await response.stream.bytesToString());
//         taxPercentage.value = (jsonData["data"]["percentage"] ?? 0).toDouble();
//       }
//     } catch (_) {}
//   }

//   Future<void> fetchDeliveryCharge() async {
//     try {
//       var request =
//           http.Request('GET', Uri.parse('${BaseUrl.baseUrl}getDeliveryCharge'));
//       final response = await request.send();
//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(await response.stream.bytesToString());
//         deliveryCharge.value = (jsonData["data"]["amount"] ?? 0).toDouble();
//       }
//     } catch (_) {}
//   }

//   Future<void> fetchTotalInvestment() async {
//     try {
//       final mobile = await StorageService.getMobileAsync();
//       if (mobile != null) {
//         final headers = await StorageService().getAuthHeaders();
//         final response = await http.post(
//           Uri.parse("${BaseUrl.baseUrl}getpaymenthistory"),
//           headers: headers,
//           body: jsonEncode({"mobile": mobile}),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           totalInvestment.value = (data["totalAmount"] ?? 0).toDouble();
//         }
//       }
//     } catch (_) {}
//   }

//   void showPaymentMethodDialog(ProductModel item) {
//     Get.defaultDialog(
//       title: "Select Payment Type",
//       titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       radius: 12,
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Text(
//             "Choose your payment method for this purchase.",
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               Get.back();
//               openAddressBottomSheet(item);
//             },
//             style: ElevatedButton.styleFrom(
//               minimumSize: const Size(double.infinity, 45),
//               backgroundColor: const Color(0xFFFFB700),
//             ),
//             child: const Text(
//               "Make a New Payment",
//               style: TextStyle(color: Colors.black, fontSize: 15),
//             ),
//           ),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () {
//               Get.back();
//               openRevertPaymentBottomSheet(item);
//             },
//             style: ElevatedButton.styleFrom(
//               minimumSize: const Size(double.infinity, 45),
//               backgroundColor: const Color(0xFF0A2A4D),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Center(
//                 child: const Text(
//                   "Deduct from the Invested Amount",textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.white, fontSize: 15),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void openAddressBottomSheet(ProductModel product) async {
//     selectedProduct.value = product;
//     productAmountController.text =
//         "₹ ${product.price}   (${product.grams ?? 0} gm)";

//     List<AddressModel> addresses = await _fetchUserAddresses();
//     var selectedAddressIndex = 0.obs;

//     Get.bottomSheet(
//       StatefulBuilder(
//         builder: (context, setState) {
//           double price = product.price?.toDouble() ?? 0.0;
//           double tax = (price * taxPercentage.value) / 100;
//           double total = price + tax + deliveryCharge.value;

//           return SingleChildScrollView(
//             padding:
//                 EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Order Details",
//                           style: GoogleFonts.plusJakartaSans(
//                             fontSize: 22,
//                             fontWeight: FontWeight.w700,
//                             color: const Color(0xFF0D0F1C),
//                           )),
//                       IconButton(
//                         onPressed: () => Get.back(),
//                         icon: const Icon(Icons.close, color: Colors.black),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   _buildPriceCard(price, tax, deliveryCharge.value, total),
//                   const SizedBox(height: 16),
//                   Center(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 20),
//                       child: Text(
//                         "Select Delivery Location",
//                         style: GoogleFonts.plusJakartaSans(
//                           fontSize: 22,
//                           fontWeight: FontWeight.w700,
//                           color: const Color(0xFF0D0F1C),
//                         ),
//                       ),
//                     ),
//                   ),
//                   if (addresses.isEmpty)
//                     const Text("Please add a delivery address."),
//                   if (addresses.isNotEmpty)
//                     ...List.generate(addresses.length, (index) {
//                       final addr = addresses[index];
//                       return Obx(() => RadioListTile<int>(
//                             value: index,
//                             groupValue: selectedAddressIndex.value,
//                             title: Text(addr.name ?? ""),
//                             onChanged: (val) {
//                               selectedAddressIndex.value = val!;
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
//                           Get.back();
//                           Get.to(() => AddressScreen());
//                         } else {
//                           final selected =
//                               addresses[selectedAddressIndex.value];
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

//   void openRevertPaymentBottomSheet(ProductModel product) {
//     selectedProduct.value = product;
//     revertAmountController.text = "";
//     remainingAmount.value = totalInvestment.value;

//     Get.bottomSheet(

//       StatefulBuilder(
//         builder: (context, setState) {
//           return Padding(
//             padding:
//                 EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Container(

//               padding: const EdgeInsets.all(20),
//               decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Center(
//                       child: Text(
//                         "Deduct  from  the Invested  Amount",textAlign: TextAlign.center,
//                         style: GoogleFonts.plusJakartaSans(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Obx(() => _buildRevertAmountRow()),
//                     const SizedBox(height: 24),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 48,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           submitRevertPayment();
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF0A2A4D),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                         ),
//                         child: Center(
//                           child: const Text(
//                             "Deduct from the Invested Amount",textAlign: TextAlign.center,
//                             style: TextStyle(color: Colors.white, fontSize: 15),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//       isScrollControlled: true,
//     );
//   }

//   // Widget _buildRevertAmountRow() {
//   //   double revert = double.tryParse(revertAmountController.text) ?? 0.0;
//   //   remainingAmount.value = totalInvestment.value - revert;

//   //   return Column(
//   //     crossAxisAlignment: CrossAxisAlignment.start,
//   //     children: [
//   //       TextField(
//   //         controller: revertAmountController,
//   //         keyboardType: TextInputType.number,
//   //         inputFormatters: [
//   //           FilteringTextInputFormatter.digitsOnly,
//   //           LengthLimitingTextInputFormatter(10),
//   //         ],
//   //         decoration: const InputDecoration(
//   //           labelText: "Revert Amount",
//   //           border: OutlineInputBorder(),
//   //         ),
//   //         onChanged: (val) {
//   //           double amount = double.tryParse(val) ?? 0.0;
//   //           remainingAmount.value = totalInvestment.value - amount;
//   //         },
//   //       ),
//   //       const SizedBox(height: 12),
//   //       Container(
//   //         width: double.infinity,
//   //         padding: const EdgeInsets.all(20),
//   //         decoration: BoxDecoration(
//   //           color: const Color(0xFF0A2A4D),
//   //           borderRadius: BorderRadius.circular(16),
//   //         ),
//   //         child: Column(
//   //           crossAxisAlignment: CrossAxisAlignment.start,
//   //           children: [
//   //             Text(
//   //               "Total Investment Amount: ₹${totalInvestment.value.toStringAsFixed(2)}",
//   //               style: const TextStyle(color: Colors.amber, fontSize: 18),
//   //             ),
//   //             const SizedBox(height: 8),
//   //             Text(
//   //               "Remaining Balance Amount: ₹${remainingAmount.value.toStringAsFixed(2)}",
//   //               style: GoogleFonts.plusJakartaSans(
//   //                 fontSize: 20,
//   //                 fontWeight: FontWeight.w700,
//   //                 color: Colors.white,
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }
//   Widget _buildRevertAmountRow() {
//   double revert = double.tryParse(revertAmountController.text) ?? 0.0;
//   remainingAmount.value = totalInvestment.value - revert;

//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Container(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 12,
//           vertical: 2,
//         ),
//         decoration: BoxDecoration(
//           color: Colors.blue.shade50,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               offset: const Offset(0, 3),
//               blurRadius: 4,
//               color: Colors.black.withOpacity(0.2),
//             ),
//           ],
//         ),
//         child: TextField(
//           controller: revertAmountController,
//           keyboardType: TextInputType.number,
//           inputFormatters: [
//             FilteringTextInputFormatter.digitsOnly,
//             LengthLimitingTextInputFormatter(10),
//           ],
//           style: const TextStyle(
//             fontSize: 15,
//             fontWeight: FontWeight.w600,
//             color: Colors.teal,
//           ),
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             prefixIcon: Padding(
//               padding: const EdgeInsets.only(
//                 left: 10,
//                 right: 8,
//                 top: 10,
//                 bottom: 0
//               ),
//               child: Text(
//                 "₹",
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.teal.shade700,
//                 ),
//               ),
//             ),
//             // hintText: "Enter Revert Amount",
//             // hintStyle: const TextStyle(color: Colors.grey
//             // ),
//           ),
//           onChanged: (val) {
//             double amount = double.tryParse(val) ?? 0.0;
//             remainingAmount.value = totalInvestment.value - amount;
//           },
//         ),
//       ),
//       const SizedBox(height: 12),
//       Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: const Color(0xFF0A2A4D),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Total Investment Amount: ₹${totalInvestment.value.toStringAsFixed(2)}",
//               style: GoogleFonts.plusJakartaSans(

//                 fontWeight: FontWeight.w700,
//                color: Colors.amber, fontSize: 15),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "Remaining Balance Amount: ₹${remainingAmount.value.toStringAsFixed(2)}",
//               style: GoogleFonts.plusJakartaSans(

//                 fontWeight: FontWeight.w700,
//                color: Colors.amber, fontSize: 15
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }

//   Future<List<AddressModel>> _fetchUserAddresses() async {
//     List<AddressModel> addresses = [];
//     try {
//       final userId = await StorageService.getUserId();
//       if (userId != null) {
//         final headers = await StorageService().getAuthHeaders();
//         final uri = Uri.parse("${BaseUrl.baseUrl}getDeliveryAddress");
//         final body = json.encode({"userid": userId});
//         final response = await http.post(uri, headers: headers, body: body);
//         if (response.statusCode == 200) {
//           final jsonData = jsonDecode(response.body);
//           if (jsonData["status"] == "true") {
//             final List data = jsonData["data"];
//             addresses = data.map((e) => AddressModel.fromJson(e)).toList();
//           }
//         }
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Please check your internet connection",
//           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
//     }
//     return addresses;
//   }

//   Future<void> submitCatalogPayment() async {
//     final product = selectedProduct.value;
//     if (product == null) return;

//     final address = addressController.text.trim();
//     final city = cityController.text.trim();
//     final postal = postalCodeController.text.trim();

//     if (address.isEmpty || city.isEmpty || postal.isEmpty) {
//       Get.snackbar("Validation", "Please select a delivery address",
//           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
//       return;
//     }

//     final mobile = await StorageService.getMobileAsync() ?? "Unknown";

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
//         Uri.parse('${BaseUrl.baseUrl}catalogPayment'),
//       );
//       request.body = json.encode(body);
//       request.headers.addAll(headers);

//       http.StreamedResponse response = await request.send();
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         Get.back();
//         Get.snackbar("Success", "Catalog Payment Created Successfully",
//             backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
//         Get.offAll(() => DashboardScreen());
//       } else {
//         Get.snackbar("Error", response.reasonPhrase ?? "Failed",
//             backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Please check your internet connection",
//           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
//     }
//   }

//   Future<void> submitRevertPayment() async {
//     final product = selectedProduct.value;
//     if (product == null) return;

//     double revertAmount = double.tryParse(revertAmountController.text) ?? 0.0;
//     if (revertAmount <= 0 || revertAmount > totalInvestment.value) {
//       Get.snackbar("Validation", "Enter valid revert amount",
//           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
//       return;
//     }

//     try {
//       final mobile = await StorageService.getMobileAsync() ?? "Unknown";

//       final body = {
//         "mobileNumber": mobile,
//         "productId": product.id,
//         "revertAmount": revertAmount,
//       };

//       final headers = await StorageService().getAuthHeaders();
//       final response = await http.post(
//         Uri.parse("${BaseUrl.baseUrl}revertPayment"),
//         headers: headers,
//         body: jsonEncode(body),
//       );

//       if (response.statusCode == 200) {
//         Get.back();
//         Get.snackbar("Success", "Payment reverted successfully",
//             backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
//         fetchTotalInvestment();
//       } else {
//         Get.snackbar("Error", "Failed to revert payment",
//             backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Please check your internet connection",
//           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
//     }
//   }

//   Widget _buildPriceCard(
//       double price, double tax, double delivery, double total) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: const Color(0xFF0A2A4D),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildRow("Product Price", "₹ ${price.toStringAsFixed(2)}"),
//           const SizedBox(height: 8),
//           _buildRow(
//               "Tax (${taxPercentage.value.toStringAsFixed(0)}%)",
//               "₹ ${tax.toStringAsFixed(2)}"),
//           const SizedBox(height: 8),
//           _buildRow("Delivery Charges", "₹ ${delivery.toStringAsFixed(2)}"),
//           const Divider(color: Colors.white70),
//           _buildRow("Total Amount", "₹ ${total.toStringAsFixed(2)}",
//               isBold: true),
//         ],
//       ),
//     );
//   }

//   Widget _buildRow(String label, String value, {bool isBold = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(label,
//             style: TextStyle(
//                 color: Colors.amber,
//                 fontSize: 16,
//                 fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
//         Text(value,
//             style: TextStyle(
//                 color: Colors.amber,
//                 fontSize: 18,
//                 fontWeight: isBold ? FontWeight.bold : FontWeight.w600)),
//       ],
//     );
//   }
// }
import 'dart:convert';
import 'package:aesera_jewels/modules/address/address_screen.dart';
import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
import 'package:aesera_jewels/modules/investment_details/investment_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../Api/base_url.dart';
import '../../models/catalog_model.dart';
import '../../models/Addresses_model.dart';
import '../../services/storage_service.dart';

class CoinCatalogController extends GetxController {
  var isLoading = true.obs;
  var productList = <ProductModel>[].obs;

  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final productAmountController = TextEditingController();
  final revertAmountController = TextEditingController();
  final paidAmountController = TextEditingController();
  var selectedProduct = Rxn<ProductModel>();
  var taxPercentage = 0.0.obs;
  var deliveryCharge = 0.0.obs;

  var totalInvestment = 0.0.obs;
  var remainingAmount = 0.0.obs;
  var deductedAmount = 0.0.obs;
  var paidAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchTax();
    fetchDeliveryCharge();
    fetchTotalInvestment();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse("${BaseUrl.baseUrl}get-products"),
      );
      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body);
        productList.value = decoded
            .map((e) => ProductModel.fromJson(e))
            .toList();
      } else {
        Get.snackbar(
          "Error",
          "Failed to fetch products",
          backgroundColor: const Color(0xFF09243D),
          colorText: Colors.white,
        );
      }
    } catch (_) {
      Get.snackbar(
        "Error",
        "Please check your internet connection",
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchTax() async {
    try {
      var request = http.Request('GET', Uri.parse('${BaseUrl.baseUrl}getTax'));
      final response = await request.send();
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(await response.stream.bytesToString());
        taxPercentage.value = (jsonData["data"]["percentage"] ?? 0).toDouble();
      }
    } catch (_) {}
  }

  Future<void> fetchDeliveryCharge() async {
    try {
      var request = http.Request(
        'GET',
        Uri.parse('${BaseUrl.baseUrl}getDeliveryCharge'),
      );
      final response = await request.send();
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(await response.stream.bytesToString());
        deliveryCharge.value = (jsonData["data"]["amount"] ?? 0).toDouble();
      }
    } catch (_) {}
  }

  Future<void> fetchTotalInvestment() async {
    try {
      final mobile = await StorageService.getMobileAsync();
      if (mobile != null) {
        final headers = await StorageService().getAuthHeaders();
        final response = await http.post(
          Uri.parse("${BaseUrl.baseUrl}getpaymenthistory"),
          headers: headers,
          body: jsonEncode({"mobile": mobile}),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          totalInvestment.value = (data["totalAmount"] ?? 0).toDouble();
          remainingAmount.value = totalInvestment.value;
        }
      }
    } catch (_) {}
  }

  void showPaymentMethodDialog(ProductModel item) {
    Get.defaultDialog(
      title: "Select Payment Type",
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      radius: 12,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Choose your payment method for this purchase.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.back();
              openAddressBottomSheet(item);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 45),
              backgroundColor: const Color(0xFFFFB700),
            ),
            child: const Text(
              "Make a New Payment",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Get.back();
              openRevertPaymentBottomSheet(item);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 45),
              backgroundColor: const Color(0xFF0A2A4D),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: const Text(
                  "Deduct from the Invested Amount",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openAddressBottomSheet(ProductModel product) async {
    selectedProduct.value = product;
    productAmountController.text =
        "₹ ${product.price}   (${product.grams ?? 0} gm)";

    List<AddressModel> addresses = await _fetchUserAddresses();
    var selectedAddressIndex = 0.obs;

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          double price = product.price?.toDouble() ?? 0.0;
          double tax = (price * taxPercentage.value) / 100;
          double total = price + tax + deliveryCharge.value;

          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Details",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0D0F1C),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.close, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildPriceCard(price, tax, deliveryCharge.value, total),
                  const SizedBox(height: 16),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Select Delivery Location",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0D0F1C),
                        ),
                      ),
                    ),
                  ),
                  if (addresses.isEmpty)
                    const Text("Please add a delivery address."),
                  if (addresses.isNotEmpty)
                    ...List.generate(addresses.length, (index) {
                      final addr = addresses[index];
                      return Obx(
                        () => RadioListTile<int>(
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
                        ),
                      );
                    }),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (addresses.isEmpty) {
                          Get.back();
                          Get.to(() => AddressScreen());
                        } else {
                          final selected =
                              addresses[selectedAddressIndex.value];
                          addressController.text = selected.address ?? "";
                          cityController.text = selected.city ?? "";
                          postalCodeController.text = selected.postalCode ?? "";
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
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

  void openRevertPaymentBottomSheet(ProductModel product) async {
    selectedProduct.value = product;

    revertAmountController.text = "";
    paidAmountController.clear();

    deductedAmount.value = 0.0;
    paidAmount.value = 0.0;
    remainingAmount.value = totalInvestment.value;

    // Fetch saved addresses
    List<AddressModel> addresses = await _fetchUserAddresses();
    var selectedAddressIndex = 0.obs;

    double price = product.price.toDouble();
    double tax = (price * taxPercentage.value) / 100;
    double delivery = deliveryCharge.value;
    double totalBeforeDeduction = price + tax + delivery;

    // ✅ Controller for editable Total Investment field
    TextEditingController investmentController = TextEditingController(
      text: totalInvestment.value.toStringAsFixed(2),
    );

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return Obx(() {
            double enteredInvestment =
                double.tryParse(investmentController.text) ?? 0.0;

            // ✅ Update totalInvestment dynamically based on user input
            totalInvestment.value = enteredInvestment;

            /// ✅ Correct Final Total Calculation
            double finalTotal =
                (price + tax + delivery) - totalInvestment.value;
            if (finalTotal < 0) finalTotal = 0.0;

            // ✅ Check for insufficient balance
            bool hasInsufficientBalance =
                enteredInvestment > remainingAmount.value;

            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
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
                    /// ---------- Header ----------
                    Center(
                      child: Text(
                        "Payment Summary",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// ---------- Non-editable Fields ----------
                    _nonEditableField(
                      "Product Price",
                      "₹${price.toStringAsFixed(2)}",
                    ),
                    const SizedBox(height: 10),
                    _nonEditableField(
                      "Tax (${taxPercentage.value.toStringAsFixed(0)}%)",
                      "₹${tax.toStringAsFixed(2)}",
                    ),
                    const SizedBox(height: 10),
                    _nonEditableField(
                      "Delivery Charge",
                      "₹${deliveryCharge.value.toStringAsFixed(2)}",
                    ),
                    const SizedBox(height: 10),

                    /// ---------- Editable Total Investment ----------
                    _editableField(
                      "Total Investment",
                      investmentController,
                      onChanged: (val) => setState(() {}),
                    ),

                    /// 🔴 Warning Message if balance is insufficient
                    if (hasInsufficientBalance)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "You don’t have enough balance to complete this payment.\nYour available balance is ₹${remainingAmount.value.toStringAsFixed(2)}.",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                    const SizedBox(height: 10),

                    const Divider(height: 25, color: Colors.grey),
                    _nonEditableField(
                      "Final Total",
                      "₹${finalTotal.toStringAsFixed(2)}",
                      isBold: true,
                    ),

                    const SizedBox(height: 25),

                    /// ---------- Address Section ----------
                    Text(
                      "Select Delivery Location",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0D0F1C),
                      ),
                    ),
                    const SizedBox(height: 10),

                    if (addresses.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text("Please add a delivery address."),
                      ),

                    if (addresses.isNotEmpty)
                      ...List.generate(addresses.length, (index) {
                        final addr = addresses[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Obx(
                            () => RadioListTile<int>(
                              value: index,
                              groupValue: selectedAddressIndex.value,
                              title: Text(addr.name ?? ""),
                              subtitle: Text(
                                "${addr.address ?? ""}, ${addr.city ?? ""}",
                              ),
                              onChanged: (val) {
                                selectedAddressIndex.value = val!;
                                final selected = addresses[val];
                                addressController.text = selected.address ?? "";
                                cityController.text = selected.city ?? "";
                                postalCodeController.text =
                                    selected.postalCode ?? "";
                              },
                            ),
                          ),
                        );
                      }),

                    const SizedBox(height: 25),

                    /// ---------- Submit Button ----------
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (addresses.isEmpty) {
                            Get.back();
                            Get.to(() => AddressScreen());
                          } else {
                            final selected =
                                addresses[selectedAddressIndex.value];
                            addressController.text = selected.address ?? "";
                            cityController.text = selected.city ?? "";
                            postalCodeController.text =
                                selected.postalCode ?? "";

                            _submitRevertPayment(
                              product,
                              deductedAmount.value,
                              paidAmount.value,
                              totalBeforeDeduction,
                              finalTotal,
                              tax,
                              selected,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A2A4D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          addresses.isEmpty ? "Add Address" : "Submit",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),
                  ],
                ),
              ),
            );
          });
        },
      ),
      isScrollControlled: true,
    );
  }

  /// 🔹 Helper Widget for Non-Editable Field
  Widget _nonEditableField(String label, String value, {bool isBold = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  /// 🔹 Helper Widget for Editable Field (Total Investment)
  Widget _editableField(
    String label,
    TextEditingController controller, {
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF4F4F4),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  //   /// -----------------------------
  //   /// UPDATED: revert bottom sheet
  //   /// -----------------------------
  // void openRevertPaymentBottomSheet(ProductModel product) async {
  //   selectedProduct.value = product;
  //   revertAmountController.text = "";
  //     paidAmountController.clear();
  //   //paidAmountController.text = "";
  //   deductedAmount.value = 0.0;
  //   paidAmount.value = 0.0;
  //   remainingAmount.value = totalInvestment.value;

  //   // Fetch saved addresses
  //   List<AddressModel> addresses = await _fetchUserAddresses();
  //   var selectedAddressIndex = 0.obs;

  //   double price = product.price.toDouble();
  //   double tax = (price * taxPercentage.value) / 100;
  //   double delivery = deliveryCharge.value;
  //   double totalBeforeDeduction = price + tax + delivery;

  //   Get.bottomSheet(
  //     StatefulBuilder(
  //       builder: (context, setState) {
  //         return Obx(() {
  //           double deduct = double.tryParse(revertAmountController.text) ?? 0.0;
  //           deductedAmount.value = deduct.clamp(0.0, totalInvestment.value);

  //           // Paid amount is automatically = (price - totalInvestment) + tax + delivery (if > 0)
  //           double autoPaid = (price - totalInvestment.value) + tax + delivery;
  //           double userPaid = double.tryParse(paidAmountController.text) ?? autoPaid;
  //           paidAmount.value = userPaid;

  //           // double finalTotal = totalBeforeDeduction - deductedAmount.value;
  //           // if (finalTotal < 0) finalTotal = 0.0;
  //       double finalTotal = price + tax + deliveryCharge.value - deductedAmount.value;
  //        if (finalTotal < 0) finalTotal = 0.0;

  //           return SingleChildScrollView(
  //             padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
  //             child: Container(
  //               padding: const EdgeInsets.all(20),
  //               decoration: const BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
  //               ),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Center(
  //                     child: Text(
  //                       "Revert Payment",
  //                       style: GoogleFonts.plusJakartaSans(
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.w700,
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 20),

  //                   /// Price Summary Card
  //                   Card(
  //                     color: const Color(0xFF0A2A4D),
  //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(14),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           _priceRow("Product Price", "₹${price.toStringAsFixed(2)}"),
  //                           _priceRow("Tax (${taxPercentage.value.toStringAsFixed(0)}%)", "₹${tax.toStringAsFixed(2)}"),
  //                            _priceRow("Delivery", "₹${deliveryCharge.value.toStringAsFixed(2)}"),
  // //                          _priceRow("Delivery", "₹${delivery.toStringAsFixed(2)}"),
  //                           const Divider(color: Colors.white54),
  //                           // _priceRow("Total (before deduction)", "₹${totalBeforeDeduction.toStringAsFixed(2)}"),
  //                           // const SizedBox(height: 10),
  //                           _priceRow("Total Investment", "₹${totalInvestment.value.toStringAsFixed(2)}"),
  //                           _priceRow("Deducted Amount", "₹${deductedAmount.value.toStringAsFixed(2)}"),
  //                           _priceRow("Paid Now", "₹${paidAmount.value.toStringAsFixed(2)}"),
  //                           const Divider(color: Colors.white54),
  //                           _priceRow("Final Total", "₹${finalTotal.toStringAsFixed(2)}", isBold: true),
  //                         ],
  //                       ),
  //                     ),
  //                   ),

  //                   const SizedBox(height: 16),

  //                   /// Deduct Amount Field
  //                   TextField(
  //                     controller: revertAmountController,
  //                     keyboardType: TextInputType.number,
  //                     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  //                     decoration: InputDecoration(
  //                       labelText: "Total Investment",
  //                       prefixText: "₹ ${totalInvestment.value.toStringAsFixed(2)} ",
  //                       border: const OutlineInputBorder(),
  //                     ),
  //                     onChanged: (val) => setState(() {}),
  //                   ),

  //                   const SizedBox(height: 12),

  //                   /// Paid Amount Field
  //                   TextField(
  //                     controller: paidAmountController,
  //                     keyboardType: TextInputType.number,
  //                     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  //                     decoration: InputDecoration(
  //                       labelText: " Pay Now",
  //                       prefixText: "₹ ${paidAmount.value.toStringAsFixed(2)} ",
  //                       border: const OutlineInputBorder(),
  //                     ),
  //                     onChanged: (val) {
  //                           setState(() {});
  //                         },
  //                       ),
  //                    // onChanged: (val) => setState(() {}),
  //                   // ),

  //                   const SizedBox(height: 20),

  //                   Text(
  //                     "Select Delivery Location",
  //                     style: GoogleFonts.plusJakartaSans(
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.w600,
  //                       color: const Color(0xFF0D0F1C),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 8),

  //                   if (addresses.isEmpty)
  //                     const Text("Please add a delivery address."),
  //                   if (addresses.isNotEmpty)
  //                     ...List.generate(addresses.length, (index) {
  //                       final addr = addresses[index];
  //                       return Obx(() => RadioListTile<int>(
  //                             value: index,
  //                             groupValue: selectedAddressIndex.value,
  //                             title: Text(addr.name ?? ""),
  //                             subtitle: Text("${addr.address ?? ""}, ${addr.city ?? ""}"),
  //                             onChanged: (val) {
  //                               selectedAddressIndex.value = val!;
  //                               final selected = addresses[val];
  //                               addressController.text = selected.address ?? "";
  //                               cityController.text = selected.city ?? "";
  //                               postalCodeController.text = selected.postalCode ?? "";
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
  //                           Get.back();
  //                           Get.to(() => AddressScreen());
  //                         } else {
  //                           final selected = addresses[selectedAddressIndex.value];
  //                           addressController.text = selected.address ?? "";
  //                           cityController.text = selected.city ?? "";
  //                           postalCodeController.text = selected.postalCode ?? "";

  //                           if (paidAmount.value <= 0 && deductedAmount.value <= 0) {
  //                             Get.snackbar("Validation", "Enter valid amount to deduct or pay",
  //                                 backgroundColor: Colors.red, colorText: Colors.white);
  //                             return;
  //                           }

  //                           _submitRevertPayment(
  //                             product,
  //                             deductedAmount.value,
  //                             paidAmount.value,
  //                             totalBeforeDeduction,
  //                             finalTotal,
  //                             tax,
  //                             selected,
  //                           );
  //                         }
  //                       },
  //                       style: ElevatedButton.styleFrom(
  //                         backgroundColor: const Color(0xFF0A2A4D),
  //                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
  //         });
  //       },
  //     ),
  //     isScrollControlled: true,
  //   );
  // }

  /// Final Revert Payment API Call
  Future<void> _submitRevertPayment(
    ProductModel product,
    double deduct,
    double paidNow,
    double totalBeforeDeduction,
    double finalTotal,
    double tax,
    AddressModel address,
  ) async {
    try {
      final mobile = await StorageService.getMobileAsync() ?? "Unknown";

      final body = {
        "mobileNumber": mobile,
        "tagid": product.tagId,
        "goldType": product.goldtype,
        "description": product.description,
        "amount": product.price,
        "grams": product.grams ?? 0,
        "Paidamount": paidNow,
        "Paidgrams": 0,
        "deductAmount": deduct,
        "totalBeforeDeduction": totalBeforeDeduction,
        "finalTotal": finalTotal,
        "tax": tax,
        "deliveryCharge": deliveryCharge.value,
        "address": address.address ?? "",
        "city": address.city ?? "",
        "postCode": address.postalCode ?? "",
      };

      final headers = {'Content-Type': 'application/json'};
      final response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}catalogPayment"),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        Get.back();
        Get.offAll(() => DashboardScreen());
        Get.snackbar(
          "Success",
          data["message"] ?? "Payment successful",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          "Failed: ${response.statusCode}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Please check your internet connection",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // void openRevertPaymentBottomSheet(ProductModel product) async {
  //   selectedProduct.value = product;
  //   revertAmountController.text = "";
  //   remainingAmount.value = totalInvestment.value;
  //   paidAmountController.clear();
  //   deductedAmount.value = 0;
  //   paidAmount.value = 0;

  //   // prepare addresses and indices
  //   List<AddressModel> addresses = await _fetchUserAddresses();
  //   var selectedAddressIndex = 0.obs;

  //   double price = product.price?.toDouble() ?? 0.0;
  //   double tax = (price * taxPercentage.value) / 100;
  //   double total = price + tax + deliveryCharge.value;

  //   Get.bottomSheet(
  //     StatefulBuilder(
  //       builder: (context, setState) {
  //         return Obx(() {
  //           // parse values live from controllers
  //           double deduct = double.tryParse(revertAmountController.text) ?? 0.0;
  //           deductedAmount.value = deduct.clamp(0.0, totalInvestment.value);
  //           remainingAmount.value = (totalInvestment.value - deductedAmount.value)
  //               .clamp(0.0, double.infinity);

  //           double paidNow =
  //               double.tryParse(paidAmountController.text) ?? 0.0;
  //           paidAmount.value = paidNow;

  //           double finalTotal = price + tax + deliveryCharge.value - deductedAmount.value;
  //           if (finalTotal < 0) finalTotal = 0.0;

  //           return SingleChildScrollView(
  //             padding:
  //                 EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
  //             child: Container(
  //               padding: const EdgeInsets.all(20),
  //               decoration: const BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Center(
  //                       child: Text(
  //                         "Deduct  from  the Invested  Amount",
  //                         textAlign: TextAlign.center,
  //                         style: GoogleFonts.plusJakartaSans(
  //                             fontSize: 20, fontWeight: FontWeight.bold),
  //                       ),
  //                     ),
  //                     const SizedBox(height: 20),

  //                     /// Single card: product price, tax, delivery, total, deducted, paid, final total
  //                     Card(
  //                       color: const Color(0xFF0A2A4D),
  //                       shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(12)),
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(14),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             _priceRow("Product Price", "₹${price.toStringAsFixed(2)}"),
  //                             _priceRow("Tax (${taxPercentage.value.toStringAsFixed(0)}%)",
  //                                 "₹${tax.toStringAsFixed(2)}"),
  //                             _priceRow("Delivery", "₹${deliveryCharge.value.toStringAsFixed(2)}"),
  //                             const Divider(color: Colors.white54),
  //                             _priceRow("Total (before deduction)",
  //                                 "₹${(price + tax + deliveryCharge.value).toStringAsFixed(2)}"),
  //                             const SizedBox(height: 10),
  //                             _priceRow("Deducted Amount", "₹${deductedAmount.value.toStringAsFixed(2)}"),
  //                             _priceRow("Paid Now", "₹${paidAmount.value.toStringAsFixed(2)}"),
  //                             const Divider(color: Colors.white54),
  //                             _priceRow("Final Total",
  //                                 "₹${finalTotal.toStringAsFixed(2)}",
  //                                 isBold: true),
  //                           ],
  //                         ),
  //                       ),
  //                     ),

  //                     const SizedBox(height: 16),

  //                     // Deduct amount input (editable)
  //                     TextField(
  //                       controller: revertAmountController,
  //                       keyboardType: TextInputType.number,
  //                       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  //                       decoration: const InputDecoration(
  //                         labelText: "Amount to Deduct from Investment",
  //                         prefixText: "₹ ",
  //                         border: UnderlineInputBorder(),
  //                       ),
  //                       onChanged: (val) {
  //                         // just trigger Obx update by calling setState via StatefulBuilder
  //                         setState(() {});
  //                       },
  //                     ),

  //                     const SizedBox(height: 12),

  //                     // Paid amount input (editable)
  //                     TextField(
  //                       controller: paidAmountController,
  //                       keyboardType: TextInputType.number,
  //                       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  //                       decoration: const InputDecoration(
  //                         labelText: "Amount You Are Going to Pay Now",
  //                         prefixText: "₹ ",
  //                         border: UnderlineInputBorder(),
  //                       ),
  //                       onChanged: (val) {
  //                         setState(() {});
  //                       },
  //                     ),

  //                     const SizedBox(height: 16),

  //                     // Investment summary card
  //                     Container(
  //                       width: double.infinity,
  //                       padding: const EdgeInsets.all(12),
  //                       decoration: BoxDecoration(
  //                         color: const Color(0xFF0A2A4D),
  //                         borderRadius: BorderRadius.circular(12),
  //                       ),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           _priceRow("Total Investment",
  //                               "₹${totalInvestment.value.toStringAsFixed(2)}"),
  //                           _priceRow("Deducted", "₹${deductedAmount.value.toStringAsFixed(2)}"),
  //                           _priceRow("Remaining", "₹${remainingAmount.value.toStringAsFixed(2)}",
  //                               isBold: true),
  //                         ],
  //                       ),
  //                     ),

  //                     const SizedBox(height: 20),

  //                     Center(
  //                       child: Text("Select Delivery Location",
  //                           style: GoogleFonts.plusJakartaSans(
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.w600,
  //                             color: const Color(0xFF0D0F1C),
  //                           )),
  //                     ),

  //                     const SizedBox(height: 8),

  //                     if (addresses.isEmpty) const Text("Please add a delivery address."),
  //                     if (addresses.isNotEmpty)
  //                       ...List.generate(addresses.length, (index) {
  //                         final addr = addresses[index];
  //                         return Obx(() => RadioListTile<int>(
  //                               value: index,
  //                               groupValue: selectedAddressIndex.value,
  //                               title: Text(addr.name ?? ""),
  //                               subtitle: Text("${addr.address ?? ""}, ${addr.city ?? ""}"),
  //                               onChanged: (val) {
  //                                 selectedAddressIndex.value = val!;
  //                                 final selected = addresses[val];
  //                                 addressController.text = selected.address ?? "";
  //                                 cityController.text = selected.city ?? "";
  //                                 postalCodeController.text =
  //                                     selected.postalCode ?? "";
  //                               },
  //                             ));
  //                       }),

  //                     const SizedBox(height: 24),

  //                     SizedBox(
  //                       width: double.infinity,
  //                       height: 48,
  //                       child: ElevatedButton(
  //                         onPressed: () {
  //                           if (addresses.isEmpty) {
  //                             Get.back();
  //                             Get.to(() => AddressScreen());
  //                           } else {
  //                             final selected = addresses[selectedAddressIndex.value];
  //                             addressController.text = selected.address ?? "";
  //                             cityController.text = selected.city ?? "";
  //                             postalCodeController.text = selected.postalCode ?? "";

  //                             // validate before calling API
  //                             double deductToSend = deductedAmount.value;
  //                             double paidToSend = paidAmount.value;
  //                             if (deductToSend <= 0 && paidToSend <= 0) {
  //                               Get.snackbar("Validation", "Enter paid or deducted amount",
  //                                   backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
  //                               return;
  //                             }

  //                             // call submit with prepared params
  //                             _submitRevertPayment(
  //                               product,
  //                               deductToSend,
  //                               paidToSend,
  //                               selected,
  //                             );
  //                           }
  //                         },
  //                         style: ElevatedButton.styleFrom(
  //                           backgroundColor: const Color(0xFF0A2A4D),
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(25),
  //                           ),
  //                         ),
  //                         child: const Text(
  //                           "Submit",
  //                           style: TextStyle(color: Colors.white, fontSize: 18),
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(height: 12),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         });
  //       },
  //     ),
  //     isScrollControlled: true,
  //   );
  // }

  // // Consolidated submit for revert (calls the same catalogPayment API with extra fields)
  // Future<void> _submitRevertPayment(
  //     ProductModel product, double deduct, double paidNow, AddressModel address) async {
  //   try {
  //     final mobile = await StorageService.getMobileAsync() ?? "Unknown";

  //     final body = {
  //       "mobileNumber": mobile,
  //       "tagid": product.tagId,
  //       "goldType": product.goldtype,
  //       "description": product.description,
  //       "amount": product.price,
  //       "grams": product.grams ?? 0,
  //       "Paidamount": paidNow,
  //       "Paidgrams": 0,
  //       "deductAmount": deduct,
  //       // include address fields
  //       "address": address.address ?? "",
  //       "city": address.city ?? "",
  //       "postCode": address.postalCode ?? "",
  //       // optionally include tax & delivery for backend clarity:
  //       "tax": (product.price != null) ? ((product.price! * taxPercentage.value) / 100) : 0,
  //       "deliveryCharge": deliveryCharge.value,
  //     };

  //     final headers = {'Content-Type': 'application/json'};
  //     final response = await http.post(
  //       Uri.parse("${BaseUrl.baseUrl}catalogPayment"),
  //       headers: headers,
  //       body: jsonEncode(body),
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final data = jsonDecode(response.body);
  //       Get.back();
  //       Get.offAll(() => DashboardScreen());
  //       Get.snackbar("Success", data["message"] ?? "Payment successful",
  //           backgroundColor: Colors.green, colorText: Colors.white);
  //     } else {
  //       Get.snackbar("Error", "Failed to submit: ${response.statusCode}",
  //           backgroundColor: Colors.red, colorText: Colors.white);
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Please check your internet connection",
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   }
  // }

  Future<List<AddressModel>> _fetchUserAddresses() async {
    List<AddressModel> addresses = [];
    try {
      final userId = await StorageService.getUserId();
      if (userId != null) {
        final headers = await StorageService().getAuthHeaders();
        final uri = Uri.parse("${BaseUrl.baseUrl}getDeliveryAddress");
        final body = json.encode({"userid": userId});
        final response = await http.post(uri, headers: headers, body: body);
        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          if (jsonData["status"] == "true") {
            final List data = jsonData["data"];
            addresses = data.map((e) => AddressModel.fromJson(e)).toList();
          }
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Please check your internet connection",
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white,
      );
    }
    return addresses;
  }

  Future<void> submitCatalogPayment() async {
    final product = selectedProduct.value;
    if (product == null) return;

    final address = addressController.text.trim();
    final city = cityController.text.trim();
    final postal = postalCodeController.text.trim();

    if (address.isEmpty || city.isEmpty || postal.isEmpty) {
      Get.snackbar(
        "Validation",
        "Please select a delivery address",
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white,
      );
      return;
    }

    final mobile = await StorageService.getMobileAsync() ?? "Unknown";

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
        Uri.parse('${BaseUrl.baseUrl}catalogPayment'),
      );
      request.body = json.encode(body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        Get.snackbar(
          "Success",
          "Catalog Payment Created Successfully",
          backgroundColor: const Color(0xFF09243D),
          colorText: Colors.white,
        );
        Get.offAll(() => DashboardScreen());
      } else {
        Get.snackbar(
          "Error",
          response.reasonPhrase ?? "Failed",
          backgroundColor: const Color(0xFF09243D),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Please check your internet connection",
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white,
      );
    }
  }

  Future<void> submitRevertPayment_old() async {
    // kept only for backward compatibility if you were using this signature elsewhere.
    // The new handler is _submitRevertPayment above, called from the bottom-sheet Submit.
  }

  Future<void> _submitPaymentAPI(Map<String, dynamic> body) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}catalogPayment"),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json["status"] == "true") {
          Get.back();
          Get.offAll(() => DashboardScreen());
          Get.snackbar(
            "Success",
            json["message"] ?? "Payment successful",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Please check your internet connection",
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white,
      );
    }
  }

  Widget _buildPriceCard(
    double price,
    double tax,
    double delivery,
    double total,
  ) {
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
          _buildRow(
            "Tax (${taxPercentage.value.toStringAsFixed(0)}%)",
            "₹ ${tax.toStringAsFixed(2)}",
          ),
          const SizedBox(height: 8),
          _buildRow("Delivery Charges", "₹ ${delivery.toStringAsFixed(2)}"),
          const Divider(color: Colors.white70),
          _buildRow(
            "Total Amount",
            "₹ ${total.toStringAsFixed(2)}",
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceCardAlt(
    double price,
    double tax,
    double delivery,
    double total,
  ) {
    return Card(
      color: const Color(0xFFFFF4D9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _priceRow("Product Price", "₹${price.toStringAsFixed(2)}"),
            if (tax > 0) _priceRow("Tax", "₹${tax.toStringAsFixed(2)}"),
            if (delivery > 0)
              _priceRow("Delivery", "₹${delivery.toStringAsFixed(2)}"),
            const Divider(),
            _priceRow("Total", "₹${total.toStringAsFixed(2)}", isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.amber,
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.amber,
            fontSize: 18,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _priceRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.amber,
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
