
// // import 'dart:convert';
// // import 'package:aesera_jewels/models/Addresses_model.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;
// // import '../../services/storage_service.dart';

// // class AddressController extends GetxController {
// //   var addresses = <AddressModel>[].obs;
// //   var isLoading = false.obs;

// //   final nameController = TextEditingController();
// //   final addressController = TextEditingController();
// //   final cityController = TextEditingController();
// //   final postalCodeController = TextEditingController();

// //   VoidCallback? submitAddress;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchAddresses();
// //   }

// //   /// Fetch addresses for current user
// //   Future<void> fetchAddresses() async {
// //     final userId = StorageService().getUserIdLocal();
// //     if (userId == null) {
// //       Get.snackbar("Error", "User not logged in",
// //           backgroundColor: Colors.red, colorText: Colors.white);
// //       return;
// //     }

// //     isLoading.value = true;
// //     try {
// //       final headers = await StorageService().getAuthHeaders();
// //       final uri = Uri.parse("http://13.204.96.244:3000/api/getDeliveryAddress");
// //       final body = json.encode({"userid": userId});

// //       final response = await http.post(uri, headers: headers, body: body);

// //       if (response.statusCode == 200) {
// //         final jsonData = jsonDecode(response.body);
// //         if (jsonData["status"] == "true") {
// //           final List data = jsonData["data"];
// //           addresses.value = data.map((e) => AddressModel.fromJson(e)).toList();
// //           print(response);
// //         } else {
// //           Get.snackbar("Error", jsonData["message"] ?? "Failed to fetch",
// //               backgroundColor: Colors.red, colorText: Colors.white);
// //         }
// //       } else {
// //         Get.snackbar("Error", "Server error: ${response.statusCode}",
// //             backgroundColor: Colors.red, colorText: Colors.white);
// //       }
// //     } catch (e) {
// //       Get.snackbar("Error", e.toString(),
// //           backgroundColor: Colors.red, colorText: Colors.white);
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }

// //   /// Update address API
// //   Future<void> updateAddress(AddressModel a) async {
// //     try {
// //       final headers = await StorageService().getAuthHeaders();
// //       final uri = Uri.parse("http://13.204.96.244:3000/api/updateDeliveryAddress");
// //       final body = json.encode({
// //         "addressId": a.id,
// //         "name": nameController.text,
// //         "address": addressController.text,
// //         "city": cityController.text,
// //         "postalCode": postalCodeController.text
// //       });

// //       final response = await http.put(uri, headers: headers, body: body);

// //       if (response.statusCode == 200) {
// //         final jsonData = jsonDecode(response.body);
// //         if (jsonData["status"] == "true") {
// //           // Update locally
// //           int index = addresses.indexWhere((element) => element.id == a.id);
// //           if (index != -1) {
// //             addresses[index] = AddressModel(
// //               id: a.id,
// //               userId: a.userId,
// //               name: nameController.text,
// //               address: addressController.text,
// //               city: cityController.text,
// //               postalCode: postalCodeController.text,
// //             );
// //           }
// //           Get.back(); // Close edit dialog
// //           Get.snackbar("Success", "Address updated successfully",
// //               backgroundColor: Colors.green, colorText: Colors.white);
// //               print(response);
// //         } else {
// //           Get.snackbar("Error", jsonData["message"] ?? "Failed to update",
// //               backgroundColor: Colors.red, colorText: Colors.white);
// //         }
// //       } else {
// //         Get.snackbar("Error", "Server error: ${response.statusCode}",
// //             backgroundColor: Colors.red, colorText: Colors.white);
// //       }
// //     } catch (e) {
// //       Get.snackbar("Error", e.toString(),
// //           backgroundColor: Colors.red, colorText: Colors.white);
// //     }
// //   }

// //   /// Delete address locally
// //   Future<void> deleteAddress(String id) async {
// //     addresses.removeWhere((a) => a.id == id);
// //     Get.snackbar("Deleted", "Address removed successfully",
// //         backgroundColor: Colors.green, colorText: Colors.white);
// //   }

// //   @override
// //   void onClose() {
// //     nameController.dispose();
// //     addressController.dispose();
// //     cityController.dispose();
// //     postalCodeController.dispose();
// //     super.onClose();
// //   }
// // }
// import 'dart:convert';
// import 'package:aesera_jewels/models/Addresses_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../../services/storage_service.dart';

// class AddressController extends GetxController {
//   var addresses = <AddressModel>[].obs;
//   var isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchAddresses();
//   }

//   /// Fetch all addresses for the logged-in user
//   Future<void> fetchAddresses() async {
//     final userId = await StorageService.getUserId();
//     if (userId == null || userId.isEmpty) {
//       Get.snackbar("Error", "User not logged in",
//           backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
//       return;
//     }

