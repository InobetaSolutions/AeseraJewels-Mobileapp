
// // // import 'dart:convert';
// // // import 'package:aesera_jewels/models/gold_rate_model.dart';
// // // import 'package:aesera_jewels/models/summary_model.dart';
// // // import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
// // // import 'package:aesera_jewels/services/storage_service.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:http/http.dart' as http;

// // // class SummaryController extends GetxController {
// // //   Rx<SummaryModel?> summary = Rx<SummaryModel?>(null);
// // //   final bool paidInRupees;
// // //   final String baseUrl = "http://13.204.96.244:3000/api/newPayment";

// // //   var isLoading = false.obs;
// // //   var goldRate = Rxn<GoldRateModel>();
// // //   var isLoadingRate = true.obs;

// // //   // GST values
// // //   var gstPercentage = 0.0.obs;
// // //   var gstAmount = 0.0.obs;
// // //   var totalPayable = 0.0.obs;

// // //   SummaryController(SummaryModel data, {this.paidInRupees = true}) {
// // //     summary.value = data;
// // //   }

// // //   @override
// // //   void onInit() {
// // //     super.onInit();
// // //     fetchCurrentGoldRate();
// // //     fetchTax();
// // //   }

// // //   /// ✅ Fetch Current Gold Rate
// // //   Future<void> fetchCurrentGoldRate() async {
// // //     try {
// // //       isLoadingRate(true);
// // //       final url = Uri.parse('http://13.204.96.244:3000/api/getCurrentRate');
// // //       final response = await http.get(url);

// // //       if (response.statusCode == 200) {
// // //         final data = jsonDecode(response.body);
// // //         goldRate.value = GoldRateModel.fromJson(data);

// // //         if (goldRate.value != null) {
// // //           await StorageService.saveGoldRate(
// // //             goldRate.value!.priceGram24k.toString(),
// // //           );
// // //         }
// // //       } else {
// // //         Get.snackbar("Error", "Failed to fetch gold rate",
// // //             backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// // //       }
// // //     } catch (e) {
// // //       Get.snackbar("Error", "Please check your internet connection",
// // //           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// // //     } finally {
// // //       isLoadingRate(false);
// // //     }
// // //   }
// // // Future<void> fetchTax() async {
// // //   try {
// // //     final headers = await StorageService().getAuthHeaders(); // Auth headers
// // //     final url = Uri.parse("http://13.204.96.244:3000/api/getTax");

// // //     // Using Request & StreamedResponse as you shared
// // //     var request = http.Request('GET', url);
// // //     request.headers.addAll(headers);

// // //     http.StreamedResponse response = await request.send();

// // //     if (response.statusCode == 200) {
// // //       final resString = await response.stream.bytesToString();
// // //       final data = jsonDecode(resString);

// // //       double percentage = (data["data"]["percentage"] ?? 0).toDouble();
// // //       gstPercentage.value = percentage;

// // //       if (summary.value != null) {
// // //         double goldValue = summary.value!.goldValue;
// // //         gstAmount.value = (goldValue * percentage) / 100;
// // //         totalPayable.value = goldValue + gstAmount.value;
// // //       }
// // //     } else {
// // //       Get.snackbar("Error", "Failed to fetch tax info",
// // //           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// // //     }
// // //   } catch (e) {
// // //     Get.snackbar("Error", "Please check your internet connection",
// // //         backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// // //   }
// // // }

// // //   // /// ✅ Fetch Tax (GST %) and calculate GST amount
// // //   // Future<void> fetchTax() async {
// // //   //   try {
// // //   //     final headers = await StorageService().getAuthHeaders();
// // //   //     final url = Uri.parse("http://13.204.96.244:3000/api/getTax");
// // //   //     final response = await http.get(url, headers: headers);

// // //   //     if (response.statusCode == 200) {
// // //   //       final data = jsonDecode(response.body);
// // //   //       double percentage = (data["data"]["percentage"] ?? 0).toDouble();

