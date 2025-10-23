
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
