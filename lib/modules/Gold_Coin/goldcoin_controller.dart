
import 'dart:convert';
import 'package:aesera_jewels/Api/base_url.dart';
import 'package:aesera_jewels/models/gold_rate_model.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GoldCoinController extends GetxController {
  var goldRate = Rxn<GoldRateModel>();
  var isLoadingRate = false.obs;

  final List<double> weights = [1, 2, 4, 10];
  var coinCount = <int, int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentGoldRate();
    for (int i = 0; i < weights.length; i++) {
      coinCount[i] = 0;
    }
  }

  /// ✅ Fetch gold rate per gram dynamically from API
  Future<void> fetchCurrentGoldRate() async {
    try {
      isLoadingRate(true);
      var request = http.Request(
          'GET', Uri.parse('${BaseUrl.baseUrl}getCurrentRate'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final data = jsonDecode(await response.stream.bytesToString());
        goldRate.value = GoldRateModel.fromJson(data);

        if (goldRate.value != null) {
          await StorageService.saveGoldRate(
            goldRate.value!.priceGram24k.toString(),
          );
        }
      } else {
        Get.snackbar("Error", "Failed to load gold rate");
      }
    } catch (e) {
      Get.snackbar("Error", "Please check your internet connection");
    } finally {
      isLoadingRate(false);
    }
  }

  /// ✅ Calculate coin price based on live rate per gram
  double getCoinPrice(double weight) {
    if (goldRate.value == null) return 0.0;
    final ratePerGram = goldRate.value!.priceGram24k;
    return ratePerGram * weight;
  }

  void increaseCount(int index) {
    coinCount[index] = (coinCount[index] ?? 0) + 1;
  }

  void decreaseCount(int index) {
    final current = coinCount[index] ?? 0;
    if (current > 0) coinCount[index] = current - 1;
  }

  double getTotalWeightForCoin(int index) {
    final count = coinCount[index] ?? 0;
    return weights[index] * count;
  }

  /// ✅ Get only selected coins (non-zero quantities)
  List<Map<String, dynamic>> getSelectedCoins() {
    List<Map<String, dynamic>> selected = [];
    coinCount.forEach((index, qty) {
      if (qty > 0) {
        selected.add({
          "weight": weights[index],
          "pieces": qty,
        });
      }
    });
    return selected;
  }
}