// // //   //       gstPercentage.value = percentage;

// // //   //       if (summary.value != null) {
// // //   //         double goldValue = summary.value!.goldValue;
// // //   //         gstAmount.value = (goldValue * percentage) / 100;
// // //   //         totalPayable.value = goldValue + gstAmount.value;
// // //   //       }
// // //   //     } else {
// // //   //       Get.snackbar("Error", "Failed to fetch tax info",
// // //   //           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// // //   //     }
// // //   //   } catch (e) {
// // //   //     Get.snackbar("Error", "Please check your internet connection",
// // //   //         backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// // //   //   }
// // //   // }

// // //   /// ✅ Confirmation Popup
// // //   void confirmPayment() {
// // //     Get.defaultDialog(
// // //       backgroundColor: Colors.white,
// // //       title: "Confirmation",
// // //       middleText: "Do you want to proceed with payment?",
// // //       barrierDismissible: false,
// // //       titleStyle: const TextStyle(
// // //           color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
// // //       middleTextStyle:
// // //           const TextStyle(color: Colors.black87, fontSize: 16),
// // //       actions: [
// // //         ElevatedButton(
// // //           style: ElevatedButton.styleFrom(
// // //             backgroundColor: const Color(0xFFFFB700),
// // //           ),
// // //           onPressed: () {
// // //             if (Get.isDialogOpen == true) Get.back();
// // //           },
// // //           child: const Text(
// // //             "Cancel",
// // //             style: TextStyle(color: Colors.black, fontSize: 15),
// // //           ),
// // //         ),
// // //         const SizedBox(width: 10),
// // //         ElevatedButton(
// // //           style: ElevatedButton.styleFrom(
// // //             backgroundColor: const Color(0xFF0A2A4D),
// // //           ),
// // //           onPressed: () async {
// // //             if (Get.isDialogOpen == true) Get.back();
// // //             await createPayment();
// // //           },
// // //           child: const Text(
// // //             "OK",
// // //             style: TextStyle(color: Colors.white, fontSize: 15),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   /// ✅ Create Payment API Call
// // //   Future<void> createPayment() async {
// // //     final data = summary.value;
// // //     if (data == null) return;

// // //     try {
// // //       isLoading(true);

// // //       String? senderMobile = await StorageService().getMobile();
// // //       if (senderMobile == null || senderMobile.isEmpty) {
// // //         Get.snackbar("Error", "User mobile number not found",
// // //             backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// // //         return;
// // //       }

// // //       var headers = await StorageService().getAuthHeaders();

// // //       var body = json.encode({
// // //         "mobile": senderMobile,
// // //         "others": "",
// // //         "amount": data.goldValue,
// // //         "gram": data.goldQuantity,
// // //         "amount_allocated": data.goldValue,
// // //         "gram_allocated": data.goldQuantity,
// // //         "taxAmount": gstAmount.value,
// // //         "totalPayAmountWithTax": totalPayable.value,
// // //       });

// // //       var response =
// // //           await http.post(Uri.parse(baseUrl), headers: headers, body: body);

// // //       if (response.statusCode == 200 || response.statusCode == 201) {
// // //         Get.snackbar("Success", "Payment Successful!",
// // //             backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// // //         Get.offAll(() => DashboardScreen());
// // //       } else {
// // //         Get.snackbar("Error", "Failed: ${response.statusCode}\n${response.body}",
// // //             backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// // //       }
// // //     } catch (e) {
// // //       Get.snackbar("Error", "Please check your internet connection",
// // //           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// // //     } finally {
// // //       isLoading(false);
// // //     }
// // //   }
// // // }
// // import 'dart:convert';
// // import 'package:aesera_jewels/models/gold_rate_model.dart';
// // import 'package:aesera_jewels/models/summary_model.dart';
// // import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
// // import 'package:aesera_jewels/services/storage_service.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;

