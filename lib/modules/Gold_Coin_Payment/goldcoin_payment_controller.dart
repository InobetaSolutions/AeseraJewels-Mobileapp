

// // import 'dart:convert';
// // import 'package:aesera_jewels/Api/base_url.dart';
// // import 'package:aesera_jewels/models/Addresses_model.dart';
// // import 'package:aesera_jewels/models/catalog_model.dart';
// // import 'package:aesera_jewels/modules/address/address_screen.dart';
// // import 'package:aesera_jewels/modules/coin_catalog/coin_catalog_controller.dart';
// // import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
// // import 'package:aesera_jewels/services/storage_service.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:http/http.dart' as http;

// // class GoldCoinPaymentController extends GetxController {
// //   var goldRate = 0.0.obs;
// //   var taxPercent = 0.0.obs;
// //   var deliveryCharge = 0.0.obs;
// //   var isLoading = false.obs;
// //   var addressesList = <AddressModel>[].obs;

// //   final addressController = TextEditingController();
// //   final cityController = TextEditingController();
// //   final postalCodeController = TextEditingController();
  
// //   var selectedCoins = <Map<String, dynamic>>[].obs;
// //   var totalInvestment = 0.0.obs;

// //   // Dynamic calculation observables
// //   var subtotalAmount = 0.0.obs;
// //   var taxAmount = 0.0.obs;
// //   var totalPayable = 0.0.obs;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchAPIs();
// //     fetchTotalInvestment();
// //     fetchUserAddresses();
// //   }

// //   void setSelectedCoins(List<Map<String, dynamic>> coins) {
// //     selectedCoins.value = coins;
// //     calculateDynamicValues();
// //   }

// //   void calculateDynamicValues() {
// //     // Calculate subtotal from selected coins with precise calculation
// //     double subtotal = 0;
// //     for (var coin in selectedCoins) {
// //       final weight = coin["weight"] ?? 0.0;
// //       final pieces = coin["pieces"] ?? 0;
// //       final grams = weight * pieces;
// //       subtotal += grams * goldRate.value;
// //     }
    
// //     // Use precise calculations to avoid floating point errors
// //     subtotalAmount.value = _roundToTwoDecimals(subtotal);
// //     taxAmount.value = _roundToTwoDecimals((subtotal * taxPercent.value) / 100);
// //     totalPayable.value = _roundToTwoDecimals(subtotalAmount.value + taxAmount.value + deliveryCharge.value);
// //     update();
// //   }

// //   // Helper method to round to 2 decimal places and avoid floating point precision issues
// //   double _roundToTwoDecimals(double value) {
// //     return double.parse(value.toStringAsFixed(2));
// //   }

// //   // Helper method to ensure integer values for API (remove decimals)
// //   int _toIntValue(double value) {
// //     return value.round();
// //   }

// //   Future<void> fetchAPIs() async {
// //     await Future.wait([_fetchGoldRate(), _fetchTax(), _fetchDelivery()]);
// //   }

// //   Future<void> _fetchGoldRate() async {
// //     try {
// //       final res = await http.get(Uri.parse('${BaseUrl.baseUrl}getCurrentRate'));
// //       if (res.statusCode == 200) {
// //         final data = jsonDecode(res.body);
// //         goldRate.value = (data["price_gram_24k"] ?? 0).toDouble();
// //         calculateDynamicValues();
// //       }
// //     } catch (e) {
// //       print("Error fetching gold rate: $e");
// //     }
// //   }

// //   Future<void> _fetchTax() async {
// //     try {
// //       final res = await http.get(Uri.parse('${BaseUrl.baseUrl}getTax'));
// //       if (res.statusCode == 200) {
// //         final data = jsonDecode(res.body);
// //         if (data["status"] == true) {
// //           taxPercent.value = (data["data"]["percentage"] ?? 0).toDouble();
// //           calculateDynamicValues();
// //         }
// //       }
// //     } catch (e) {
// //       print("Error fetching tax: $e");
// //     }
// //   }

// //   Future<void> _fetchDelivery() async {
// //     try {
// //       final res = await http.get(Uri.parse('${BaseUrl.baseUrl}getDeliveryCharge'));
// //       if (res.statusCode == 200) {
// //         final data = jsonDecode(res.body);
// //         if (data["status"] == true) {
// //           deliveryCharge.value = (data["data"]["amount"] ?? 0).toDouble();
// //           calculateDynamicValues();
// //         }
// //       }
// //     } catch (e) {
// //       print("Error fetching delivery charge: $e");
// //     }
// //   }

// //   Future<void> fetchTotalInvestment() async {
// //     try {
// //       final mobile = await StorageService.getMobileAsync();
// //       if (mobile != null) {
// //         final headers = await StorageService().getAuthHeaders();
// //         final response = await http.post(
// //           Uri.parse("${BaseUrl.baseUrl}getpaymenthistory"),
// //           headers: headers,
// //           body: jsonEncode({"mobile": mobile}),
// //         );
// //         if (response.statusCode == 200) {
// //           final data = jsonDecode(response.body);
// //           totalInvestment.value = (data["totalAmount"] ?? 0).toDouble();
// //         }
// //       }
// //     } catch (e) {
// //       print("Error fetching total investment: $e");
// //     }
// //   }

// //   Future<void> fetchUserAddresses() async {
// //     try {
// //       final userId = await StorageService.getUserId();
// //       if (userId != null) {
// //         final headers = await StorageService().getAuthHeaders();
// //         final uri = Uri.parse("${BaseUrl.baseUrl}getDeliveryAddress");
// //         final body = json.encode({"userid": userId});
// //         final response = await http.post(uri, headers: headers, body: body);
// //         if (response.statusCode == 200) {
// //           final jsonData = jsonDecode(response.body);
// //           if (jsonData["status"] == "true") {
// //             final List data = jsonData["data"];
// //             addressesList.value = data.map((e) => AddressModel.fromJson(e)).toList();
// //           } else {
// //             addressesList.value = [];
// //           }
// //         } else {
// //           addressesList.value = [];
// //         }
// //       }
// //     } catch (e) {
// //       addressesList.value = [];
// //       print("Error fetching addresses: $e");
// //     }
// //   }

