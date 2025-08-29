
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

// mixin XFile {
//   var path;
// }
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:aesera_jewels/modules/investment_details/portfolio_view.dart';
// If InvestmentScreen is in another file, import it here:
// import 'package:aesera_jewels/modules/investment_details/investment_screen.dart';

class PaymentController extends GetxController {
  // State variables
  var selectedTab = 0.obs; // 0 = Own Number, 1 = Others Number
  var isLoading = false.obs;
  Rx<XFile?> screenshot = Rx<XFile?>(null);

  // Text field controllers
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final picker = ImagePicker();

  void switchTab(int index) {
    selectedTab.value = index;
    mobileController.clear();
    screenshot.value = null;
  }

  Future<void> pickImageSource() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) screenshot.value = image;
  }

  Future<void> submitPayment({required String sourceScreen}) async {
    String amount = amountController.text.trim();
    String mobile =
        selectedTab.value == 0 ? "9788683381" : mobileController.text.trim();

    // 🔹 Validations
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
      final uri = Uri.parse('http://13.204.96.244:3000/api/create-payment');
      final body = jsonEncode({"mobile": mobile, "amount": amount});

      print("📤 Sending request to: $uri");
      print("📦 Body: $body");

      var response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      isLoading.value = false;

      print("📥 Response Code: ${response.statusCode}");
      print("📥 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Payment submitted successfully");

        if (sourceScreen == "catalog") {
          Get.offAll(() => InvestmentDetailScreen(initialTabIndex: 2)); // Purchased tab
        } else if (sourceScreen == "buy_gold") {
          Get.offAll(() => InvestmentDetailScreen(initialTabIndex: 0)); // Paid tab
        }
      } else {
        Get.snackbar("Error", "Failed: ${response.reasonPhrase}");
      }
    } catch (e) {
      isLoading.value = false;
      print("❌ Exception: $e");
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }
}
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart' as http;
// import '../investment_details/portfolio_view.dart';

// class PaymentController extends GetxController {
//   var selectedTab = 0.obs;
//   var isLoading = false.obs;

//   Rx<File?> uploadedFile = Rx<File?>(null);

//   final mobileController = TextEditingController();
//   final amountController = TextEditingController();

//   final picker = ImagePicker();
//   late String source;

//   @override
//   void onInit() {
//     //super.onInit();
//     final args = Get.arguments ?? {};
//     amountController.text = args["amount"]?.toString() ?? "";
//     source = args["source"] ?? "";
//   }

//   void switchTab(int index) {
//     selectedTab.value = index;
//     mobileController.clear();
//     uploadedFile.value = null;
//   }

//   Future<void> pickUploadOption() async {
//     Get.bottomSheet(Container(
//       padding: const EdgeInsets.all(16),
//       child: Wrap(children: [
//         ListTile(
//           leading: const Icon(Icons.image),
//           title: const Text("Pick from Gallery"),
//           onTap: () async {
//             final picked = await picker.pickImage(source: ImageSource.gallery);
//             if (picked != null) uploadedFile.value = File(picked.path);
//             Get.back();
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.camera_alt),
//           title: const Text("Capture with Camera"),
//           onTap: () async {
//             final picked = await picker.pickImage(source: ImageSource.camera);
//             if (picked != null) uploadedFile.value = File(picked.path);
//             Get.back();
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.attach_file),
//           title: const Text("Upload File"),
//           onTap: () async {
//             FilePickerResult? result =
//                 await FilePicker.platform.pickFiles();
//             if (result != null) {
//               uploadedFile.value = File(result.files.single.path!);
//             }
//             Get.back();
//           },
//         ),
//       ]),
//     ));
//   }

//   Future<void> submitPayment({required String sourceScreen}) async {
//     String amount = amountController.text.trim();
//     String mobile =
//         selectedTab.value == 0 ? "9788683381" : mobileController.text.trim();

//     if (amount.isEmpty) {
//       Get.snackbar("Error", "Please enter amount");
//       return;
//     }
//     if (selectedTab.value == 1 &&
//         (!RegExp(r'^\d{10}$').hasMatch(mobile))) {
//       Get.snackbar("Error", "Enter valid 10-digit mobile number");
//       return;
//     }

//     isLoading.value = true;
//     try {
//       var request = http.Request(
//           'POST', Uri.parse('http://13.204.96.244:3000/api/create-payment'));
//       request.body = json.encode({"mobile": mobile, "amount": amount});
//       request.headers['Content-Type'] = 'application/json';

//       var response = await request.send();
//       isLoading.value = false;

//       if (response.statusCode == 200) {
//         Get.snackbar("Success", "Payment submitted");

//         if (source == "catalog") {
//           Get.offAll(() => InvestmentScreen(initialTabIndex: 2));
//         } else if (source == "buy_gold") {
//           Get.offAll(() => InvestmentScreen(initialTabIndex: 0));
//         }
//       } else {
//         Get.snackbar("Error", "Failed: ${response.reasonPhrase}");
//       }
//     } catch (e) {
//       isLoading.value = false;
//       Get.snackbar("Error", "Something went wrong: $e");
//     }
//   }
// }

// Future<void> InvestmentScreen({required int initialTabIndex}) async {
// }