// // class SummaryController extends GetxController {
// //   Rx<SummaryModel?> summary = Rx<SummaryModel?>(null);
// //   final bool paidInRupees;
// //   final String baseUrl = "http://13.204.96.244:3000/api/newPayment";

// //   var isLoading = false.obs;
// //   var goldRate = Rxn<GoldRateModel>();
// //   var isLoadingRate = true.obs;

// //   // GST values
// //   var gstPercentage = 0.0.obs;
// //   var gstAmount = 0.0.obs;
// //   var totalPayable = 0.0.obs;

// //   SummaryController(SummaryModel data, {this.paidInRupees = true}) {
// //     summary.value = data;
// //   }

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchCurrentGoldRate();
// //     fetchTax(); // ✅ Fetch GST
// //   }

// //   /// ✅ Fetch Current Gold Rate
// //   Future<void> fetchCurrentGoldRate() async {
// //     try {
// //       isLoadingRate(true);
// //       final url = Uri.parse('http://13.204.96.244:3000/api/getCurrentRate');
// //       final response = await http.get(url);

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         goldRate.value = GoldRateModel.fromJson(data);

// //         if (goldRate.value != null) {
// //           await StorageService.saveGoldRate(
// //             goldRate.value!.priceGram24k.toString(),
// //           );
// //         }
// //       } else {
// //         Get.snackbar("Error", "Failed to fetch gold rate",
// //             backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// //       }
// //     } catch (e) {
// //       Get.snackbar("Error", "Please check your internet connection",
// //           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// //     } finally {
// //       isLoadingRate(false);
// //     }
// //   }

// //   /// ✅ Fetch GST using getTax API (StreamedResponse method)
// //   Future<void> fetchTax() async {
// //     try {
// //       final headers = await StorageService().getAuthHeaders();
// //       final url = Uri.parse("http://13.204.96.244:3000/api/getTax");

// //       var request = http.Request('GET', url);
// //       request.headers.addAll(headers);

// //       http.StreamedResponse response = await request.send();

// //       if (response.statusCode == 200) {
// //         final resString = await response.stream.bytesToString();
// //         final data = jsonDecode(resString);

// //         double percentage = (data["data"]["percentage"] ?? 0).toDouble();
// //         gstPercentage.value = percentage;

// //         if (summary.value != null) {
// //           double goldValue = summary.value!.goldValue;
// //           gstAmount.value = (goldValue * percentage) / 100;
// //           totalPayable.value = goldValue + gstAmount.value;
// //         }
// //       } else {
// //         Get.snackbar("Error", "Failed to fetch tax info",
// //             backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// //       }
// //     } catch (e) {
// //       Get.snackbar("Error", "Please check your internet connection",
// //           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// //     }
// //   }

// //   /// ✅ Confirmation Popup
// //   void confirmPayment() {
// //     Get.defaultDialog(
// //       backgroundColor: Colors.white,
// //       title: "Confirmation",
// //       middleText: "Do you want to proceed with payment?",
// //       barrierDismissible: false,
// //       titleStyle: const TextStyle(
// //           color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
// //       middleTextStyle: const TextStyle(color: Colors.black87, fontSize: 16),
// //       actions: [
// //         ElevatedButton(
// //           style: ElevatedButton.styleFrom(
// //             backgroundColor: const Color(0xFFFFB700),
// //           ),
// //           onPressed: () {
// //             if (Get.isDialogOpen == true) Get.back();
// //           },
// //           child: const Text(
// //             "Cancel",
// //             style: TextStyle(color: Colors.black, fontSize: 15),
// //           ),
// //         ),
// //         const SizedBox(width: 10),
// //         ElevatedButton(
// //           style: ElevatedButton.styleFrom(
// //             backgroundColor: const Color(0xFF0A2A4D),
// //           ),
// //           onPressed: () async {
// //             if (Get.isDialogOpen == true) Get.back();
// //             await createPayment();
// //           },
// //           child: const Text(
// //             "OK",
// //             style: TextStyle(color: Colors.white, fontSize: 15),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   /// ✅ Create Payment API Call
// //   Future<void> createPayment() async {
// //     final data = summary.value;
// //     if (data == null) return;