//     isLoading.value = true;
//     try {
//       // <-- CALL AS INSTANCE -->
//       final headers = await StorageService().getAuthHeaders();
//       final uri = Uri.parse("http://13.204.96.244:3000/api/getDeliveryAddress");
//       final body = json.encode({"userid": userId});

//       final response = await http.post(uri, headers: headers, body: body);

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         if (jsonData["status"] == "true") {
//           final List data = jsonData["data"];
//           addresses.value = data.map((e) => AddressModel.fromJson(e)).toList();
//         } else {
//           Get.snackbar("Error", jsonData["message"] ?? "Failed to fetch",
//              backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
//         }
//       } else {
//         Get.snackbar("Error", "Server error: ${response.statusCode}",
//         backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar("Error", e.toString(),
//          backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   /// Update address via API then refresh list
//   Future<void> updateAddress(
//       AddressModel a, String name, String address, String city, String postal) async {
//     // basic validation
//     if (name.trim().isEmpty ||
//         address.trim().isEmpty ||
//         city.trim().isEmpty ||
//         postal.trim().isEmpty) {
//       Get.snackbar("Validation", "All fields are required",
//          backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
//       return;
//     }
//     if (postal.trim().length != 6) {
//       Get.snackbar("Validation", "Postal code must be 6 digits",
//          backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
//       return;
//     }

//     try {
//       final headers = await StorageService().getAuthHeaders();
//       final uri = Uri.parse("http://13.204.96.244:3000/api/updateDeliveryAddress");
//       final body = json.encode({
//         "addressId": a.id,
//         "name": name,
//         "address": address,
//         "city": city,
//         "postalCode": postal
//       });

//       final response = await http.put(uri, headers: headers, body: body);

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         if (jsonData["status"] == "true") {
//           Get.back(); // close dialog
//           Get.snackbar("Success", "Address updated successfully",
//              backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
//           await fetchAddresses();
//         } else {
//           Get.snackbar("Error", jsonData["message"] ?? "Failed to update",
//              backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
//         }
//       } else {
//         Get.snackbar("Error", "Server error: ${response.statusCode}",
//           backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar("Error", e.toString(),
//        backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
//     }
//   }

//   /// Delete address by addressId then refresh list
//   Future<void> deleteAddress(String id) async {
//     if (id.isEmpty) {
//       Get.snackbar("Error", "Invalid address id",
//           backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
//       return;
//     }

//     try {
//       final headers = await StorageService().getAuthHeaders();
//       final uri = Uri.parse("${BaseUrl.baseUrl}deleteDeliveryAddress");
//       final body = json.encode({"addressId": id});

//       final response = await http.post(uri, headers: headers, body: body);

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         if (jsonData["status"] == "true") {
//           Get.snackbar("Deleted", "Address removed successfully",
//             backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
//           await fetchAddresses();
//         } else {
//           Get.snackbar("Error", jsonData["message"] ?? "Failed to delete",
//             backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
//         }
//       } else {
//         Get.snackbar("Error", "Server error: ${response.statusCode}",
//           backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar("Error", e.toString(),
//         backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
//     }
//   }

//   /// Show edit dialog (uses local TextEditingControllers to avoid disposed-controller issues)
//   void showEditDialog(AddressModel a) {
//     final nameCtrl = TextEditingController(text: a.name ?? "");
//     final addrCtrl = TextEditingController(text: a.address ?? "");
//     final cityCtrl = TextEditingController(text: a.city ?? "");
//     final postalCtrl = TextEditingController(text: a.postalCode ?? "");

//     Get.defaultDialog(
//       backgroundColor:  const Color(0xFF09243D),
//       title: "Edit Address",
//       content: SingleChildScrollView(
//         child: Column(
//           children: [

//             TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Name")),
//             const SizedBox(height: 8),
//             TextField(controller: addrCtrl, decoration: const InputDecoration(labelText: "Address")),
//             const SizedBox(height: 8),
//             TextField(controller: cityCtrl, decoration: const InputDecoration(labelText: "City")),
//             const SizedBox(height: 8),
//             TextField(controller: postalCtrl, decoration: const InputDecoration(labelText: "Postal Code"), keyboardType: TextInputType.number),
//           ],
//         ),
//       ),
//       confirm: ElevatedButton(
//         onPressed: () {
//           // call API
//           updateAddress(a, nameCtrl.text, addrCtrl.text, cityCtrl.text, postalCtrl.text);
//         },
//         child: const Text("Save Changes"),
//       ),
//       cancel: TextButton(
//         onPressed: () => Get.back(),
//         child: const Text("Cancel"),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:aesera_jewels/Api/base_url.dart';
import 'package:aesera_jewels/models/Addresses_model.dart';
import 'package:aesera_jewels/modules/add_address/add_addresses_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../services/storage_service.dart';
import 'package:flutter/services.dart';

class AddressController extends GetxController {
  var addresses = <AddressModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  /// Fetch addresses for logged-in user
  Future<void> fetchAddresses() async {
    final userId = await StorageService.getUserId();
    if (userId == null || userId.isEmpty) {
      Get.snackbar("Error", "User not logged in",
          backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      final headers = await StorageService().getAuthHeaders();
      final uri = Uri.parse("${BaseUrl.baseUrl}getDeliveryAddress");
      final body = json.encode({"userid": userId});

      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData["status"] == "true") {
          final List data = jsonData["data"];
          addresses.value = data.map((e) => AddressModel.fromJson(e)).toList();
        } else {
          Get.snackbar("Error", jsonData["message"] ?? "Failed to fetch",
              backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
        }
      } else {
        Get.snackbar("Error", "Server error: ${response.statusCode}",
            backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error",  "please check your internet connection",
          backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  /// Update Address API
  Future<void> updateAddress(
      AddressModel a, String name, String address, String city, String postal) async {
    if (name.trim().isEmpty || address.trim().isEmpty || city.trim().isEmpty || postal.trim().isEmpty) {
      Get.snackbar("Validation", "All fields are required",
          backgroundColor:  const Color(0xFF09243D), colorText: Colors.white);
      return;
    }

    try {
      final headers = await StorageService().getAuthHeaders();
      final uri = Uri.parse("${BaseUrl.baseUrl}updateDeliveryAddress");
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
          Get.back();
          Get.snackbar("Success", "Address updated successfully",
              backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
          await fetchAddresses();
        }
      } else {
        Get.snackbar("Error", "Server error: ${response.statusCode}",
            backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", " please check your internet connection",
          backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
    }
  }

  /// Delete Address API
  Future<void> deleteAddress(String id) async {
    try {
      final headers = await StorageService().getAuthHeaders();
      final uri = Uri.parse("${BaseUrl.baseUrl}deleteDeliveryAddress");
      final body = json.encode({"addressId": id});

      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData["status"] == "true") {
          Get.snackbar("Deleted", "Address removed successfully",
              backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
          await fetchAddresses();
        }
      }
    } catch (e) {
      Get.snackbar("Error",  " please check your internet connection",
          backgroundColor: const Color(0xFF09243D), colorText: Colors.white);
    }
  }

  /// Custom decorated TextField
  Widget customTextField(TextEditingController controller,
      {required String hint,
      TextInputType type = TextInputType.text,
      List<TextInputFormatter>? inputFormatters,
      bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: GoogleFonts.lexend(
              fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF0D0F1C)),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF6FDFF),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 3),
                spreadRadius: 0.02,
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: type,
            inputFormatters: inputFormatters,
            readOnly: readOnly,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF2596BE),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              counterText: "",
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  /// Show edit dialog
  void showEditDialog(AddressModel a) {
    final nameCtrl = TextEditingController(text: a.name ?? "");
    final addrCtrl = TextEditingController(text: a.address ?? "");
    final cityCtrl = TextEditingController(text: a.city ?? "");
    final postalCtrl = TextEditingController(text: a.postalCode ?? "");

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Edit Address",
            style: GoogleFonts.lexend(fontWeight: FontWeight.bold, color: Colors.black)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              customTextField(nameCtrl, hint: "Name"),
              customTextField(addrCtrl, hint: "Address"),
              customTextField(cityCtrl, hint: "City"),
              customTextField(postalCtrl, hint: "Postal Code", type: TextInputType.number),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB700)),
                onPressed: () => Get.back(),
                child: Text("Cancel", style: GoogleFonts.lexend(color: Colors.black,fontSize: 15)),
              ),
           Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A2A4D),),
            onPressed: () {
              updateAddress(a, nameCtrl.text, addrCtrl.text, cityCtrl.text, postalCtrl.text);
            },
            child: Text("Save ", style: GoogleFonts.lexend(color: Colors.white,fontSize:   15)),
          ),
           ],
          ),
        ],
      ),
    );
  }

  /// Show delete confirmation
  void showDeleteDialog(AddressModel a) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Confirm",textAlign: TextAlign.center,
            style: GoogleFonts.lexend(fontWeight: FontWeight.bold, color: Colors.black)),
        content: Text("Delete this address?",textAlign: TextAlign.center,
            style: GoogleFonts.lexend(color: Colors.black87,fontSize:  16)),
        actions: [
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB700)),
                onPressed: () => Get.back(),
                child: Text("Cancel", style: GoogleFonts.lexend(color: Colors.black,fontSize:  15)),
              ),
            Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A2A4D),),
            onPressed: () {
              Get.back();
              deleteAddress(a.id ?? "");
            },
            child: Text("Delete", style: GoogleFonts.lexend(color: Colors.white,fontSize:  15)),
          ),
          ],
          ),
        ],
      ),
    );
  }
}