// //   void showPaymentMethodDialog() {
// //     Get.defaultDialog(
// //       title: "Select Payment Type",
// //       titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
// //       contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// //       radius: 12,
// //       content: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           const Text(
// //             "Choose your payment method for this purchase.",
// //             textAlign: TextAlign.center,
// //           ),
// //           const SizedBox(height: 20),
// //           ElevatedButton(
// //             onPressed: () {
// //               Get.back();
// //               openAddressBottomSheet();
// //             },
// //             style: ElevatedButton.styleFrom(
// //               minimumSize: const Size(double.infinity, 45),
// //               backgroundColor: const Color(0xFFFFB700),
// //             ),
// //             child: const Text(
// //               "Make a New Payment",
// //               style: TextStyle(color: Colors.black, fontSize: 15),
// //             ),
// //           ),
// //           const SizedBox(height: 10),
// //           ElevatedButton(
// //             onPressed: () {
// //               Get.back();
// //               openRevertPaymentBottomSheet();
// //             },
// //             style: ElevatedButton.styleFrom(
// //               minimumSize: const Size(double.infinity, 45),
// //               backgroundColor: const Color(0xFF0A2A4D),
// //             ),
// //             child: const Padding(
// //               padding: EdgeInsets.all(8.0),
// //               child: Center(
// //                 child: Text(
// //                   "Deduct from the Invested Amount",
// //                   textAlign: TextAlign.center,
// //                   style: TextStyle(color: Colors.white, fontSize: 15),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void openAddressBottomSheet() async {
// //     await fetchUserAddresses();
// //     var selectedAddressIndex = 0.obs;

// //     Get.bottomSheet(
// //       StatefulBuilder(
// //         builder: (context, setState) {
// //           return SingleChildScrollView(
// //             padding: EdgeInsets.only(
// //               bottom: MediaQuery.of(context).viewInsets.bottom,
// //             ),
// //             child: Container(
// //               padding: const EdgeInsets.all(20),
// //               decoration: const BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
// //               ),
// //               child: Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Text(
// //                         "Order Details",
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
                  
// //                   // Price Card for New Payment (Investment Amount = 0)
// //                   Obx(() => _buildPriceCardForNewPayment()),
                  
// //                   const SizedBox(height: 16),
// //                   Center(
// //                     child: Padding(
// //                       padding: const EdgeInsets.symmetric(vertical: 20),
// //                       child: Text(
// //                         "Select Delivery Location",
// //                         style: GoogleFonts.plusJakartaSans(
// //                           fontSize: 22,
// //                           fontWeight: FontWeight.w700,
// //                           color: const Color(0xFF0D0F1C),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
                  
// //                   Obx(() {
// //                     if (addressesList.isEmpty) {
// //                       return const Padding(
// //                         padding: EdgeInsets.symmetric(vertical: 20),
// //                         child: Text(
// //                           "No addresses found. Please add a delivery address.",
// //                           textAlign: TextAlign.center,
// //                           style: TextStyle(color: Colors.grey),
// //                         ),
// //                       );
// //                     }
                    
// //                     return Column(
// //                       children: List.generate(addressesList.length, (index) {
// //                         final addr = addressesList[index];
// //                         return Obx(
// //                           () => RadioListTile<int>(
// //                             value: index,
// //                             groupValue: selectedAddressIndex.value,
// //                             title: Text(addr.name ?? ""),
// //                             subtitle: Text("${addr.address ?? ""}, ${addr.city ?? ""}"),
// //                             onChanged: (val) {
// //                               selectedAddressIndex.value = val!;
// //                               final selected = addressesList[val];
// //                               addressController.text = selected.address ?? "";
// //                               cityController.text = selected.city ?? "";
// //                               postalCodeController.text = selected.postalCode ?? "";
// //                             },
// //                           ),
// //                         );
// //                       }),
// //                     );
// //                   }),
                  
// //                   const SizedBox(height: 24),
// //                   SizedBox(
// //                     width: double.infinity,
// //                     height: 48,
// //                     child: ElevatedButton(
// //                       onPressed: () {
// //                         if (addressesList.isEmpty) {
// //                           Get.back();
// //                           Get.to(() => AddressScreen());
// //                         } else {
// //                           final selected = addressesList[selectedAddressIndex.value];
// //                           addressController.text = selected.address ?? "";
// //                           cityController.text = selected.city ?? "";
// //                           postalCodeController.text = selected.postalCode ?? "";
// //                           submitCatalogPayment(0.0); // Investment Amount = 0 for new payment
// //                         }
// //                       },
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: const Color(0xFF09243D),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(25),
// //                         ),
// //                       ),
// //                       child: Text(
// //                         addressesList.isEmpty ? "Add Address" : "Pay",
// //                         style: const TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 18,
// //                         ),
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

// //   void openRevertPaymentBottomSheet() async {
// //     await fetchUserAddresses();
// //     await fetchTotalInvestment();
    
// //     var selectedAddressIndex = 0.obs;
// //     var investmentController = TextEditingController(
// //       text: totalInvestment.value.toStringAsFixed(2),
// //     );

// //     Get.bottomSheet(
// //       StatefulBuilder(
// //         builder: (context, setState) {
// //           return Obx(() {
// //             double investmentUsed = double.tryParse(investmentController.text) ?? 0.0;
// //             bool hasInsufficientBalance = investmentUsed > totalInvestment.value;

// //             return SingleChildScrollView(
// //               padding: EdgeInsets.only(
// //                 bottom: MediaQuery.of(context).viewInsets.bottom,
// //               ),
// //               child: Container(
// //                 padding: const EdgeInsets.all(20),
// //                 decoration: const BoxDecoration(
// //                   color: Colors.white,
// //                   borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
// //                 ),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     Center(
// //                       child: Text(
// //                         "Payment Summary",
// //                         style: GoogleFonts.plusJakartaSans(
// //                           fontSize: 20,
// //                           fontWeight: FontWeight.w700,
// //                         ),
// //                       ),
// //                     ),
// //                     const SizedBox(height: 15),

// //                     // Price Card for Revert Payment (With Investment Amount)
// //                     Obx(() => _buildPriceCardForRevertPayment(investmentUsed)),

// //                     const SizedBox(height: 10),

// //                     // Investment Amount Field
// //                     _editableField(
// //                       "Investment Amount to Use",
// //                       investmentController,
// //                       keyboardType: TextInputType.numberWithOptions(decimal: true),
// //                       onChanged: (val) {
// //                         setState(() {});
// //                       },
// //                     ),

// //                     if (hasInsufficientBalance)
// //                       Padding(
// //                         padding: const EdgeInsets.only(top: 8),
// //                         child: Text(
// //                           "You don't have enough balance. Available: ₹${totalInvestment.value.toStringAsFixed(2)}",
// //                           style: const TextStyle(color: Colors.red, fontSize: 13),
// //                         ),
// //                       ),

// //                     const SizedBox(height: 15),

// //                     Text(
// //                       "Select Delivery Location",
// //                       style: GoogleFonts.plusJakartaSans(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.w600,
// //                         color: const Color(0xFF0D0F1C),
// //                       ),
// //                     ),
// //                     const SizedBox(height: 10),

// //                     Obx(() {
// //                       if (addressesList.isEmpty) {
// //                         return const Padding(
// //                           padding: EdgeInsets.symmetric(vertical: 10),
// //                           child: Text("Please add a delivery address."),
// //                         );
// //                       }

