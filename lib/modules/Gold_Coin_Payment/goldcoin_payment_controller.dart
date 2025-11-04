
// // // }
// // import 'dart:convert';
// // import 'dart:ui';
// // import 'package:aesera_jewels/Api/base_url.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;

// // class GoldCoinPaymentController extends GetxController {
// //   var goldRate = 0.0.obs;
// //   var taxPercent = 0.0.obs;
// //   var deliveryCharge = 0.0.obs;
// //   var isLoading = false.obs;

// //   Future<void> fetchAPIs() async {
// //     await Future.wait([
// //       _fetchGoldRate(),
// //       _fetchTax(),
// //       _fetchDelivery(),
// //     ]);
// //   }

// //   Future<void> _fetchGoldRate() async {
// //     try {
// //       final res = await http.get(Uri.parse('${BaseUrl.baseUrl}getCurrentRate'));
// //       if (res.statusCode == 200) {
// //         final data = jsonDecode(res.body);
// //         goldRate.value = (data["price_gram_24k"] ?? 0).toDouble();
// //       }
// //     } catch (_) {}
// //   }

// //   Future<void> _fetchTax() async {
// //     try {
// //       final res = await http.get(Uri.parse('${BaseUrl.baseUrl}getTax'));
// //       if (res.statusCode == 200) {
// //         final data = jsonDecode(res.body);
// //         if (data["status"] == true) {
// //           taxPercent.value = (data["data"]["percentage"] ?? 0).toDouble();
// //         }
// //       }
// //     } catch (_) {}
// //   }

// //   Future<void> _fetchDelivery() async {
// //     try {
// //       final res =
// //           await http.get(Uri.parse('${BaseUrl.baseUrl}getDeliveryCharge'));
// //       if (res.statusCode == 200) {
// //         final data = jsonDecode(res.body);
// //         if (data["status"] == true) {
// //           deliveryCharge.value = (data["data"]["amount"] ?? 0).toDouble();
// //         }
// //       }
// //     } catch (_) {}
// //   }

// //   /// Payment Confirmation Popup
// //   void confirmPayment(VoidCallback onConfirm) {
// //     Get.defaultDialog(
// //       title: "Confirm Payment",
// //       middleText: "Do you want to proceed with your gold coin payment?",
// //       backgroundColor: Colors.white,
// //       barrierDismissible: false,
// //       titleStyle: const TextStyle(
// //         fontWeight: FontWeight.bold,
// //         fontSize: 20,
// //         color: Colors.black,
// //       ),
// //       middleTextStyle: const TextStyle(color: Colors.black87, fontSize: 15),
// //       actions: [
// //         ElevatedButton(
// //           style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB700)),
// //           onPressed: () => Get.back(),
// //           child: const Text("Cancel", style: TextStyle(color: Colors.black)),
// //         ),
// //         ElevatedButton(
// //           style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A2A4D)),
// //           onPressed: () {
// //             Get.back();
// //             onConfirm();
// //           },
// //           child: const Text("Confirm", style: TextStyle(color: Colors.white)),
// //         ),
// //       ],
// //     );
// //   }

// //   /// Mock API or actual payment logic placeholder
// //   Future<void> submitPayment(List<Map<String, dynamic>> selectedCoins) async {
// //     try {
// //       isLoading(true);
// //       await Future.delayed(const Duration(seconds: 2)); // Simulate API call
// //       Get.snackbar("Success", "Payment completed successfully!",
// //           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// //       Get.back();
// //     } catch (e) {
// //       Get.snackbar("Error", "Payment failed. Try again later.",
// //           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// // }
// import 'dart:convert';
// import 'package:aesera_jewels/Api/base_url.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class GoldCoinPaymentController extends GetxController {
//   var goldRate = 0.0.obs;
//   var taxPercent = 0.0.obs;
//   var deliveryCharge = 0.0.obs;
//   var isLoading = false.obs;

//   Future<void> fetchAPIs() async {
//     await Future.wait([_fetchGoldRate(), _fetchTax(), _fetchDelivery()]);
//   }

//   Future<void> _fetchGoldRate() async {
//     try {
//       final res = await http.get(Uri.parse('${BaseUrl.baseUrl}getCurrentRate'));
//       if (res.statusCode == 200) {
//         final data = jsonDecode(res.body);
//         goldRate.value = (data["price_gram_24k"] ?? 0).toDouble();
//       }
//     } catch (_) {}
//   }

//   Future<void> _fetchTax() async {
//     try {
//       final res = await http.get(Uri.parse('${BaseUrl.baseUrl}getTax'));
//       if (res.statusCode == 200) {
//         final data = jsonDecode(res.body);
//         if (data["status"] == true) {
//           taxPercent.value = (data["data"]["percentage"] ?? 0).toDouble();
//         }
//       }
//     } catch (_) {}
//   }