// //     try {
// //       isLoading(true);

// //       String? senderMobile = await StorageService().getMobile();
// //       if (senderMobile == null || senderMobile.isEmpty) {
// //         Get.snackbar("Error", "User mobile number not found",
// //             backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// //         return;
// //       }

// //       var headers = await StorageService().getAuthHeaders();

// //       var body = json.encode({
// //         "mobile": senderMobile,
// //         "others": "",
// //         "amount": data.goldValue,
// //         "gram": data.goldQuantity,
// //         "amount_allocated": data.goldValue,
// //         "gram_allocated": data.goldQuantity,
// //         "taxAmount": gstAmount.value,
// //         "totalPayAmountWithTax": totalPayable.value,
// //       });

// //       var response =
// //           await http.post(Uri.parse(baseUrl), headers: headers, body: body);

// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         Get.snackbar("Success", "Payment Successful!",
// //             backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// //         Get.offAll(() => DashboardScreen());
// //       } else {
// //         Get.snackbar("Error", "Failed: ${response.statusCode}\n${response.body}",
// //             backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// //       }
// //     } catch (e) {
// //       Get.snackbar("Error", "Please check your internet connection",
// //           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// // }
// import 'dart:convert';
// import 'package:aesera_jewels/models/gold_rate_model.dart';
// import 'package:aesera_jewels/models/summary_model.dart';
// import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
// import 'package:aesera_jewels/services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class SummaryController extends GetxController {
//   Rx<SummaryModel?> summary = Rx<SummaryModel?>(null);
//   final bool paidInRupees;
//   final String baseUrl = "http://13.204.96.244:3000/api/newPayment";

//   var isLoading = false.obs;
//   var goldRate = Rxn<GoldRateModel>();
//   var isLoadingRate = true.obs;

//   // GST values
//   var gstPercentage = 0.0.obs;
//   var gstAmount = 0.0.obs;
//   var totalPayable = 0.0.obs;

//   SummaryController(SummaryModel data, {this.paidInRupees = true}) {
//     summary.value = data;
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     fetchCurrentGoldRate();
//     fetchTax();
//   }

//   /// Fetch Current Gold Rate
//   Future<void> fetchCurrentGoldRate() async {
//     try {
//       isLoadingRate(true);
//       final url = Uri.parse('http://13.204.96.244:3000/api/getCurrentRate');
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         goldRate.value = GoldRateModel.fromJson(data);
//         if (goldRate.value != null) {
//           await StorageService.saveGoldRate(
//             goldRate.value!.priceGram24k.toString(),
//           );
//         }
//       } else {
//         Get.snackbar("Error", "Failed to fetch gold rate",
//             backgroundColor: const Color(0xFF09243D),
//             colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Please check your internet connection",
//           backgroundColor: const Color(0xFF09243D),
//           colorText: Colors.white);
//     } finally {
//       isLoadingRate(false);
//     }
//   }

//   /// Fetch GST using getTax API
//   Future<void> fetchTax() async {
//     try {
//       final headers = await StorageService().getAuthHeaders();
//       final url = Uri.parse("http://13.204.96.244:3000/api/getTax");

//       var request = http.Request('GET', url);
//       request.headers.addAll(headers);

//       http.StreamedResponse response = await request.send();

//       if (response.statusCode == 200) {
//         final resString = await response.stream.bytesToString();
//         final data = jsonDecode(resString);

//         double percentage = (data["data"]["percentage"] ?? 0).toDouble();
//         gstPercentage.value = percentage;