// //                       return Column(
// //                         children: List.generate(addressesList.length, (index) {
// //                           final addr = addressesList[index];
// //                           return Padding(
// //                             padding: const EdgeInsets.only(bottom: 8),
// //                             child: Obx(
// //                               () => RadioListTile<int>(
// //                                 value: index,
// //                                 groupValue: selectedAddressIndex.value,
// //                                 title: Text(addr.name ?? ""),
// //                                 subtitle: Text("${addr.address ?? ""}, ${addr.city ?? ""}"),
// //                                 onChanged: (val) {
// //                                   selectedAddressIndex.value = val!;
// //                                   final selected = addressesList[val];
// //                                   addressController.text = selected.address ?? "";
// //                                   cityController.text = selected.city ?? "";
// //                                   postalCodeController.text = selected.postalCode ?? "";
// //                                 },
// //                               ),
// //                             ),
// //                           );
// //                         }),
// //                       );
// //                     }),

// //                     const SizedBox(height: 10),

// //                     SizedBox(
// //                       width: double.infinity,
// //                       height: 48,
// //                       child: ElevatedButton(
// //                         onPressed: hasInsufficientBalance ? null : () {
// //                           if (addressesList.isEmpty) {
// //                             Get.back();
// //                             Get.to(() => AddressScreen());
// //                           } else {
// //                             final selected = addressesList[selectedAddressIndex.value];
// //                             addressController.text = selected.address ?? "";
// //                             cityController.text = selected.city ?? "";
// //                             postalCodeController.text = selected.postalCode ?? "";
                            
// //                             double investmentUsed = double.tryParse(investmentController.text) ?? 0.0;
// //                             submitCatalogPayment(investmentUsed);
// //                           }
// //                         },
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: hasInsufficientBalance ? Colors.grey : const Color(0xFF0A2A4D),
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(25),
// //                           ),
// //                         ),
// //                         child: Text(
// //                           addressesList.isEmpty ? "Add Address" : "Pay",
// //                           style: const TextStyle(color: Colors.white, fontSize: 18),
// //                         ),
// //                       ),
// //                     ),
// //                     const SizedBox(height: 10),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           });
// //         },
// //       ),
// //       isScrollControlled: true,
// //     );
// //   }

// //   Future<void> submitCatalogPayment(double investmentAmount) async {
// //     try {
// //       isLoading(true);

// //       final mobile = await StorageService.getMobileAsync() ?? "Unknown";
// //       final address = addressController.text.trim();
// //       final city = cityController.text.trim();
// //       final postalCode = postalCodeController.text.trim();

// //       if (address.isEmpty || city.isEmpty || postalCode.isEmpty) {
// //         Get.snackbar("Error", "Please select a delivery address", 
// //           backgroundColor: Colors.red, colorText: Colors.white);
// //         isLoading(false);
// //         return;
// //       }

// //       // Prepare items list from selected coins
// //       List<Map<String, dynamic>> items = selectedCoins.map((coin) {
// //         final weight = coin["weight"] ?? 0.0;
// //         final pieces = coin["pieces"] ?? 0;
// //         final grams = weight * pieces;
// //         final amount = grams * goldRate.value;
        
// //         return {
// //           "coinGrams": weight,
// //           "quantity": pieces,
// //           "amount": _toIntValue(amount), // Use integer values
// //         };
// //       }).toList();

// //       // Calculate amounts with precise rounding to avoid floating point errors
// //       double calculatedTotalAmount = _roundToTwoDecimals(subtotalAmount.value);
// //       double calculatedTaxAmount = _roundToTwoDecimals(taxAmount.value);
// //       double calculatedDeliveryCharge = _roundToTwoDecimals(deliveryCharge.value);
      
// //       // CRITICAL FIX: Ensure amountPayable exactly equals the sum
// //       double calculatedAmountPayable = _roundToTwoDecimals(
// //         calculatedTotalAmount + calculatedTaxAmount + calculatedDeliveryCharge
// //       );

// //       // Verify the calculation matches exactly
// //       double sumCheck = calculatedTotalAmount + calculatedTaxAmount + calculatedDeliveryCharge;
// //       if (_roundToTwoDecimals(calculatedAmountPayable) != _roundToTwoDecimals(sumCheck)) {
// //         print("WARNING: Amount mismatch! calculatedAmountPayable: $calculatedAmountPayable, sum: $sumCheck");
// //         // Force them to be equal
// //         calculatedAmountPayable = _roundToTwoDecimals(sumCheck);
// //       }

// //       // Prepare request body matching API requirements exactly
// //       final body = {
// //         "mobileNumber": mobile,
// //         "items": items,
// //         "totalAmount": _toIntValue(calculatedTotalAmount),
// //         "taxAmount": _toIntValue(calculatedTaxAmount),
// //         "deliveryCharge": _toIntValue(calculatedDeliveryCharge),
// //         "amountPayable": _toIntValue(calculatedAmountPayable), // This must equal totalAmount + taxAmount + deliveryCharge
// //         "investAmount": _toIntValue(investmentAmount), // Include investAmount as required by API
// //         "address": address,
// //         "city": city,
// //         "postCode": postalCode,
// //       };

// //       // Final verification before sending
// //       final totalSum = _toIntValue(calculatedTotalAmount) + _toIntValue(calculatedTaxAmount) + _toIntValue(calculatedDeliveryCharge);
// //       final amountPayableValue = _toIntValue(calculatedAmountPayable);
      
// //       if (totalSum != amountPayableValue) {
// //         print("CRITICAL ERROR: amountPayable validation failed!");
// //         print("totalSum: $totalSum, amountPayable: $amountPayableValue");
// //         // Force correction
// //         body["amountPayable"] = totalSum;
// //       }

// //       print("Submitting payment: ${jsonEncode(body)}");
// //       print("Verification - totalAmount + taxAmount + deliveryCharge = ${_toIntValue(calculatedTotalAmount) + _toIntValue(calculatedTaxAmount) + _toIntValue(calculatedDeliveryCharge)}");
// //       print("Verification - amountPayable = ${body["amountPayable"]}");

// //       final response = await _submitCatalogPaymentAPI(body);

// //       if (response != null && response.status == true) {
// //         Get.back();
// //         Get.offAll(() => DashboardScreen());
// //         Get.snackbar("Success", response.message ?? "Payment successful",
// //           backgroundColor: Colors.green, colorText: Colors.white);
// //       } else {
// //         Get.snackbar("Error", response?.message ?? "Payment failed",
// //           backgroundColor: Colors.red, colorText: Colors.white);
// //       }
// //     } catch (e) {
// //       Get.snackbar("Error", "Please check your connection: $e",
// //         backgroundColor: Colors.red, colorText: Colors.white);
// //     } finally {
// //       isLoading(false);
// //     }
// //   }

