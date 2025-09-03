

// import 'package:aesera_jewels/Api/base_url.dart';
// import 'package:aesera_jewels/models/catalog_model.dart';
// import 'package:aesera_jewels/modules/catalog/catalog_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CatalogScreen extends GetWidget<CatalogController> {
//   CatalogScreen({super.key});
//   final CatalogController controller = Get.put(CatalogController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           "Catalog",
//           style: GoogleFonts.lexend(
//             fontSize: 22,
//             fontWeight: FontWeight.w700,
//             color: const Color(0xFF1A0F12),
//           ),
//           textAlign: TextAlign.center,
//         ),
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
//           return Center(
//             child: Text(
//               "No products available",
//               style: GoogleFonts.lexend(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black54,
//               ),
//             ),
//           );
//         }

//         return GridView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: controller.productList.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 0.58,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
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
//       width: 180,
//       height: 300,
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color(0xFF09243D), width: 1),
//         borderRadius: BorderRadius.circular(12),
//         color: Colors.white,
//         boxShadow: const [
//           BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// ✅ Product Image
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.network(
//                   "${ImageUrl.imageUrl}${item.image}", // full image path
//                   width: 150,
//                   height: 120,
//                   fit: BoxFit.contain,
//                   errorBuilder: (_, __, ___) =>
//                       const Icon(Icons.broken_image, size: 50),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 4),

//           /// ✅ Tag
//           Text(
//             'Tag #${item.tagId}',
//             style: GoogleFonts.lexend(
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               color: const Color(0xFF09243D),
//             ),
//           ),

//           /// ✅ Gold Type
//           Text(
//             item.goldtype ?? "",
//             style: GoogleFonts.lexend(
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//               color: Color(0xFF09243D),
//               //const Color(0xFFFF9800),
//             ),
//           ),

//           /// ✅ Description
//           Text(
//             item.description,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: GoogleFonts.lexend(
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//               color: Color(0xFF09243D),
//             ),
//           ),

//          const SizedBox(height: 10),

//           /// ✅ Price + Buy
//           Padding(
//             padding: const EdgeInsets.fromLTRB(0,10,0,10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   height: 25,
//                   width: 80,
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
//                   decoration: BoxDecoration(
//                     ///color: const Color(0xFF09243D),
//                     color: const Color.fromARGB(255, 220, 227, 230),
//                     borderRadius: BorderRadius.vertical(top: Radius.circular(20), bottom: Radius.circular(20),),
//                   ),
//                   child: Text(
//                     '₹${item.price.toStringAsFixed(2)}',
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.plusJakartaSans(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     controller.selectedValue.value = item.price;
//                     controller.openAddressBottomSheet();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFFFB700),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 5,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   child: Text(
//                     "Buy",
//                     style: GoogleFonts.lexend(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:aesera_jewels/Api/base_url.dart';
import 'package:aesera_jewels/models/catalog_model.dart';
import 'package:aesera_jewels/modules/catalog/catalog_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class CatalogScreen extends GetWidget<CatalogController> {
  CatalogScreen({super.key});
  final CatalogController controller = Get.put(CatalogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Catalog",
          style: GoogleFonts.lexend(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A0F12),
          ),
          textAlign: TextAlign.center,
        ),
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
          return Center(
            child: Text(
              "No products available",
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          );
        }

        final screenWidth = MediaQuery.of(context).size.width;
        final cardWidth = (screenWidth / 2) - 20;
        final cardHeight = cardWidth * 1.6;

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.productList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.55,
            crossAxisSpacing: 9,
            mainAxisSpacing: 9,
          ),
          itemBuilder: (_, index) {
            final item = controller.productList[index];
            return CatalogItemCard(item: item, cardWidth: cardWidth, cardHeight: cardHeight);
          },
        );
      }),
    );
  }
}
class CatalogItemCard extends StatelessWidget {
  final ProductModel item;
  final double cardWidth;
  final double cardHeight;

  const CatalogItemCard({
    super.key,
    required this.item,
    required this.cardWidth,
    required this.cardHeight,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CatalogController>();

    return Container(
      width: cardWidth,
      height: cardHeight,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF09243D), width: 3),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ✅ Product Image
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "${ImageUrl.imageUrl}${item.image}",
                width: cardWidth - 25,
                height: cardWidth - 30,
                fit: BoxFit.fill,
              
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 50),
              ),
            ),
          ),
          const SizedBox(height: 1),

          /// ✅ Tag
          Text(
            'Tag #${item.tagId}',
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF09243D),
            ),
          ),

          /// ✅ Gold Type
          Text(
            item.goldtype,
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF09243D),
            ),
          ),

          /// ✅ Description
          SizedBox(
            height: 35,
            child: Text(
              item.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lexend(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF09243D),
              ),
            ),
          ),

          const Spacer(),

          /// ✅ Price + Buy
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 27,
                  width: 78,
                  
                  margin: const EdgeInsets.only(right: 2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                  
                    color: const Color(0xFF09243D).withOpacity(0.56),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  
                  child: Text(
                    '₹${item.price.toStringAsFixed(2)}',
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.selectedValue.value = item.price;
                    controller.openAddressBottomSheet();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFB700),
                   minimumSize: const Size(60, 40),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Buy",
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