//   Future<void> _fetchDelivery() async {
//     try {
//       final res =
//           await http.get(Uri.parse('${BaseUrl.baseUrl}getDeliveryCharge'));
//       if (res.statusCode == 200) {
//         final data = jsonDecode(res.body);
//         if (data["status"] == true) {
//           deliveryCharge.value = (data["data"]["amount"] ?? 0).toDouble();
//         }
//       }
//     } catch (_) {}
//   }

//   /// Confirmation popup before payment
//   void confirmPayment(double totalAmount) {
//     Get.defaultDialog(
//       backgroundColor: Colors.white,
//       title: "Confirm Payment",
//       middleText:
//           "Do you want to proceed with the payment of ₹${totalAmount.toStringAsFixed(2)}?",
//       barrierDismissible: false,
//       titleStyle: const TextStyle(
//           color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
//       middleTextStyle: const TextStyle(color: Colors.black87, fontSize: 16),
//       actions: [
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade400),
//           onPressed: () {
//             if (Get.isDialogOpen == true) Get.back();
//           },
//           child: const Text("Cancel",
//               style: TextStyle(color: Colors.black, fontSize: 15)),
//         ),
//         const SizedBox(width: 10),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A2A4D)),
//           onPressed: () async {
//             if (Get.isDialogOpen == true) Get.back();
//             await submitPayment(totalAmount);
//           },
//           child: const Text("Proceed",
//               style: TextStyle(color: Colors.white, fontSize: 15)),
//         ),
//       ],
//     );
//   }

//   /// Dummy Payment Submission
//   Future<void> submitPayment(double totalAmount) async {
//     try {
//       isLoading(true);
//       await Future.delayed(const Duration(seconds: 2));
//       Get.snackbar("Success", "Payment Successful for ₹$totalAmount",
//           backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
//       Get.back();
//     } catch (e) {
//       Get.snackbar("Error", "Payment failed. Try again later.",
//           backgroundColor: Colors.redAccent, colorText: Colors.white);
//     } finally {
//       isLoading(false);
//     }
//   }
// }
import 'dart:convert';
import 'package:aesera_jewels/Api/base_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GoldCoinPaymentController extends GetxController {
  var goldRate = 0.0.obs;
  var taxPercent = 0.0.obs;
  var deliveryCharge = 0.0.obs;
  var isLoading = false.obs;

  Future<void> fetchAPIs() async {
    await Future.wait([_fetchGoldRate(), _fetchTax(), _fetchDelivery()]);
  }

  Future<void> _fetchGoldRate() async {
    try {
      final res = await http.get(Uri.parse('${BaseUrl.baseUrl}getCurrentRate'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        goldRate.value = (data["price_gram_24k"] ?? 0).toDouble();
      }
    } catch (_) {}
  }

  Future<void> _fetchTax() async {
    try {
      final res = await http.get(Uri.parse('${BaseUrl.baseUrl}getTax'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data["status"] == true) {
          taxPercent.value = (data["data"]["percentage"] ?? 0).toDouble();
        }
      }
    } catch (_) {}
  }

  Future<void> _fetchDelivery() async {
    try {
      final res =
          await http.get(Uri.parse('${BaseUrl.baseUrl}getDeliveryCharge'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data["status"] == true) {
          deliveryCharge.value = (data["data"]["amount"] ?? 0).toDouble();
        }
      }
    } catch (_) {}
  }

  void confirmPayment(double totalAmount) {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: "Confirm Payment",
      middleText:
          "Do you want to proceed with the payment of ₹${totalAmount.toStringAsFixed(2)}?",
      barrierDismissible: false,
      titleStyle: const TextStyle(
          color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
      middleTextStyle: const TextStyle(color: Colors.black87, fontSize: 16),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFB700)),
          onPressed: () {
            if (Get.isDialogOpen == true) Get.back();
          },
          child: const Text("Cancel",
              style: TextStyle(color: Colors.black, fontSize: 15)),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A2A4D)),
          onPressed: () async {
            if (Get.isDialogOpen == true) Get.back();
            await submitPayment(totalAmount);
          },
          child: const Text("Proceed",
              style: TextStyle(color: Colors.white, fontSize: 15)),
        ),
      ],
    );
  }

  Future<void> submitPayment(double totalAmount) async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar("Success", "Payment Successful for ₹$totalAmount",
          backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
      Get.back();
    } catch (e) {
      Get.snackbar("Error", "Payment failed. Try again later.",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }
}