// //   Future<CatalogPaymentResponse?> _submitCatalogPaymentAPI(Map<String, dynamic> body) async {
// //     try {
// //       var headers = {'Content-Type': 'application/json'};
// //       var request = http.Request('POST', Uri.parse('${BaseUrl.baseUrl}createCoinPayment1'));
// //       request.body = json.encode(body);
// //       request.headers.addAll(headers);

// //       print("API Request URL: ${request.url}");
// //       print("API Request Body: ${request.body}");

// //       http.StreamedResponse response = await request.send();
// //       final responseString = await response.stream.bytesToString();
// //       print("API Response Status: ${response.statusCode}");
// //       print("API Response: $responseString");

// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         final jsonResponse = json.decode(responseString);
// //         return CatalogPaymentResponse.fromJson(jsonResponse);
// //       } else {
// //         print("API Error: ${response.reasonPhrase}");
// //         return CatalogPaymentResponse(
// //           status: false,
// //           message: response.reasonPhrase ?? "API call failed with status ${response.statusCode}",
// //         );
// //       }
// //     } catch (e) {
// //       print("Exception in API call: $e");
// //       return CatalogPaymentResponse(
// //         status: false,
// //         message: "Network error: $e",
// //       );
// //     }
// //   }

// //   Widget _buildPriceCardForNewPayment() {
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.all(20),
// //       decoration: BoxDecoration(
// //         color: const Color(0xFF0A2A4D),
// //         borderRadius: BorderRadius.circular(16),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           _buildRow("Product Price", "₹${subtotalAmount.value.toStringAsFixed(2)}"),
// //           const SizedBox(height: 8),
// //           _buildRow("Tax (${taxPercent.value.toStringAsFixed(0)}%)", "₹${taxAmount.value.toStringAsFixed(2)}"),
// //           const SizedBox(height: 8),
// //           _buildRow("Delivery Charge", "₹${deliveryCharge.value.toStringAsFixed(2)}"),
// //           const SizedBox(height: 8),
// //           _buildRow("Investment Amount", "₹0.00", color: const Color(0xFFFFB700)),
// //           const Divider(color: Colors.white70),
// //           _buildRow("Total Payable", "₹${totalPayable.value.toStringAsFixed(2)}", isBold: true),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildPriceCardForRevertPayment(double investmentUsed) {
// //     double finalPayable = totalPayable.value - investmentUsed;
// //     if (finalPayable < 0) finalPayable = 0.0;

// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.all(20),
// //       decoration: BoxDecoration(
// //         color: const Color(0xFF0A2A4D),
// //         borderRadius: BorderRadius.circular(16),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           _buildRow("Product Price", "₹${subtotalAmount.value.toStringAsFixed(2)}"),
// //           const SizedBox(height: 8),
// //           _buildRow("Tax (${taxPercent.value.toStringAsFixed(0)}%)", "₹${taxAmount.value.toStringAsFixed(2)}"),
// //           const SizedBox(height: 8),
// //           _buildRow("Delivery Charge", "₹${deliveryCharge.value.toStringAsFixed(2)}"),
// //           const SizedBox(height: 8),
// //           _buildRow("Investment Amount", "₹${investmentUsed.toStringAsFixed(2)}", color: const Color(0xFFFFB700)),
// //           const Divider(color: Colors.white70),
// //           _buildRow("Total Payable", "₹${finalPayable.toStringAsFixed(2)}", isBold: true),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildRow(String label, String value, {bool isBold = false, Color color = Colors.amber}) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         Text(
// //           label,
// //           style: TextStyle(
// //             color: color,
// //             fontSize: 16,
// //             fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
// //           ),
// //         ),
// //         Text(
// //           value,
// //           style: TextStyle(
// //             color: color,
// //             fontSize: isBold ? 18 : 16,
// //             fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _editableField(
// //     String label,
// //     TextEditingController controller, {
// //     void Function(String)? onChanged,
// //     required TextInputType keyboardType,
// //   }) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 14, color: Colors.grey[700])),
// //         const SizedBox(height: 6),
// //         TextField(
// //           controller: controller,
// //           keyboardType: keyboardType,
// //           decoration: InputDecoration(
// //             filled: true, 
// //             fillColor: const Color(0xFFF4F4F4),
// //             contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
// //             border: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(10),
// //               borderSide: BorderSide(color: Colors.grey.shade300),
// //             ),
// //           ),
// //           onChanged: onChanged,
// //         ),
// //       ],
// //     );
// //   }
// // }
// import 'dart:convert';
// import 'package:aesera_jewels/Api/base_url.dart';
// import 'package:aesera_jewels/models/Addresses_model.dart';
// import 'package:aesera_jewels/models/catalog_model.dart';
// import 'package:aesera_jewels/modules/address/address_screen.dart';
// import 'package:aesera_jewels/modules/coin_catalog/coin_catalog_controller.dart';
// import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
// import 'package:aesera_jewels/services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;

// class GoldCoinPaymentController extends GetxController {
//   var goldRate = 0.0.obs;
//   var taxPercent = 0.0.obs;
//   var deliveryCharge = 0.0.obs;
//   var isLoading = false.obs;
//   var addressesList = <AddressModel>[].obs;

//   final addressController = TextEditingController();
//   final cityController = TextEditingController();
//   final postalCodeController = TextEditingController();
  
//   var selectedCoins = <Map<String, dynamic>>[].obs;
//   var totalInvestment = 0.0.obs;

//   // Dynamic calculation observables
//   var subtotalAmount = 0.0.obs;
//   var taxAmount = 0.0.obs;
//   var totalPayable = 0.0.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchAPIs();
//     fetchTotalInvestment();
//     fetchUserAddresses();
//   }

//   void setSelectedCoins(List<Map<String, dynamic>> coins) {
//     selectedCoins.value = coins;
//     calculateDynamicValues();
//   }

//   void calculateDynamicValues() {
//     // Calculate subtotal from selected coins
//     double subtotal = 0;
//     for (var coin in selectedCoins) {
//       final weight = coin["weight"] ?? 0.0;
//       final pieces = coin["pieces"] ?? 0;
//       final grams = weight * pieces;
//       subtotal += grams * goldRate.value;
//     }
    
//     subtotalAmount.value = subtotal;
//     taxAmount.value = (subtotal * taxPercent.value) / 100;
//     totalPayable.value = subtotal + taxAmount.value + deliveryCharge.value;
//     update();
//   }

//   Future<void> fetchAPIs() async {
//     await Future.wait([_fetchGoldRate(), _fetchTax(), _fetchDelivery()]);
//   }

//   Future<void> _fetchGoldRate() async {
//     try {
//       final res = await http.get(Uri.parse('${BaseUrl.baseUrl}getCurrentRate'));
//       if (res.statusCode == 200) {
//         final data = jsonDecode(res.body);
//         goldRate.value = (data["price_gram_24k"] ?? 0).toDouble();
//         calculateDynamicValues();
//       }
//     } catch (e) {
//       print("Error fetching gold rate: $e");
//     }
//   }