//         // Calculate GST amount in ₹ based on gold value
//         if (summary.value != null) {
//           double goldValue = summary.value!.goldValue;
//           gstAmount.value = (goldValue * percentage) / 100;
//           totalPayable.value = goldValue + gstAmount.value;
//         }
//         print(response);
//       } else {
//         Get.snackbar("Error", "Failed to fetch tax info",
//             backgroundColor: const Color(0xFF09243D),
//             colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Please check your internet connection",
//           backgroundColor: const Color(0xFF09243D),
//           colorText: Colors.white);
//     }
//   }

//   /// Confirmation Popup
//   void confirmPayment() {
//     Get.defaultDialog(
//       backgroundColor: Colors.white,
//       title: "Confirmation",
//       middleText: "Do you want to proceed with payment?",
//       barrierDismissible: false,
//       titleStyle:
//           const TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
//       middleTextStyle: const TextStyle(color: Colors.black87, fontSize: 16),
//       actions: [
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFFFFB700),
//           ),
//           onPressed: () {
//             if (Get.isDialogOpen == true) Get.back();
//           },
//           child: const Text("Cancel",
//               style: TextStyle(color: Colors.black, fontSize: 15)),
//         ),
//         const SizedBox(width: 10),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF0A2A4D),
//           ),
//           onPressed: () async {
//             if (Get.isDialogOpen == true) Get.back();
//             await createPayment();
//           },
//           child: const Text("OK",
//               style: TextStyle(color: Colors.white, fontSize: 15)),
//         ),
//       ],
//     );
//   }

//   /// Create Payment API Call
//   Future<void> createPayment() async {
//     final data = summary.value;
//     if (data == null) return;

//     try {
//       isLoading(true);

//       String? senderMobile = await StorageService().getMobile();
//       if (senderMobile == null || senderMobile.isEmpty) {
//         Get.snackbar("Error", "User mobile number not found",
//             backgroundColor: const Color(0xFF09243D),
//             colorText: Colors.white);
//         return;
//       }

//       var headers = await StorageService().getAuthHeaders();
//       var body = json.encode({
//         "mobile": senderMobile,
//         "others": "",
//         "amount": data.goldValue,
//         "gram": data.goldQuantity,
//         "amount_allocated": data.goldValue,
//         "gram_allocated": data.goldQuantity,
//         "taxAmount": gstAmount.value,
//         "totalPayAmountWithTax": totalPayable.value,
//       });

//       var response =
//           await http.post(Uri.parse(baseUrl), headers: headers, body: body);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         Get.snackbar("Success", "Payment Successful!",
//             backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
//         Get.offAll(() => DashboardScreen());
//       } else {
//         Get.snackbar("Error",
//             "Failed: ${response.statusCode}\n${response.body}",
//             backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Please check your internet connection",
//           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
//     } finally {
//       isLoading(false);
//     }
//   }
// }
// import 'dart:convert';
// import 'package:aesera_jewels/models/gold_rate_model.dart';
// import 'package:aesera_jewels/models/summary_model.dart';
// import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
// import 'package:aesera_jewels/services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class SummaryController extends GetxController {
//   // Summary Data
//   Rx<SummaryModel?> summary = Rx<SummaryModel?>(null);
//   final bool paidInRupees;
//   final String baseUrl = "http://13.204.96.244:3000/api/newPayment";

//   // Loading flags
//   var isLoading = false.obs;
//   var isLoadingRate = true.obs;

//   // Gold Rate
//   var goldRate = Rxn<GoldRateModel>();

//   // GST
//   var gstPercentage = 0.0.obs;
//   var gstAmount = 0.0.obs;
//   var totalPayable = 0.0.obs;

//   SummaryController(SummaryModel data, {this.paidInRupees = true}) {
//     summary.value = data;
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     fetchCurrentGoldRate();
//     fetchTax();
//   }

//   /// Fetch Current Gold Rate
//   Future<void> fetchCurrentGoldRate() async {
//     try {
//       isLoadingRate(true);
//       final url = Uri.parse('http://13.204.96.244:3000/api/getCurrentRate');
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         goldRate.value = GoldRateModel.fromJson(data);

