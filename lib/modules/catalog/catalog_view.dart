
// import 'package:aesera_jewels/models/catalog_model.dart';
// import 'package:aesera_jewels/modules/catalog/catalog_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CatalogScreen extends GetView<CatalogController> {
//   const CatalogScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:
//             const Text("Catalog", style: TextStyle(fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (controller.productList.isEmpty) {
//           return const Center(child: Text("No products available"));
//         }

//         return GridView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: controller.productList.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 0.70,
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//           ),
//           itemBuilder: (_, index) {
//             final item = controller.productList[index];
//             return CatalogItemCard(item: item);
//           },
//         );
//       }),
//     );
//   }
// }

// class CatalogItemCard extends StatelessWidget {
//   final ProductModel item;

//   const CatalogItemCard({super.key, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<CatalogController>();

//     return Container(
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color(0xFF0A2A4D), width: 1),
//         borderRadius: BorderRadius.circular(12),
//         color: Colors.white,
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 4,
//             spreadRadius: 1,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// Product Image
//           Center(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.network(
//                 'http://13.204.96.244:3000/uploads/${item.image}',
//                 width: 120,
//                 height: 100,
//                 fit: BoxFit.contain,
//                 errorBuilder: (_, __, ___) =>
//                     const Icon(Icons.broken_image, size: 50),
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),

//           /// Tag
//           Text(
//             'Tag #${item.tagId}',
//             style: const TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF0A2A4D),
//             ),
//           ),

//           /// Description
//           Text(
//             item.description,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(fontSize: 12, color: Colors.black87),
//           ),

//           const Spacer(),

//           /// Price + Buy Button
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 alignment: Alignment.center,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.black87,
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Text(
//                   '₹${item.price.toStringAsFixed(2)}',
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   controller.selectedValue.value = item.price;
//                   controller.openAddressBottomSheet();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.amber,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(24),
//                   ),
//                 ),
//                 child: const Text(
//                   "Buy",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:aesera_jewels/models/catalog_model.dart';
import 'package:aesera_jewels/modules/catalog/catalog_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatalogScreen extends GetView<CatalogController> {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Catalog", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.productList.isEmpty) {
          return const Center(child: Text("No products available"));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.productList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.70,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (_, index) {
            final item = controller.productList[index];
            return CatalogItemCard(item: item);
          },
        );
      }),
    );
  }
}

class CatalogItemCard extends StatelessWidget {
  final ProductModel item;

  const CatalogItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CatalogController>();

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF0A2A4D), width: 1),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Product Image
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'http://13.204.96.244:3000/uploads/${item.image}',
                width: 120,
                height: 100,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 50),
              ),
            ),
          ),
          const SizedBox(height: 8),

          /// Tag
          Text(
            'Tag #${item.tagId}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A2A4D),
            ),
          ),

          /// Gold Type
          Text(
            '${item.goldtype}',
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.orange),
          ),

          /// Description
          Text(
            item.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),

          const Spacer(),

          /// Price + Buy
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  '₹${item.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.selectedValue.value = item.price;
                  controller.openAddressBottomSheet();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  "Buy",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
