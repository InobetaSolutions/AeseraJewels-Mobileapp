import 'dart:convert';
import 'package:aesera_jewels/Api/base_url.dart';
import 'package:aesera_jewels/models/gold_rate_model.dart';
import 'package:aesera_jewels/models/sellmodel.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SellsummaryContoller extends GetxController {
  var isLoading = false.obs;
  var taxPercentage = 0.obs;
  var deliveryCharge = 0.obs;
  var goldRate = Rxn<GoldRateModel>();
  var isLoadingRate = true.obs;
  var isOffline = false.obs;
  var paymentGatewayCharge = 0.obs;

  Rx<SellModel> sellData = SellModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchTax();
    fetchDeliveryCharge();
    fetchPaymentGatewayCharge();
    fetchCurrentGoldRate();
    fetchSellData(); // Add this line
  }
  // var isLoading = false.obs;
  // var taxPercentage = 0.obs;
  // var deliveryCharge = 0.obs;

  // var goldRate = Rxn<GoldRateModel>();
  // var isLoadingRate = true.obs;
  // var isOffline = false.obs;

  // // 🔥 Payment Gateway Charge
  // var paymentGatewayCharge = 0.obs;

  // Rx<SellModel> sellData = SellModel().obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchTax();
  //   fetchDeliveryCharge();
  //   fetchPaymentGatewayCharge(); // 🔥 new API
  //   fetchCurrentGoldRate();
  // }

  /// ✅ Fetch Gold Rate
  Future<void> fetchCurrentGoldRate() async {
    try {
      isLoadingRate(true);

      if (isOffline.value) {
        final savedRate = await StorageService.getGoldRate();
        if (savedRate != null) {
          goldRate.value = GoldRateModel(
            id: "cached",
            timestamp: DateTime.now().millisecondsSinceEpoch,
            priceGram24k: double.parse(savedRate),
            istDate: DateTime.now().toString(),
          );
        }
        return;
      }

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
        Get.snackbar('Error', 'Failed to fetch gold rate');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        "Please check your internet connection",
        backgroundColor: const Color(0xFF09243D),
        colorText: Colors.white,
      );
    } finally {
      isLoadingRate(false);
    }
  }

  Future<void> fetchSellData() async {
    try {
      isLoading(true);

      /// ✅ Get logged-in user's mobile number
      String? mobile = await StorageService.getMobileAsync();
      String? token = await StorageService.getTokenAsync();

      if (mobile == null || mobile.isEmpty) {
        print("❌ Mobile number not found in storage");
        return;
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': token != null ? 'Bearer $token' : '',
      };

      var request = http.Request(
        'POST',
        Uri.parse("${BaseUrl.baseUrl}getpaymenthistory"),
      );

      /// ✅ Send logged-in user's mobile
      request.body = json.encode({"mobile": mobile});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var jsonData = json.decode(responseData);
        print("Sell Data: $jsonData");
        sellData.value = SellModel.fromJson(jsonData);
      } else {
        print("API Error: ${response.statusCode}");
      }
    } catch (e) {
      print("API Error: $e");
    } finally {
      isLoading(false);
    }
  }

  /// 🔥 TAX
  Future<void> fetchTax() async {
    try {
      final response = await http.get(Uri.parse("${BaseUrl.baseUrl}getTax"));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        print("Tax JSON: $jsonData");
        final tax = TaxModel.fromJson(jsonData);
        taxPercentage.value = tax.percentage;
      }
    } catch (e) {
      print("Tax API error: $e");
    }
  }

  /// 🔥 DELIVERY
  Future<void> fetchDeliveryCharge() async {
    try {
      final response = await http.get(
        Uri.parse("${BaseUrl.baseUrl}getDeliveryCharge"),
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final charge = DeliveryChargeModel.fromJson(jsonData);
        deliveryCharge.value = charge.amount;
      }
    } catch (e) {
      print("Delivery API error: $e");
    }
  }

  /// 🔥 PAYMENT GATEWAY
  Future<void> fetchPaymentGatewayCharge() async {
    try {
      final response = await http.get(
        Uri.parse("${BaseUrl.baseUrl}getPaymentGatewayCharges"),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print("Payment Gateway JSON: $jsonData");
        final gateway = PaymentGatewayModel.fromJson(jsonData);
        paymentGatewayCharge.value = gateway.value;
      }
    } catch (e) {
      print("Gateway API error: $e");
    }
  }

  Future<void> proceedToPay({
    required bool isRupees,
    required String value,
  }) async {
    try {
      isLoading.value = true;

      final mobile = await StorageService.getMobileAsync();
      final token = await StorageService.getTokenAsync();

      double amount = 0;
      double gram = 0;

      if (isRupees) {
        // When selling in rupees
        amount = double.tryParse(value) ?? 0;
        // Calculate grams from rupees using current gold rate
        if (goldRate.value != null && goldRate.value!.priceGram24k > 0) {
          gram = amount / goldRate.value!.priceGram24k;
        } else {
          // If no gold rate available, use 0 or handle error
          gram = 0;
        }
      } else {
        // When selling in grams
        gram = double.tryParse(value) ?? 0;
        // Calculate amount from grams using current gold rate
        if (goldRate.value != null && goldRate.value!.priceGram24k > 0) {
          amount = gram * goldRate.value!.priceGram24k;
        } else {
          // If no gold rate available, use 0 or handle error
          amount = 0;
        }
      }

      final double gst = (amount * taxPercentage.value) / 100;

      final body = {
        "mobileNumber": mobile,
        "amount": amount == 0 ? "" : amount.toStringAsFixed(2),
        "gram": gram == 0 ? "" : gram.toStringAsFixed(4),
        "paymentGatewayCharges": paymentGatewayCharge.value,
        "taxAmount": gst.toStringAsFixed(2), // This is GST of gold value
        "deliveryCharges": deliveryCharge.value,
      };

      print("Sell Payment Body: $body");

      final response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}createSellPayment"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode(body),
      );

      print("Sell Payment Response Status: ${response.statusCode}");
      print("Sell Payment Response Body: ${response.body}");

      final decoded = jsonDecode(response.body);
      final backendMessage = decoded["message"] ?? "Something went wrong";

      // ✅ If API call succeeded
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          backendMessage,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return;
      }

      // ❌ Any validation / business rule error from backend
      Get.snackbar(
        "Failed",
        backendMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      print("Sell Payment Error: $e");
      Get.snackbar(
        "Error",
        "Network error. Please try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> proceedToPay({
  //   required bool isRupees,
  //   required String value,
  // }) async {
  //   try {
  //     isLoading.value = true;

  //     final mobile = await StorageService.getMobileAsync();
  //     final token = await StorageService.getTokenAsync();

  //     double amount = 0;
  //     double gram = 0;

  //     if (isRupees) {
  //       amount = double.tryParse(value) ?? 0;
  //     } else {
  //       gram = double.tryParse(value) ?? 0;
  //     }

  //     final double gst = (amount * taxPercentage.value) / 100;

  //     final body = {
  //       "mobileNumber": mobile,
  //       "amount": amount == 0 ? "" : amount.toStringAsFixed(2),
  //       "gram": gram == 0 ? "" : gram.toStringAsFixed(4),
  //       "paymentGatewayCharges": paymentGatewayCharge.value,
  //       "taxAmount": gst,
  //       "deliveryCharges": deliveryCharge.value,
  //     };

  //     print("Sell Payment Body: $body");

  //     final response = await http.post(
  //       Uri.parse("${BaseUrl.baseUrl}createSellPayment"),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Authorization": "Bearer $token",
  //       },
  //       body: json.encode(body),
  //     );

  //     print("Sell Payment Response Status: ${response.statusCode}");
  //     print("Sell Payment Response Body: ${response.body}");

  //     final decoded = jsonDecode(response.body);
  //     final backendMessage = decoded["message"] ?? "Something went wrong";

  //     // ✅ If API call succeeded
  //     if (response.statusCode == 200) {
  //       Get.snackbar(
  //         "Success",
  //         backendMessage, // or "Sold Successfully" if you want static
  //         backgroundColor: Colors.green,
  //         colorText: Colors.white,
  //       );
  //       return;
  //     }

  //     // ❌ Any validation / business rule error from backend
  //     Get.snackbar(
  //       "Failed",
  //       backendMessage, // 👈 This shows: "Amount exceeds the total limit of 37700."
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   } catch (e) {
  //     print("Sell Payment Error: $e");
  //     Get.snackbar(
  //       "Error",
  //       "Network error. Please try again.",
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // /// 🔥 SELL PAYMENT - FIXED TO SHOW "SOLD SUCCESSFULLY"
  // Future<void> proceedToPay({
  //   required bool isRupees,
  //   required String value,
  // }) async {
  //   try {
  //     isLoading.value = true;

  //     final mobile = await StorageService.getMobileAsync();
  //     final token = await StorageService.getTokenAsync();

  //     double amount = 0;
  //     double gram = 0;

  //     if (isRupees) {
  //       amount = double.tryParse(value) ?? 0;
  //       gram = 0;
  //     } else {
  //       gram = double.tryParse(value) ?? 0;
  //       amount = 0;
  //     }

  //     double calculatedTax = (amount * taxPercentage.value) / 100;

  //     final body = {
  //       "mobileNumber": mobile,
  //       "amount": amount == 0 ? "" : amount.toStringAsFixed(2), // must be ""
  //       "gram": gram == 0 ? "" : gram.toStringAsFixed(4),
  //       "paymentGatewayCharges": paymentGatewayCharge.value, // number
  //       "taxAmount": calculatedTax, // number, not string
  //       "deliveryCharges": deliveryCharge.value, // correct key
  //     };

  //     print("Sell Payment Body: $body");

  //     final headers = {
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer $token",
  //     };

  //     final response = await http.post(
  //       Uri.parse("${BaseUrl.baseUrl}createSellPayment"),
  //       headers: headers,
  //       body: json.encode(body),
  //     );

  //     print("Sell Payment Response Status: ${response.statusCode}");
  //     print("Sell Payment Response Body: ${response.body}");

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);

  //       // Always show "Sold Successfully" when API call is successful
  //       Get.snackbar(
  //         "Success",
  //         "Sold Successfully",
  //         backgroundColor: Colors.green,
  //         colorText: Colors.white,
  //         duration: Duration(seconds: 3),
  //       );

  //       // Optional: You can also show the API message if you want
  //       print("API Message: ${data["message"]}");
  //     } else if (response.statusCode == 400) {
  //       Get.snackbar(
  //         "Error",
  //         "Bad Request. Please check your input.",
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //       );
  //     } else if (response.statusCode == 401) {
  //       Get.snackbar(
  //         "Error",
  //         "Unauthorized. Please login again.",
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //       );
  //     } else if (response.statusCode == 500) {
  //       Get.snackbar(
  //         "Error",
  //         "Server Error. Please try again later.",
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //       );
  //     } else {
  //       Get.snackbar(
  //         "Error",
  //         "Something went wrong. Status Code: ${response.statusCode}",
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //       );
  //     }
  //   } catch (e) {
  //     print("Sell Payment Error: $e");
  //     Get.snackbar(
  //       "Error",
  //       "Network Error: ${e.toString()}",
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
