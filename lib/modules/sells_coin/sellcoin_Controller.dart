import 'dart:convert';
import 'package:aesera_jewels/Api/base_url.dart';
import 'package:aesera_jewels/models/sellmodel.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SellcoinController extends GetxController {
  var isLoading = false.obs;
  var isRupeesSelected = true.obs;
  var selectedQuick = ''.obs; // stores the currently selected quick option

  Rx<SellModel> sellData = SellModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchSellData();
  }

  void toggle(bool isRupees) {
    isRupeesSelected.value = isRupees;
    selectedQuick.value = '';
  }

  void selectQuick(String value) {
    selectedQuick.value = value;
  }

  Future<void> fetchSellData() async {
    try {
      isLoading(true);

      /// ✅ Get logged-in user's mobile number
      String? mobile = await StorageService.getMobileAsync();

      if (mobile == null || mobile.isEmpty) {
        print("❌ Mobile number not found in storage");
        return;
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtb2JpbGUiOiI3NDgzNzIwMzM1IiwibmFtZSI6ImthbXBhbGxpIG0iLCJpYXQiOjE3Njc5NTI3ODcsImV4cCI6MTc2ODEyNTU4N30.kq5Bw3wB-5Gparo9T2Bhcg3zy0XI5xoHSEvRpxAsFZI',
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

  String get displayValue {
    if (isRupeesSelected.value) {
      return sellData.value.totalAmount ?? "0";
    } else {
      return sellData.value.totalGrams ?? "0";
    }
  }

  get isRupees => null;

  void toggleUnit(bool isRupees) {}
}
