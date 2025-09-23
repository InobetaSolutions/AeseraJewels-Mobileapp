
// import 'package:aesera_jewels/models/Addresses_model.dart';
// import 'package:aesera_jewels/modules/add_address/add_addresses_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'address_controller.dart';

// class AddressScreen extends StatelessWidget {
//   AddressScreen({super.key});
//   final controller = Get.put(AddressController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F4FA),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text(
//           "Address",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Get.back(),
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               Get.to(AddAddressScreen());
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFFFB700),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(18),
//               ),
//             ),
//             child: Text(
//               "Add",
//               style: GoogleFonts.lexend(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (controller.addresses.isEmpty) {
//           return const Center(child: Text("No addresses found"));
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: controller.addresses.length,
//           itemBuilder: (context, index) {
//             final a = controller.addresses[index];
//             return _cardContainer(a);
//           },
//         );
//       }),
//     );
//   }

//   Widget _cardContainer(AddressModel a) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _alignedRow("Name", a.name),
//             _alignedRow("Address", a.address),
//             _alignedRow("City", a.city),
//             _alignedRow("Post Code", a.postalCode),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.edit, color: Colors.blue),
//                   onPressed: () {
//                     _showEditDialog(a);
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.delete, color: Colors.red),
//                   onPressed: () {
//                     controller.deleteAddress(a.id);
//                   },
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _alignedRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 120,
//             child: Text(
//               label,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           const Text(": ", style: TextStyle(fontWeight: FontWeight.bold)),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }

//   /// Edit Dialog
//   void _showEditDialog(AddressModel a) {
//     controller.nameController.text = a.name;
//     controller.addressController.text = a.address;
//     controller.cityController.text = a.city;
//     controller.postalCodeController.text = a.postalCode;

//     Get.defaultDialog(
//       title: "Edit Address",
//       content: Column(
//         children: [
//           TextField(
//             controller: controller.nameController,
//             decoration: const InputDecoration(labelText: "Name"),
//           ),
//           TextField(
//             controller: controller.addressController,
//             decoration: const InputDecoration(labelText: "Address"),
//           ),
//           TextField(
//             controller: controller.cityController,
//             decoration: const InputDecoration(labelText: "City"),
//           ),
//           TextField(
//             controller: controller.postalCodeController,
//             decoration: const InputDecoration(labelText: "Postal Code"),
//           ),
//         ],
//       ),
//       confirm: ElevatedButton(
//         onPressed: () {
//           controller.updateAddress(a);
//         },
//         child: const Text("Save"),
//       ),
//       cancel: TextButton(
//         onPressed: () => Get.back(),
//         child: const Text("Cancel"),
//       ),
//     );
//   }
// }
import 'package:aesera_jewels/models/Addresses_model.dart';
import 'package:aesera_jewels/modules/add_address/add_addresses_screen.dart';
import 'package:aesera_jewels/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'address_controller.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({super.key});
  final controller = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Address",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        
       leading: IconButton(
  icon: const Icon(Icons.arrow_back, color: Colors.black),
  onPressed: () {
    if (Get.previousRoute.isNotEmpty) {
      Get.back(); // Navigate back if possible
    } else {
      // Fallback: navigate to home or a default screen
      Get.offAllNamed(AppRoutes.investment); 
    }
  },
),

        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => AddAddressScreen())?.then((value) {
                  // refresh after returning from add screen
                  controller.fetchAddresses();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFB700),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Add",
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.addresses.isEmpty) {
          return const Center(child: Text("No addresses found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.addresses.length,
          itemBuilder: (context, index) {
            final a = controller.addresses[index];
            return _cardContainer(a);
          },
        );
      }),
    );
  }

  Widget _cardContainer(AddressModel a) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _alignedRow("Name", a.name ?? ""),
            _alignedRow("Address", a.address ?? ""),
            _alignedRow("City", a.city ?? ""),
            _alignedRow("Post Code", a.postalCode ?? ""),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => controller.showEditDialog(a),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    // optional: confirm deletion
                    final ok = await Get.dialog<bool>(
                      AlertDialog(
                        title: const Text("Confirm"),
                        content: const Text("Delete this address?"),
                        actions: [
                          TextButton(onPressed: () => Get.back(result: false), child: const Text("Cancel")),
                          TextButton(onPressed: () => Get.back(result: true), child: const Text("Delete")),
                        ],
                      ),
                    );
                    if (ok == true) {
                      controller.deleteAddress(a.id ?? "");
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _alignedRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Text(": ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