//         if (goldRate.value != null) {
//           await StorageService.saveGoldRate(
//             goldRate.value!.priceGram24k.toString(),
//           );
//         }
//       } else {
//         Get.snackbar("Error", "Failed to fetch gold rate",
//             backgroundColor: const Color(0xFF09243D),
//             colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Please check your internet connection",
//           backgroundColor: const Color(0xFF09243D),
//           colorText: Colors.white);
//     } finally {
//       isLoadingRate(false);
//     }
//   }

//   /// Fetch GST from API
//   Future<void> fetchTax() async {
//     try {
//       final headers = await StorageService().getAuthHeaders();
//       final url = Uri.parse("http://13.204.96.244:3000/api/getTax");

//       var request = http.Request('GET', url);
//       request.headers.addAll(headers);

//       http.StreamedResponse response = await request.send();

//       if (response.statusCode == 200) {
//         final resString = await response.stream.bytesToString();
//         final data = jsonDecode(resString);


//         // Save GST % dynamically
//         double percentage = (data["data"]["percentage"] ?? 0).toDouble();
//         gstPercentage.value = percentage;

//         // If we already have gold value, calculate GST & total
//         if (summary.value != null) {
//           double goldValue = summary.value!.goldValue;

//           // Exact GST (no round off)
//           gstAmount.value = (goldValue * percentage) / 100;

//           // Total = Base + GST
//           totalPayable.value = goldValue + gstAmount.value;
//         }
//       } else {
//         Get.snackbar("Error", "Failed to fetch tax info",
//             backgroundColor: const Color(0xFF09243D),
//             colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Please check your internet connection",
//           backgroundColor: const Color(0xFF09243D),
//           colorText: Colors.white);
//     }
//   }

//   /// Show confirmation popup
//   void confirmPayment() {
//     Get.defaultDialog(
//       backgroundColor: Colors.white,
//       title: "Confirmation",
//       middleText: "Do you want to proceed with payment?",
//       barrierDismissible: false,
//       titleStyle: const TextStyle(
//         color: Colors.black,
//         fontSize: 25,
//         fontWeight: FontWeight.bold,
//       ),
//       middleTextStyle: const TextStyle(color: Colors.black87, fontSize: 16),
//       actions: [
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFFFFB700),
//           ),
//           onPressed: () {
//             if (Get.isDialogOpen == true) Get.back();
//           },
//           child: const Text(
//             "Cancel",
//             style: TextStyle(color: Colors.black, fontSize: 15),
//           ),
//         ),
//         const SizedBox(width: 10),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF0A2A4D),
//           ),
//           onPressed: () async {
//             if (Get.isDialogOpen == true) Get.back();
//             await createPayment();
//           },
//           child: const Text(
//             "OK",
//             style: TextStyle(color: Colors.white, fontSize: 15),
//           ),
//         ),
//       ],
//     );
//   }

//   /// Payment API call
//   Future<void> createPayment() async {
//     final data = summary.value;
//     if (data == null) return;

//     try {
//       isLoading(true);

//       String? senderMobile = await StorageService().getMobile();
//       if (senderMobile == null || senderMobile.isEmpty) {
//         Get.snackbar("Error", "User mobile number not found",
//             backgroundColor: const Color(0xFF09243D),
//             colorText: Colors.white);
//         return;
//       }

//       var headers = await StorageService().getAuthHeaders();
//       var body = json.encode({
//         "mobile": senderMobile,
//         "others": "",
//         "amount": data.goldValue,
//         "gram": data.goldQuantity,
//         "amount_allocated": data.goldValue,
//         "gram_allocated": data.goldQuantity,
//         "taxAmount": gstAmount.value, // exact GST
//         "totalPayAmountWithTax": totalPayable.value, // base + GST
//       });

//            print("provide :${body}");

//       var response =
//           await http.post(Uri.parse(baseUrl), headers: headers, body: body);

        

