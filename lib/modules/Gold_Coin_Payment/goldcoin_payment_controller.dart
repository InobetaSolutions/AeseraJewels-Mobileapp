// import 'dart:convert';
// import 'package:aesera_jewels/Api/base_url.dart';
// import 'package:aesera_jewels/models/gold_rate_model.dart';
// import 'package:aesera_jewels/models/goldcoin_payment_model.dart';
// import 'package:aesera_jewels/services/storage_service.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class GoldCoinPaymentController extends GetxController {
//   final GoldCoinPaymentModel summary;
//   GoldCoinPaymentController(this.summary);

//   var goldRate = Rxn<GoldRateModel>();
//   var gstPercentage = 0.0.obs;
//   var gstAmount = 0.0.obs;
//   var deliveryCharge = 0.0.obs;
//   var totalPayable = 0.0.obs;
//   var isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchCurrentGoldRate();
//     fetchTax();
//     fetchDeliveryCharge();
//   }

//   Future<void> fetchCurrentGoldRate() async {
//     try {
//       final url = Uri.parse('${BaseUrl.baseUrl}getCurrentRate');
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         goldRate.value = GoldRateModel.fromJson(data);
//       }
//     } catch (_) {}
//   }

//   Future<void> fetchTax() async {
//     try {
//       final headers = await StorageService().getAuthHeaders();
//       final url = Uri.parse("${BaseUrl.baseUrl}getTax");
//       final request = http.Request('GET', url);
//       request.headers.addAll(headers);
//       final response = await request.send();

//       if (response.statusCode == 200) {
//         final resString = await response.stream.bytesToString();
//         final data = jsonDecode(resString);
//         gstPercentage.value = (data["data"]["percentage"] ?? 0).toDouble();
//         gstAmount.value = (summary.totalAmount * gstPercentage.value) / 100;
//         totalPayable.value = summary.totalAmount + gstAmount.value;
//       }
//     } catch (_) {}
//   }

//   Future<void> fetchDeliveryCharge() async {
//     try {
//       final response = await http.get(Uri.parse('${BaseUrl.baseUrl}getDeliveryCharge'));
//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         if (jsonData["status"] == true) {
//           deliveryCharge.value = (jsonData["data"]["amount"] ?? 0).toDouble();
//           totalPayable.value += deliveryCharge.value;
//         }
//       }
//     } catch (_) {}
//   }

//   void confirmPayment() {
//     Get.defaultDialog(
//       title: "Confirm Payment",
//       middleText: "Proceed with final payment?",
//       onConfirm: () {
//         Get.back();
//       },
//       onCancel: () => Get.back(),
//     );
//   }
// }
import 'dart:convert';
import 'package:aesera_jewels/Api/base_url.dart';
import 'package:aesera_jewels/models/gold_rate_model.dart';
import 'package:aesera_jewels/models/goldcoin_payment_model.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class GoldCoinPaymentController extends GetxController {
  final GoldCoinPaymentModel paymentModel;
  GoldCoinPaymentController(this.paymentModel);

  // States
  var isLoading = false.obs;
  var isLoadingRate = false.obs;

  // Gold Rate
  var goldRate = Rxn<GoldRateModel>();

  // GST
  var gstPercentage = 0.0.obs;
  var gstAmount = 0.0.obs;

  // Delivery charge
  var deliveryCharge = 0.0.obs;

  // Total payable
  var totalPayable = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentGoldRate();
    fetchTax();
    fetchDeliveryCharge();
  }

  /// ✅ Fetch Gold Rate
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
      calculateTotals();
    }
  }

  /// ✅ Fetch GST
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
        double percentage = (data["data"]["percentage"] ?? 0).toDouble();
        gstPercentage.value = percentage;
        calculateTotals();
      }
    } catch (e) {
      debugPrint("Error fetching tax: $e");
    }
  }

  /// ✅ Fetch Delivery Charge
  Future<void> fetchDeliveryCharge() async {
    try {
      var request =
          http.Request('GET', Uri.parse('${BaseUrl.baseUrl}getDeliveryCharge'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(await response.stream.bytesToString());
        if (jsonData["status"] == true) {
          deliveryCharge.value = (jsonData["data"]["amount"] ?? 0).toDouble();
          calculateTotals();
        }
      }
    } catch (e) {
      debugPrint("Error fetching delivery charge: $e");
    }
  }

  /// ✅ Calculate all totals dynamically
  void calculateTotals() {
    if (goldRate.value == null) return;
    double baseValue =
        paymentModel.totalGrams * goldRate.value!.priceGram24k.toDouble();
    double gstVal = (baseValue * gstPercentage.value) / 100;
    double total = baseValue + gstVal + deliveryCharge.value;

    gstAmount.value = gstVal;
    totalPayable.value = total;
  }

  /// ✅ Payment confirmation popup
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
              backgroundColor: const Color(0xFFFFB700)),
          onPressed: () => Get.back(),
          child: const Text("Cancel",
              style: TextStyle(color: Colors.black, fontSize: 15)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A2A4D)),
          onPressed: () {
            Get.back();
            Get.snackbar("Success", "Payment confirmed!",
                backgroundColor: const Color(0xFF09243D),
                colorText: Colors.white);
          },
          child:
              const Text("OK", style: TextStyle(color: Colors.white, fontSize: 15)),
        ),
      ],
    );
  }
}
