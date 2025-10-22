// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AddAddressController extends GetxController {

//   /// Text controllers for form fields
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController postalCodeController = TextEditingController();

//   /// Loading state for button
//   RxBool isLoading = false.obs;
//  final userMobile = ''.obs;
//   final userToken = ''.obs;
//   final userName = ''.obs;

//   /// Add a new address (API integration can go here)
//   Future<void> addAddress(
//       String name, String address, String city, String postalCode) async {
//     isLoading.value = true;
//     try {
//       // TODO: Replace with your actual API service call
//       await Future.delayed(const Duration(seconds: 2));

//       Get.snackbar(
//         "Success",
//         "Address added successfully",
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );

//       // After adding, go back to previous screen
//       Get.back(result: true);
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Failed to add address",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   /// Update existing address
//   Future<void> updateAddress(
//       String id, String name, String address, String city, String postalCode) async {
//     isLoading.value = true;
//     try {
//       // TODO: Replace with your actual API service call
//       await Future.delayed(const Duration(seconds: 2));

//       Get.snackbar(
//         "Success",
//         "Address updated successfully",
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );

//       // After updating, go back to previous screen
//       Get.back(result: true);
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Failed to update address",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   /// Clean up text controllers when screen is closed
//   @override
//   void onClose() {
//     nameController.dispose();
//     addressController.dispose();
//     cityController.dispose();
//     postalCodeController.dispose();
//     super.onClose();
//   }
// }
import 'dart:convert';
import 'package:aesera_jewels/Api/base_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:aesera_jewels/modules/address/address_screen.dart';

class AddAddressController extends GetxController {
  /// Text controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  /// Loading state
  RxBool isLoading = false.obs;

  /// User info from storage
  final userId = ''.obs;
  final userToken = ''.obs;
  final userName = ''.obs;
  final userMobile = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  /// ✅ Load user data from storage (async safe)
  Future<void> _loadUserData() async {
    userId.value = await StorageService.getUserId() ?? '';
    userToken.value = await StorageService.getTokenAsync() ?? '';
    userName.value = await StorageService.getUserName() ?? '';
    userMobile.value = await StorageService.getMobileAsync() ?? '';
  }

  /// ✅ Submit address API
  Future<void> addAddress() async {
    final name = nameController.text.trim();
    final address = addressController.text.trim();
    final city = cityController.text.trim();
    final postalCode = postalCodeController.text.trim();

    // Validation
    if (name.isEmpty || address.isEmpty || city.isEmpty || postalCode.isEmpty) {
      Get.snackbar("Validation", "All fields are required",
          backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
      return;
    }
    if (postalCode.length != 6) {
      Get.snackbar("Validation", "Postal code must be 6 digits",
         backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${userToken.value}',
      };

      final body = json.encode({
        "userid": userId.value,
        "name": name,
        "address": address,
        "city": city,
        "postalCode": postalCode,
      });

      final request = http.Request(
        'POST',
        Uri.parse('${BaseUrl.baseUrl}addDeliveryAddress'),
      );
      request.body = body;
      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200|| response.statusCode == 201 ) {
        final responseData = jsonDecode(await response.stream.bytesToString());

        Get.snackbar("Success",
            responseData["message"] ?? "Address added successfully",
           backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
            print(responseData);

        /// ✅ Go back to AddressScreen
        Get.offAll(() => AddressScreen());
      } else {
        Get.snackbar("Error",
            response.reasonPhrase ?? "Failed to add address",
           backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar( "Error",
    " please check your internet connection",
        backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
//  } catch (e) {
//   isLoading.value = false;
//   Get.snackbar(
//     "Error",
//     "Something went wrong: $e, please check your internet connection",backgroundColor: const Color(0xFF09243D),
//           colorText: Colors.white,
//   );
// }
  /// Clean up
  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    super.onClose();
  }
}