//   Future<void> _fetchTax() async {
//     try {
//       final res = await http.get(Uri.parse('${BaseUrl.baseUrl}getTax'));
//       if (res.statusCode == 200) {
//         final data = jsonDecode(res.body);
//         if (data["status"] == true) {
//           taxPercent.value = (data["data"]["percentage"] ?? 0).toDouble();
//           calculateDynamicValues();
//         }
//       }
//     } catch (e) {
//       print("Error fetching tax: $e");
//     }
//   }

//   Future<void> _fetchDelivery() async {
//     try {
//       final res = await http.get(Uri.parse('${BaseUrl.baseUrl}getDeliveryCharge'));
//       if (res.statusCode == 200) {
//         final data = jsonDecode(res.body);
//         if (data["status"] == true) {
//           deliveryCharge.value = (data["data"]["amount"] ?? 0).toDouble();
//           calculateDynamicValues();
//         }
//       }
//     } catch (e) {
//       print("Error fetching delivery charge: $e");
//     }
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
//     } catch (e) {
//       print("Error fetching total investment: $e");
//     }
//   }

//   Future<void> fetchUserAddresses() async {
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
//             addressesList.value = data.map((e) => AddressModel.fromJson(e)).toList();
//           } else {
//             addressesList.value = [];
//           }
//         } else {
//           addressesList.value = [];
//         }
//       }
//     } catch (e) {
//       addressesList.value = [];
//       print("Error fetching addresses: $e");
//     }
//   }

//   void showPaymentMethodDialog() {
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
//               openAddressBottomSheet();
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
//               openRevertPaymentBottomSheet();
//             },
//             style: ElevatedButton.styleFrom(
//               minimumSize: const Size(double.infinity, 45),
//               backgroundColor: const Color(0xFF0A2A4D),
//             ),
//             child: const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Center(
//                 child: Text(
//                   "Deduct from the Invested Amount",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.white, fontSize: 15),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void openAddressBottomSheet() async {
//     await fetchUserAddresses();
//     var selectedAddressIndex = 0.obs;

//     Get.bottomSheet(
//       StatefulBuilder(
//         builder: (context, setState) {
//           return SingleChildScrollView(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//             ),
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
//                       Text(
//                         "Order Details",
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
                  
//                   // Price Card for New Payment (Investment Amount = 0)
//                   Obx(() => _buildPriceCardForNewPayment()),
                  
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
                  
//                   Obx(() {
//                     if (addressesList.isEmpty) {
//                       return const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 20),
//                         child: Text(
//                           "No addresses found. Please add a delivery address.",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       );
//                     }
                    
//                     return Column(
//                       children: List.generate(addressesList.length, (index) {
//                         final addr = addressesList[index];
//                         return Obx(
//                           () => RadioListTile<int>(
//                             value: index,
//                             groupValue: selectedAddressIndex.value,
//                             title: Text(addr.name ?? ""),
//                             subtitle: Text("${addr.address ?? ""}, ${addr.city ?? ""}"),
//                             onChanged: (val) {
//                               selectedAddressIndex.value = val!;
//                               final selected = addressesList[val];
//                               addressController.text = selected.address ?? "";
//                               cityController.text = selected.city ?? "";
//                               postalCodeController.text = selected.postalCode ?? "";
//                             },
//                           ),
//                         );
//                       }),
//                     );
//                   }),
                  
//                   const SizedBox(height: 24),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (addressesList.isEmpty) {
//                           Get.back();
//                           Get.to(() => AddressScreen());
//                         } else {
//                           final selected = addressesList[selectedAddressIndex.value];
//                           addressController.text = selected.address ?? "";
//                           cityController.text = selected.city ?? "";
//                           postalCodeController.text = selected.postalCode ?? "";
//                           submitCatalogPayment(0.0); // Investment Amount = 0 for new payment
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF09243D),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                       ),
//                       child: Text(
//                         addressesList.isEmpty ? "Add Address" : "Pay",
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                         ),
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

//   void openRevertPaymentBottomSheet() async {
//     await fetchUserAddresses();
//     await fetchTotalInvestment();
    
//     var selectedAddressIndex = 0.obs;
//     var investmentController = TextEditingController(
//       text: totalInvestment.value.toStringAsFixed(2),
//     );

//     Get.bottomSheet(
//       StatefulBuilder(
//         builder: (context, setState) {
//           return Obx(() {
//             double investmentUsed = double.tryParse(investmentController.text) ?? 0.0;
//             bool hasInsufficientBalance = investmentUsed > totalInvestment.value;

//             return SingleChildScrollView(
//               padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom,
//               ),
//               child: Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Center(
//                       child: Text(
//                         "Payment Summary",
//                         style: GoogleFonts.plusJakartaSans(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 15),

//                     // Price Card for Revert Payment (With Investment Amount)
//                     Obx(() => _buildPriceCardForRevertPayment(investmentUsed)),

//                     const SizedBox(height: 10),

//                     // Investment Amount Field
//                     _editableField(
//                       "Investment Amount to Use",
//                       investmentController,
//                       keyboardType: TextInputType.numberWithOptions(decimal: true),
//                       onChanged: (val) {
//                         setState(() {});
//                       },
//                     ),

//                     if (hasInsufficientBalance)
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8),
//                         child: Text(
//                           "You don't have enough balance. Available: ₹${totalInvestment.value.toStringAsFixed(2)}",
//                           style: const TextStyle(color: Colors.red, fontSize: 13),
//                         ),
//                       ),

//                     const SizedBox(height: 15),

//                     Text(
//                       "Select Delivery Location",
//                       style: GoogleFonts.plusJakartaSans(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: const Color(0xFF0D0F1C),
//                       ),
//                     ),
//                     const SizedBox(height: 10),

//                     Obx(() {
//                       if (addressesList.isEmpty) {
//                         return const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 10),
//                           child: Text("Please add a delivery address."),
//                         );
//                       }

//                       return Column(
//                         children: List.generate(addressesList.length, (index) {
//                           final addr = addressesList[index];
//                           return Padding(
//                             padding: const EdgeInsets.only(bottom: 8),
//                             child: Obx(
//                               () => RadioListTile<int>(
//                                 value: index,
//                                 groupValue: selectedAddressIndex.value,
//                                 title: Text(addr.name ?? ""),
//                                 subtitle: Text("${addr.address ?? ""}, ${addr.city ?? ""}"),
//                                 onChanged: (val) {
//                                   selectedAddressIndex.value = val!;
//                                   final selected = addressesList[val];
//                                   addressController.text = selected.address ?? "";
//                                   cityController.text = selected.city ?? "";
//                                   postalCodeController.text = selected.postalCode ?? "";
//                                 },
//                               ),
//                             ),
//                           );
//                         }),
//                       );
//                     }),

