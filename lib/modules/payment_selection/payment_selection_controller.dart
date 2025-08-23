import 'package:aesera_jewels/modules/investment_details/portfolio_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PaymentController extends GetxController {
  var selectedTab = 0.obs;
  //var selectedTab = 2.obs;

  // Text field controllers
  TextEditingController mobileController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  // Image picker
  final ImagePicker picker = ImagePicker();
  Rx<XFile?> screenshot = Rx<XFile?>(null);

  void switchTab(int index) {
    selectedTab.value = index;
    selectedTab.value = index;
    amountController.clear();
    mobileController.clear();
    screenshot.value = null;
  }

  Future<void> pickImageSource() async {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Get.back();
                final image = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  screenshot.value = image;
                  Get.snackbar("Success", "Image selected from camera.");
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Gallery'),
              onTap: () async {
                Get.back();
                final image = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  screenshot.value = image;
                  Get.snackbar("Success", "Image selected from gallery.");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void submitPayment() {
    String amount = amountController.text.trim();
    String mobile = mobileController.text.trim();

    if (selectedTab.value == 1 && mobile.isEmpty) {
      Get.snackbar("Missing Info", "Please enter payment mobile number.");
      return;
    }

    if (amount.isEmpty) {
      Get.snackbar("Missing Info", "Please enter amount paid.");
      return;
    }

    // Print for debugging
    print("Tab: ${selectedTab.value}");
    // print("Tab: ${selectedTab.value}");
    print("Mobile: $mobile");
    print("Amount: $amount");
    print("Screenshot: ${screenshot.value?.path}");

    // Proceed to next screen
    Get.to(() => InvestmentScreen());
  }
}
