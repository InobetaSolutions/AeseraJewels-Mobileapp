
// import 'dart:convert';
// import 'package:aesera_jewels/models/Addresses_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../../services/storage_service.dart';

// class AddressController extends GetxController {
//   var addresses = <AddressModel>[].obs;
//   var isLoading = false.obs;

//   final nameController = TextEditingController();
//   final addressController = TextEditingController();
//   final cityController = TextEditingController();
//   final postalCodeController = TextEditingController();

//   VoidCallback? submitAddress;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchAddresses();
//   }

//   /// Fetch addresses for current user
//   Future<void> fetchAddresses() async {
//     final userId = StorageService().getUserIdLocal();
//     if (userId == null) {
//       Get.snackbar("Error", "User not logged in",
//           backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }

//     isLoading.value = true;
//     try {
//       final headers = await StorageService().getAuthHeaders();
//       final uri = Uri.parse("http://13.204.96.244:3000/api/getDeliveryAddress");
//       final body = json.encode({"userid": userId});

//       final response = await http.post(uri, headers: headers, body: body);

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         if (jsonData["status"] == "true") {
//           final List data = jsonData["data"];
//           addresses.value = data.map((e) => AddressModel.fromJson(e)).toList();
//           print(response);
//         } else {
//           Get.snackbar("Error", jsonData["message"] ?? "Failed to fetch",
//               backgroundColor: Colors.red, colorText: Colors.white);
//         }
//       } else {
//         Get.snackbar("Error", "Server error: ${response.statusCode}",
//             backgroundColor: Colors.red, colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar("Error", e.toString(),
//           backgroundColor: Colors.red, colorText: Colors.white);
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   /// Update address API
//   Future<void> updateAddress(AddressModel a) async {
//     try {
//       final headers = await StorageService().getAuthHeaders();
//       final uri = Uri.parse("http://13.204.96.244:3000/api/updateDeliveryAddress");
//       final body = json.encode({
//         "addressId": a.id,
//         "name": nameController.text,
//         "address": addressController.text,
//         "city": cityController.text,
//         "postalCode": postalCodeController.text
//       });

//       final response = await http.put(uri, headers: headers, body: body);

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         if (jsonData["status"] == "true") {
//           // Update locally
//           int index = addresses.indexWhere((element) => element.id == a.id);
//           if (index != -1) {
//             addresses[index] = AddressModel(
//               id: a.id,
//               userId: a.userId,
//               name: nameController.text,
//               address: addressController.text,
//               city: cityController.text,
//               postalCode: postalCodeController.text,
//             );
//           }
//           Get.back(); // Close edit dialog
//           Get.snackbar("Success", "Address updated successfully",
//               backgroundColor: Colors.green, colorText: Colors.white);
//               print(response);
//         } else {
//           Get.snackbar("Error", jsonData["message"] ?? "Failed to update",
//               backgroundColor: Colors.red, colorText: Colors.white);
//         }
//       } else {
//         Get.snackbar("Error", "Server error: ${response.statusCode}",
//             backgroundColor: Colors.red, colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar("Error", e.toString(),
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }

//   /// Delete address locally
//   Future<void> deleteAddress(String id) async {
//     addresses.removeWhere((a) => a.id == id);
//     Get.snackbar("Deleted", "Address removed successfully",
//         backgroundColor: Colors.green, colorText: Colors.white);
//   }

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
import 'package:aesera_jewels/models/Addresses_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../services/storage_service.dart';

class AddressController extends GetxController {
  var addresses = <AddressModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  /// Fetch all addresses for the logged-in user
  Future<void> fetchAddresses() async {
    final userId = await StorageService.getUserId();
    if (userId == null || userId.isEmpty) {
      Get.snackbar("Error", "User not logged in",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      // <-- CALL AS INSTANCE -->
      final headers = await StorageService().getAuthHeaders();
      final uri = Uri.parse("http://13.204.96.244:3000/api/getDeliveryAddress");
      final body = json.encode({"userid": userId});

      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData["status"] == "true") {
          final List data = jsonData["data"];
          addresses.value = data.map((e) => AddressModel.fromJson(e)).toList();
        } else {
          Get.snackbar("Error", jsonData["message"] ?? "Failed to fetch",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar("Error", "Server error: ${response.statusCode}",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  /// Update address via API then refresh list
  Future<void> updateAddress(
      AddressModel a, String name, String address, String city, String postal) async {
    // basic validation
    if (name.trim().isEmpty ||
        address.trim().isEmpty ||
        city.trim().isEmpty ||
        postal.trim().isEmpty) {
      Get.snackbar("Validation", "All fields are required",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (postal.trim().length != 6) {
      Get.snackbar("Validation", "Postal code must be 6 digits",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      final headers = await StorageService().getAuthHeaders();
      final uri = Uri.parse("http://13.204.96.244:3000/api/updateDeliveryAddress");
      final body = json.encode({
        "addressId": a.id,
        "name": name,
        "address": address,
        "city": city,
        "postalCode": postal
      });

      final response = await http.put(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData["status"] == "true") {
          Get.back(); // close dialog
          Get.snackbar("Success", "Address updated successfully",
              backgroundColor: Colors.green, colorText: Colors.white);
          await fetchAddresses();
        } else {
          Get.snackbar("Error", jsonData["message"] ?? "Failed to update",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar("Error", "Server error: ${response.statusCode}",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  /// Delete address by addressId then refresh list
  Future<void> deleteAddress(String id) async {
    if (id.isEmpty) {
      Get.snackbar("Error", "Invalid address id",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      final headers = await StorageService().getAuthHeaders();
      final uri = Uri.parse("http://13.204.96.244:3000/api/deleteDeliveryAddress");
      final body = json.encode({"addressId": id});

      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData["status"] == "true") {
          Get.snackbar("Deleted", "Address removed successfully",
              backgroundColor: Colors.green, colorText: Colors.white);
          await fetchAddresses();
        } else {
          Get.snackbar("Error", jsonData["message"] ?? "Failed to delete",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar("Error", "Server error: ${response.statusCode}",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  /// Show edit dialog (uses local TextEditingControllers to avoid disposed-controller issues)
  void showEditDialog(AddressModel a) {
    final nameCtrl = TextEditingController(text: a.name ?? "");
    final addrCtrl = TextEditingController(text: a.address ?? "");
    final cityCtrl = TextEditingController(text: a.city ?? "");
    final postalCtrl = TextEditingController(text: a.postalCode ?? "");

    Get.defaultDialog(
      title: "Edit Address",
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Name")),
            const SizedBox(height: 8),
            TextField(controller: addrCtrl, decoration: const InputDecoration(labelText: "Address")),
            const SizedBox(height: 8),
            TextField(controller: cityCtrl, decoration: const InputDecoration(labelText: "City")),
            const SizedBox(height: 8),
            TextField(controller: postalCtrl, decoration: const InputDecoration(labelText: "Postal Code"), keyboardType: TextInputType.number),
          ],
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          // call API
          updateAddress(a, nameCtrl.text, addrCtrl.text, cityCtrl.text, postalCtrl.text);
        },
        child: const Text("Save Changes"),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: const Text("Cancel"),
      ),
    );
  }
}