//       if (response.statusCode == 200 || response.statusCode == 201) {

    
//         Get.snackbar("Success", "Payment Successful!",
//             backgroundColor: const Color(0xFF09243D),
//             colorText: Colors.white);
//         Get.offAll(() => DashboardScreen());
//       } else {
//         Get.snackbar(
//           "Error",
//           "Failed: ${response.statusCode}\n${response.body}",
//           backgroundColor: const Color(0xFF09243D),
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Please check your internet connection",
//           backgroundColor: const Color(0xFF09243D),
//           colorText: Colors.white);
//     } finally {
//       isLoading(false);
//     }
//   }
// }


import 'dart:convert';
import 'package:aesera_jewels/Api/base_url.dart';
import 'package:aesera_jewels/models/gold_rate_model.dart';
import 'package:aesera_jewels/models/summary_model.dart';
import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SummaryController extends GetxController {
  // Summary Data
  Rx<SummaryModel?> summary = Rx<SummaryModel?>(null);
  final bool paidInRupees;
  final String baseUrl = "${BaseUrl.baseUrl}newPayment";

  // Loading flags
  var isLoading = false.obs;
  var isLoadingRate = true.obs;

  // Gold Rate
  var goldRate = Rxn<GoldRateModel>();

  // GST
  var gstPercentage = 0.0.obs;
  var gstAmount = 0.0.obs;
  var totalPayable = 0.0.obs;

  SummaryController(SummaryModel data, {this.paidInRupees = true}) {
    summary.value = data;
  }

  @override
  void onInit() {
    super.onInit();
    fetchCurrentGoldRate();
    fetchTax();
  }

  /// Fetch Current Gold Rate
  Future<void> fetchCurrentGoldRate() async {
    try {
      isLoadingRate(true);
      final url = Uri.parse('${BaseUrl.baseUrl}getCurrentRate');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        goldRate.value = GoldRateModel.fromJson(data);

        if (goldRate.value != null) {
          await StorageService.saveGoldRate(
            goldRate.value!.priceGram24k.toString(),
          );
        }
      } else {
        Get.snackbar("Error", "Failed to fetch gold rate",
            backgroundColor: const Color(0xFF09243D),
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Please check your internet connection",
          backgroundColor: const Color(0xFF09243D),
          colorText: Colors.white);
    } finally {
      isLoadingRate(false);
    }
  }

  /// Fetch GST from API
  Future<void> fetchTax() async {
    try {
      final headers = await StorageService().getAuthHeaders();
      final url = Uri.parse("${BaseUrl.baseUrl}getTax");

      var request = http.Request('GET', url);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
 
      if (response.statusCode == 200) {
        final resString = await response.stream.bytesToString();
        final data = jsonDecode(resString);

        // Save GST % dynamically
        double percentage = (data["data"]["percentage"] ?? 0).toDouble();
        gstPercentage.value = percentage;

        // If we already have gold value, calculate GST & total
        if (summary.value != null) {
          double goldValue = summary.value!.goldValue;

          // Exact GST (no round off)
          gstAmount.value = (goldValue * percentage) / 100;

          // Total = Base + GST
          totalPayable.value = goldValue + gstAmount.value;
        }
     
      } else {
        Get.snackbar("Error", "Failed to fetch tax info",
            backgroundColor: const Color(0xFF09243D),
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Please check your internet connection",
          backgroundColor: const Color(0xFF09243D),
          colorText: Colors.white);
    }
  }

  /// Show confirmation popup
  void confirmPayment() {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: "Confirmation",
      middleText: "Do you want to proceed with payment?",
      barrierDismissible: false,
      titleStyle: const TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      middleTextStyle: const TextStyle(color: Colors.black87, fontSize: 16),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFB700),
          ),
          onPressed: () {
            if (Get.isDialogOpen == true) Get.back();
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0A2A4D),
          ),
          onPressed: () async {
            if (Get.isDialogOpen == true) Get.back();
            await createPayment();
          },
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ],
    );
  }

  /// Payment API call
