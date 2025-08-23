

// ignore_for_file: unnecessary_import

import 'package:aesera_jewels/modules/welcome_screen3/jewels_for_occasion_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class JewelsForOccasionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JewelsForOccasionController());
  }
}