//                     const SizedBox(height: 10),

//                     SizedBox(
//                       width: double.infinity,
//                       height: 48,
//                       child: ElevatedButton(
//                         onPressed: hasInsufficientBalance ? null : () {
//                           if (addressesList.isEmpty) {
//                             Get.back();
//                             Get.to(() => AddressScreen());
//                           } else {
//                             final selected = addressesList[selectedAddressIndex.value];
//                             addressController.text = selected.address ?? "";
//                             cityController.text = selected.city ?? "";
//                             postalCodeController.text = selected.postalCode ?? "";
                            
//                             double investmentUsed = double.tryParse(investmentController.text) ?? 0.0;
//                             submitCatalogPayment(investmentUsed);
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: hasInsufficientBalance ? Colors.grey : const Color(0xFF0A2A4D),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                         ),
//                         child: Text(
//                           addressesList.isEmpty ? "Add Address" : "Pay",
//                           style: const TextStyle(color: Colors.white, fontSize: 18),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//             );
//           });
//         },
//       ),
//       isScrollControlled: true,
//     );
//   }

//   Future<void> submitCatalogPayment(double investmentAmount) async {
//     try {
//       isLoading(true);

//       final mobile = await StorageService.getMobileAsync() ?? "Unknown";
//       final address = addressController.text.trim();
//       final city = cityController.text.trim();
//       final postalCode = postalCodeController.text.trim();

//       if (address.isEmpty || city.isEmpty || postalCode.isEmpty) {
//         Get.snackbar("Error", "Please select a delivery address", 
//           backgroundColor: Colors.red, colorText: Colors.white);
//         isLoading(false);
//         return;
//       }

//       // Prepare items list from selected coins
//       List<Map<String, dynamic>> items = selectedCoins.map((coin) {
//         final weight = coin["weight"] ?? 0.0;
//         final pieces = coin["pieces"] ?? 0;
//         final grams = weight * pieces;
//         final amount = grams * goldRate.value;
        
//         return {
//           "coinGrams": weight,
//           "quantity": pieces,
//           "amount": amount.round(),
//         };
//       }).toList();

//       // CRITICAL FIX: Calculate amounts with integer precision to avoid floating point errors
//       int calculatedTotalAmount = subtotalAmount.value.round();
//       int calculatedTaxAmount = taxAmount.value.round();
//       int calculatedDeliveryCharge = deliveryCharge.value.round();
      
//       // Calculate amountPayable as integer sum to ensure exact match
//       int calculatedAmountPayable = calculatedTotalAmount + calculatedTaxAmount + calculatedDeliveryCharge;

//       // Prepare request body matching API requirements exactly
//       final body = {
//         "mobileNumber": mobile,
//         "items": items,
//         "totalAmount": calculatedTotalAmount,
//         "taxAmount": calculatedTaxAmount,
//         "deliveryCharge": calculatedDeliveryCharge,
//         "amountPayable": calculatedAmountPayable, // This equals totalAmount + taxAmount + deliveryCharge
//         "investAmount": investmentAmount.round(), // Include investAmount as required by API
//         "address": address,
//         "city": city,
//         "postCode": postalCode,
//       };

//       // Final verification - ensure the sum matches exactly
//       final verificationSum = calculatedTotalAmount + calculatedTaxAmount + calculatedDeliveryCharge;
//       if (calculatedAmountPayable != verificationSum) {
//         // Force correction if there's any mismatch
//         body["amountPayable"] = verificationSum;
//         print("Corrected amountPayable from $calculatedAmountPayable to $verificationSum");
//       }

//       print("Submitting payment: ${jsonEncode(body)}");
//       print("Verification - totalAmount($calculatedTotalAmount) + taxAmount($calculatedTaxAmount) + deliveryCharge($calculatedDeliveryCharge) = amountPayable(${body["amountPayable"]})");

//       final response = await _submitCatalogPaymentAPI(body);