//   Future<void> createPayment() async {
//     final data = summary.value;
//     if (data == null) return;

//     try {
//       isLoading(true);

//       String? senderMobile = await StorageService().getMobile();
//       if (senderMobile == null || senderMobile.isEmpty) {
//         Get.snackbar("Error", "User mobile number not found",
//             backgroundColor: const Color(0xFF09243D),
//             colorText: Colors.white);
//         return;
//       }

//       var headers = await StorageService().getAuthHeaders();

//       Map<String, dynamic> bodyMap = {
//         "mobile": senderMobile,
//         "others": "",
//         "amount": data.goldValue,
//         "gram": data.goldQuantity,
//         "amount_allocated": data.goldValue,
//         "gram_allocated": data.goldQuantity,
//         "taxAmount": gstAmount.value, // exact GST
//         "totalPayAmountWithTax": totalPayable.value, // base + GST
//       };

//       if (paidInRupees) {
//         // ✅ Buying with Amount
//         bodyMap["amount"] = data.goldValue;
//         bodyMap["gram_allocated"] = data.goldQuantity;
//       } else {
//         // ✅ Buying with Grams
//         bodyMap["gram"] = data.goldQuantity;
//         bodyMap["amount_allocated"] = data.goldValue;
//       }

//       var body = json.encode(bodyMap);
//       print("provide : $body");

//       var response =
//           await http.post(Uri.parse(baseUrl), headers: headers, body: body);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         Get.snackbar("Success", "Payment Successful!",
//             backgroundColor: const Color(0xFF09243D),
//             colorText: Colors.white);
//         Get.offAll(() => DashboardScreen());
//       } else {
//         Get.snackbar(
//           "Error",
//           "Failed: ${response.statusCode}\n${response.body}",
//           backgroundColor: const Color(0xFF09243D),
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Please check your internet connection",
//           backgroundColor: const Color(0xFF09243D),
//           colorText: Colors.white);
//     } finally {
//       isLoading(false);
//     }
//   }
// }
/// Payment API call
Future<void> createPayment() async {
  final data = summary.value;
  if (data == null) return;

  try {
    isLoading(true);

    String? senderMobile = await StorageService().getMobile();
    if (senderMobile == null || senderMobile.isEmpty) {
      Get.snackbar("Error", "User mobile number not found",
          backgroundColor: const Color(0xFF09243D),
          colorText: Colors.white);
      return;
    }

    var headers = await StorageService().getAuthHeaders();

    // Default body map
    Map<String, dynamic> bodyMap = {
      "mobile": senderMobile,
      "others": "",
      "taxAmount": gstAmount.value,
      "totalPayAmountWithTax": totalPayable.value,
      "amount": 0,
      "gram": 0,
      "amount_allocated": 0,
      "gram_allocated": 0,
    };

    if (paidInRupees) {
      // ✅ Buying with Amount: send only amount + gram_allocated
      bodyMap["amount"] = data.goldValue;
      bodyMap["gram_allocated"] = data.goldQuantity;
    } else {
      // ✅ Buying with Grams: send only gram + amount_allocated
      bodyMap["gram"] = data.goldQuantity;
      bodyMap["amount_allocated"] = data.goldValue;
    }

    var body = json.encode(bodyMap);
    print("API Payload: $body");

    var response =
        await http.post(Uri.parse(baseUrl), headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar("Success", "Payment Successful!",
          backgroundColor: const Color(0xFF09243D),
          colorText: Colors.white);
      Get.offAll(() => DashboardScreen());
    } else {
      Get.snackbar(
        "Error",
        "Failed: ${response.statusCode}\n${response.body}",
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white,
      );
    }
  } catch (e) {
    Get.snackbar("Error", "Please check your internet connection",
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white);
  } finally {
    isLoading(false);
  }
}
}