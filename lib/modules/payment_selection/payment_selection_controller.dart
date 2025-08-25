
// import 'dart:convert';
// import 'package:aesera_jewels/modules/investment_details/portfolio_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;

// //  Ensure XFile is imported for image picking functionality

// class PaymentController extends GetxController {
//   // State variables
//   var selectedTab = 0.obs; // 0 = Own Number, 1 = Others Number
//   var isLoading = false.obs;
//   Rx<XFile?> screenshot = Rx<XFile?>(null);

//   // Text field controllers
//   final TextEditingController mobileController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();

//   final picker = ImagePicker();

//   void switchTab(int index) {
//     selectedTab.value = index;
//     mobileController.clear();
//     screenshot.value = null;
//   }

//   Future<void> pickImageSource() async {
//     final image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) screenshot.value = image;
//   }

//   Future<void> submitPayment({required String sourceScreen}) async {
//     String amount = amountController.text.trim();
//     String mobile =
//         selectedTab.value == 0 ? "9788683381" : mobileController.text.trim();

//     // 🔹 Validations
//     if (amount.isEmpty) {
//       Get.snackbar("Error", "Please enter amount");
//       return;
//     }
//     if (selectedTab.value == 1) {
//       if (mobile.isEmpty) {
//         Get.snackbar("Error", "Please enter mobile number");
//         return;
//       }
//       if (!RegExp(r'^\d{10}$').hasMatch(mobile)) {
//         Get.snackbar("Error", "Mobile number must be 10 digits");
//         return;
//       }
//     }

//     isLoading.value = true;
//     try {
//       final uri = Uri.parse('http://13.204.96.244:3000/api/create-payment');
//       final body = jsonEncode({"mobile": mobile, "amount": amount});

//       print("📤 Sending request to: $uri");
//       print("📦 Body: $body");

//       var response = await http.post(
//         uri,
//         headers: {'Content-Type': 'application/json'},
//         body: body,
//       );

//       isLoading.value = false;

//       print("📥 Response Code: ${response.statusCode}");
//       print("📥 Response Body: ${response.body}");

//       if (response.statusCode == 200) {
//         Get.snackbar("Success", "Payment submitted successfully");

//         if (sourceScreen == "catalog") {
//           Get.offAll(() => InvestmentScreen(initialTabIndex: 2)); // Purchased tab
//         } else if (sourceScreen == "buy_gold") {
//           Get.offAll(() => InvestmentScreen(initialTabIndex: 0)); // Paid tab
//         }
//       } else {
//         Get.snackbar("Error", "Failed: ${response.reasonPhrase}");
//       }
//     } catch (e) {
//       isLoading.value = false;
//       print("❌ Exception: $e");
//       Get.snackbar("Error", "Something went wrong: $e");
//     }
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:aesera_jewels/modules/investment_details/portfolio_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class PaymentController extends GetxController {
  var selectedTab = 0.obs; // 0 = Own Number, 1 = Others Number
  var isLoading = false.obs;

  // File upload
  Rx<File?> uploadedFile = Rx<File?>(null);

  // Text field controllers
  final mobileController = TextEditingController();
  final amountController = TextEditingController();

  final picker = ImagePicker();

  void switchTab(int index) {
    selectedTab.value = index;
    mobileController.clear();
    uploadedFile.value = null;
  }

  // 🔹 Choose upload option
  Future<void> pickUploadOption() async {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.image, color: Colors.blue),
              title: const Text("Pick Image from Gallery"),
              onTap: () async {
                final picked = await picker.pickImage(source: ImageSource.gallery);
                if (picked != null) uploadedFile.value = File(picked.path);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.green),
              title: const Text("Capture Image with Camera"),
              onTap: () async {
                final picked = await picker.pickImage(source: ImageSource.camera);
                if (picked != null) uploadedFile.value = File(picked.path);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_file, color: Colors.purple),
              title: const Text("Pick File (PDF, Doc, etc.)"),
              onTap: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles();
                if (result != null) uploadedFile.value = File(result.files.single.path!);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 API submission using http.Request (like your snippet)
  Future<void> submitPayment({required String sourceScreen}) async {
    String amount = amountController.text.trim();
    String mobile =
        selectedTab.value == 0 ? "9788683381" : mobileController.text.trim();

    // validations
    if (amount.isEmpty) {
      Get.snackbar("Error", "Please enter amount");
      return;
    }
    if (selectedTab.value == 1) {
      if (mobile.isEmpty) {
        Get.snackbar("Error", "Please enter mobile number");
        return;
      }
      if (!RegExp(r'^\d{10}$').hasMatch(mobile)) {
        Get.snackbar("Error", "Mobile number must be 10 digits");
        return;
      }
    }

    isLoading.value = true;
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
        'POST',
        Uri.parse('http://13.204.96.244:3000/api/create-payment'),
      );

      request.body = json.encode({
        "mobile": mobile,
        "amount": amount, // sending as string like your snippet
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      isLoading.value = false;

      if (response.statusCode == 200) {
        String result = await response.stream.bytesToString();
        Get.snackbar("Success", "Payment submitted successfully");

        // ✅ redirect logic
        if (sourceScreen == "catalog") {
          Get.offAll(() => InvestmentScreen(initialTabIndex: 2));
        } else if (sourceScreen == "buy_gold") {
          Get.offAll(() => InvestmentScreen(initialTabIndex: 0));
        }

        print("Response: $result"); // optional debug
      } else {
        Get.snackbar("Error", "Failed: ${response.reasonPhrase}");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  @override
  void onClose() {
    mobileController.dispose();
    amountController.dispose();
    super.onClose();
  }
}