//       if (response != null && response.status == true) {
//         Get.back();
//         Get.offAll(() => DashboardScreen());
//         Get.snackbar("Success", response.message ?? "Payment successful",
//           backgroundColor: Colors.green, colorText: Colors.white);
//       } else {
//         Get.snackbar("Error", response?.message ?? "Payment failed",
//           backgroundColor: Colors.red, colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Please check your connection: $e",
//         backgroundColor: Colors.red, colorText: Colors.white);
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<CatalogPaymentResponse?> _submitCatalogPaymentAPI(Map<String, dynamic> body) async {
//     try {
//       var headers = {'Content-Type': 'application/json'};
//       var request = http.Request('POST', Uri.parse('${BaseUrl.baseUrl}createCoinPayment1'));
//       request.body = json.encode(body);
//       request.headers.addAll(headers);

//       print("API Request URL: ${request.url}");
//       print("API Request Body: ${request.body}");

//       http.StreamedResponse response = await request.send();
//       final responseString = await response.stream.bytesToString();
//       print("API Response Status: ${response.statusCode}");
//       print("API Response: $responseString");

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final jsonResponse = json.decode(responseString);
//         return CatalogPaymentResponse.fromJson(jsonResponse);
//       } else {
//         print("API Error: ${response.reasonPhrase}");
//         return CatalogPaymentResponse(
//           status: false,
//           message: response.reasonPhrase ?? "API call failed with status ${response.statusCode}",
//         );
//       }
//     } catch (e) {
//       print("Exception in API call: $e");
//       return CatalogPaymentResponse(
//         status: false,
//         message: "Network error: $e",
//       );
//     }
//   }

//   Widget _buildPriceCardForNewPayment() {
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
//           _buildRow("Product Price", "₹${subtotalAmount.value.toStringAsFixed(2)}"),
//           const SizedBox(height: 8),
//           _buildRow("Tax (${taxPercent.value.toStringAsFixed(0)}%)", "₹${taxAmount.value.toStringAsFixed(2)}"),
//           const SizedBox(height: 8),
//           _buildRow("Delivery Charge", "₹${deliveryCharge.value.toStringAsFixed(2)}"),
//           const SizedBox(height: 8),
//           _buildRow("Investment Amount", "₹0.00", color: const Color(0xFFFFB700)),
//           const Divider(color: Colors.white70),
//           _buildRow("Total Payable", "₹${totalPayable.value.toStringAsFixed(2)}", isBold: true),
//         ],
//       ),
//     );
//   }

//   Widget _buildPriceCardForRevertPayment(double investmentUsed) {
//     double finalPayable = totalPayable.value - investmentUsed;
//     if (finalPayable < 0) finalPayable = 0.0;

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
//           _buildRow("Product Price", "₹${subtotalAmount.value.toStringAsFixed(2)}"),
//           const SizedBox(height: 8),
//           _buildRow("Tax (${taxPercent.value.toStringAsFixed(0)}%)", "₹${taxAmount.value.toStringAsFixed(2)}"),
//           const SizedBox(height: 8),
//           _buildRow("Delivery Charge", "₹${deliveryCharge.value.toStringAsFixed(2)}"),
//           const SizedBox(height: 8),
//           _buildRow("Investment Amount", "₹${investmentUsed.toStringAsFixed(2)}", color: const Color(0xFFFFB700)),
//           const Divider(color: Colors.white70),
//           _buildRow("Total Payable", "₹${finalPayable.toStringAsFixed(2)}", isBold: true),
//         ],
//       ),
//     );
//   }

//   Widget _buildRow(String label, String value, {bool isBold = false, Color color = Colors.amber}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             color: color,
//             fontSize: 16,
//             fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             color: color,
//             fontSize: isBold ? 18 : 16,
//             fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _editableField(
//     String label,
//     TextEditingController controller, {
//     void Function(String)? onChanged,
//     required TextInputType keyboardType,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 14, color: Colors.grey[700])),
//         const SizedBox(height: 6),
//         TextField(
//           controller: controller,
//           keyboardType: keyboardType,
//           decoration: InputDecoration(
//             filled: true, 
//             fillColor: const Color(0xFFF4F4F4),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//           ),
//           onChanged: onChanged,
//         ),
//       ],
//     );
//   }
// }
import 'dart:convert';
import 'package:aesera_jewels/Api/base_url.dart';
import 'package:aesera_jewels/models/Addresses_model.dart';
import 'package:aesera_jewels/models/catalog_model.dart';
import 'package:aesera_jewels/models/golcoin_payment_model.dart';
import 'package:aesera_jewels/modules/address/address_screen.dart';
import 'package:aesera_jewels/modules/coin_catalog/coin_catalog_controller.dart';
import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class GoldCoinPaymentController extends GetxController {
  var goldRate = 0.0.obs;
  var taxPercent = 0.0.obs;
  var deliveryCharge = 0.0.obs;
  var isLoading = false.obs;
  var addressesList = <AddressModel>[].obs;

  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  
  var selectedCoins = <Map<String, dynamic>>[].obs;
  var totalInvestment = 0.0.obs;

  // Dynamic calculation observables
  var subtotalAmount = 0.0.obs;
  var taxAmount = 0.0.obs;
  var totalPayable = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAPIs();
    fetchTotalInvestment();
    fetchUserAddresses();
  }

  void setSelectedCoins(List<Map<String, dynamic>> coins) {
    selectedCoins.value = coins;
    calculateDynamicValues();
  }

  void calculateDynamicValues() {
    // Calculate subtotal from selected coins
    double subtotal = 0;
    for (var coin in selectedCoins) {
      final weight = coin["weight"] ?? 0.0;
      final pieces = coin["pieces"] ?? 0;
      final grams = weight * pieces;
      subtotal += grams * goldRate.value;
    }
    
    subtotalAmount.value = subtotal;
    taxAmount.value = (subtotal * taxPercent.value) / 100;
    totalPayable.value = subtotal + taxAmount.value + deliveryCharge.value;
    update();
  }

  Future<void> fetchAPIs() async {
    await Future.wait([_fetchGoldRate(), _fetchTax(), _fetchDelivery()]);
  }

  Future<void> _fetchGoldRate() async {
    try {
      final res = await http.get(Uri.parse('${BaseUrl.baseUrl}getCurrentRate'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        goldRate.value = (data["price_gram_24k"] ?? 0).toDouble();
        calculateDynamicValues();
      }
    } catch (e) {
      print("Error fetching gold rate: $e");
    }
  }

  Future<void> _fetchTax() async {
    try {
      final res = await http.get(Uri.parse('${BaseUrl.baseUrl}getTax'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data["status"] == true) {
          taxPercent.value = (data["data"]["percentage"] ?? 0).toDouble();
          calculateDynamicValues();
        }
      }
    } catch (e) {
      print("Error fetching tax: $e");
    }
  }

  Future<void> _fetchDelivery() async {
    try {
      final res = await http.get(Uri.parse('${BaseUrl.baseUrl}getDeliveryCharge'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data["status"] == true) {
          deliveryCharge.value = (data["data"]["amount"] ?? 0).toDouble();
          calculateDynamicValues();
        }
      }
    } catch (e) {
      print("Error fetching delivery charge: $e");
    }
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
        }
      }
    } catch (e) {
      print("Error fetching total investment: $e");
    }
  }

  Future<void> fetchUserAddresses() async {
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
            addressesList.value = data.map((e) => AddressModel.fromJson(e)).toList();
          } else {
            addressesList.value = [];
          }
        } else {
          addressesList.value = [];
        }
      }
    } catch (e) {
      addressesList.value = [];
      print("Error fetching addresses: $e");
    }
  }

  void showPaymentMethodDialog() {
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
              openAddressBottomSheet();
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
              openRevertPaymentBottomSheet();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 45),
              backgroundColor: const Color(0xFF0A2A4D),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
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

  void openAddressBottomSheet() async {
    await fetchUserAddresses();
    var selectedAddressIndex = 0.obs;

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
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
                  
                  // Price Card for New Payment (No Investment Amount)
                  Obx(() => _buildPriceCard(
                    subtotalAmount.value,
                    taxAmount.value,
                    deliveryCharge.value,
                    totalPayable.value,
                  )),
                  
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
                  
                  if (addressesList.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "No addresses found. Please add a delivery address.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  
                  if (addressesList.isNotEmpty)
                    ...List.generate(addressesList.length, (index) {
                      final addr = addressesList[index];
                      return Obx(
                        () => RadioListTile<int>(
                          value: index,
                          groupValue: selectedAddressIndex.value,
                          title: Text(addr.name ?? ""),
                          subtitle: Text("${addr.address ?? ""}, ${addr.city ?? ""}"),
                          onChanged: (val) {
                            selectedAddressIndex.value = val!;
                            final selected = addressesList[val];
                            addressController.text = selected.address ?? "";
                            cityController.text = selected.city ?? "";
                            postalCodeController.text = selected.postalCode ?? "";
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
                        if (addressesList.isEmpty) {
                          Get.back();
                          Get.to(() => AddressScreen());
                        } else {
                          final selected = addressesList[selectedAddressIndex.value];
                          addressController.text = selected.address ?? "";
                          cityController.text = selected.city ?? "";
                          postalCodeController.text = selected.postalCode ?? "";
                          submitCatalogPayment(0.0); // Investment Amount = 0 for new payment
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF09243D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        addressesList.isEmpty ? "Add Address" : "Pay",
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

  void openRevertPaymentBottomSheet() async {
    await fetchUserAddresses();
    await fetchTotalInvestment();
    
    var selectedAddressIndex = 0.obs;
    var investmentController = TextEditingController(
      text: totalInvestment.value.toStringAsFixed(2),
    );

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return Obx(() {
            double investmentUsed = double.tryParse(investmentController.text) ?? 0.0;
            double finalTotal = totalPayable.value - investmentUsed;
            if (finalTotal < 0) finalTotal = 0.0;

            bool hasInsufficientBalance = investmentUsed > totalInvestment.value;

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
                      "₹${subtotalAmount.value.toStringAsFixed(2)}",
                    ),
                    const SizedBox(height: 10),
                    _nonEditableField(
                      "Tax (${taxPercent.value.toStringAsFixed(0)}%)",
                      "₹${taxAmount.value.toStringAsFixed(2)}",
                    ),
                    const SizedBox(height: 10),
                    _nonEditableField(
                      "Delivery Charge",
                      "₹${deliveryCharge.value.toStringAsFixed(2)}",
                    ),
                    const SizedBox(height: 10),

                    /// ---------- Editable Investment Field ----------
                    _editableField(
                      "Investment Amount to Use",
                      investmentController,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: (val) {
                        setState(() {});
                      },
                    ),

                    /// 🔴 Warning if not enough balance
                    if (hasInsufficientBalance)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "You don't have enough balance. Available: ₹${totalInvestment.value.toStringAsFixed(2)}",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                          ),
                        ),
                      ),

                    const SizedBox(height: 10),
                    const Divider(height: 25, color: Colors.grey),

                    /// ---------- Final Total ----------
                    _nonEditableField(
                      "Final Total Payable",
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

                    if (addressesList.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text("Please add a delivery address."),
                      ),

                    if (addressesList.isNotEmpty)
                      ...List.generate(addressesList.length, (index) {
                        final addr = addressesList[index];
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
                                final selected = addressesList[val];
                                addressController.text = selected.address ?? "";
                                cityController.text = selected.city ?? "";
                                postalCodeController.text = selected.postalCode ?? "";
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
                        onPressed: hasInsufficientBalance ? null : () {
                          if (addressesList.isEmpty) {
                            Get.back();
                            Get.to(() => AddressScreen());
                          } else {
                            final selected = addressesList[selectedAddressIndex.value];
                            addressController.text = selected.address ?? "";
                            cityController.text = selected.city ?? "";
                            postalCodeController.text = selected.postalCode ?? "";
                            
                            double investmentUsed = double.tryParse(investmentController.text) ?? 0.0;
                            submitCatalogPayment(investmentUsed);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: hasInsufficientBalance ? Colors.grey : const Color(0xFF0A2A4D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          addressesList.isEmpty ? "Add Address" : "Pay",
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
    required TextInputType keyboardType,
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
          keyboardType: keyboardType,
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

  Future<void> submitCatalogPayment(double investmentAmount) async {
    try {
      isLoading(true);

      final mobile = await StorageService.getMobileAsync() ?? "Unknown";
      final address = addressController.text.trim();
      final city = cityController.text.trim();
      final postalCode = postalCodeController.text.trim();

      if (address.isEmpty || city.isEmpty || postalCode.isEmpty) {
        Get.snackbar("Error", "Please select a delivery address", 
          backgroundColor: Colors.red, colorText: Colors.white);
        isLoading(false);
        return;
      }

      // Prepare items list from selected coins
      List<Map<String, dynamic>> items = selectedCoins.map((coin) {
        final weight = coin["weight"] ?? 0.0;
        final pieces = coin["pieces"] ?? 0;
        final grams = weight * pieces;
        final amount = grams * goldRate.value;
        
        return {
          "coinGrams": weight,
          "quantity": pieces,
          "amount": amount.round(),
        };
      }).toList();

      // CRITICAL FIX: Calculate amounts with integer precision to avoid floating point errors
      int calculatedTotalAmount = subtotalAmount.value.round();
      int calculatedTaxAmount = taxAmount.value.round();
      int calculatedDeliveryCharge = deliveryCharge.value.round();
      
      // Calculate amountPayable as integer sum to ensure exact match
      int calculatedAmountPayable = calculatedTotalAmount + calculatedTaxAmount + calculatedDeliveryCharge;

      // Prepare request body matching API requirements exactly
      final body = {
        "mobileNumber": mobile,
        "items": items,
        "totalAmount": calculatedTotalAmount,
        "taxAmount": calculatedTaxAmount,
        "deliveryCharge": calculatedDeliveryCharge,
        "amountPayable": calculatedAmountPayable, // This equals totalAmount + taxAmount + deliveryCharge
        "investAmount": investmentAmount.round(), // Include investAmount as required by API
        "address": address,
        "city": city,
        "postCode": postalCode,
      };

      // Final verification - ensure the sum matches exactly
      final verificationSum = calculatedTotalAmount + calculatedTaxAmount + calculatedDeliveryCharge;
      if (calculatedAmountPayable != verificationSum) {
        // Force correction if there's any mismatch
        body["amountPayable"] = verificationSum;
        print("Corrected amountPayable from $calculatedAmountPayable to $verificationSum");
      }

      print("Submitting payment: ${jsonEncode(body)}");
      print("Verification - totalAmount($calculatedTotalAmount) + taxAmount($calculatedTaxAmount) + deliveryCharge($calculatedDeliveryCharge) = amountPayable(${body["amountPayable"]})");

      final response = await _submitCatalogPaymentAPI(body);

      if (response != null && response.status == true) {
        Get.back();
        Get.offAll(() => DashboardScreen());
        Get.snackbar("Success", response.message ?? "Payment successful",
          backgroundColor: Colors.green, colorText: Colors.white);
        
        // Refresh investment amount after successful payment
        await fetchTotalInvestment();
      } else {
        Get.snackbar("Error", response?.message ?? "Payment failed",
          backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Please check your connection: $e",
        backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  Future<CatalogPaymentResponse?> _submitCatalogPaymentAPI(Map<String, dynamic> body) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse('${BaseUrl.baseUrl}createCoinPayment1'));
      request.body = json.encode(body);
      request.headers.addAll(headers);

      print("API Request URL: ${request.url}");
      print("API Request Body: ${request.body}");

      http.StreamedResponse response = await request.send();
      final responseString = await response.stream.bytesToString();
      print("API Response Status: ${response.statusCode}");
      print("API Response: $responseString");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = json.decode(responseString);
        return CatalogPaymentResponse.fromJson(jsonResponse);
      } else {
        print("API Error: ${response.reasonPhrase}");
        return CatalogPaymentResponse(
          status: false,
          message: response.reasonPhrase ?? "API call failed with status ${response.statusCode}",
        );
      }
    } catch (e) {
      print("Exception in API call: $e");
      return CatalogPaymentResponse(
        status: false,
        message: "Network error: $e",
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
            "Tax (${taxPercent.value.toStringAsFixed(0)}%)",
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
}