import 'package:aesera_jewels/models/summary_model.dart';
import 'package:aesera_jewels/modules/summary/summary_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SummaryController>(() => SummaryController(Summary as SummaryModel));
  }
}
