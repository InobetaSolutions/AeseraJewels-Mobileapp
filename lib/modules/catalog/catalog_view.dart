

import 'package:aesera_jewels/Api/base_url.dart';
import 'package:aesera_jewels/models/catalog_model.dart';
import 'package:aesera_jewels/modules/catalog/catalog_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      width: 175,
      height: 283,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF09243D), width: 1),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ✅ Product Image
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "${ImageUrl.imageUrl}${item.image}", // full image path
                width: 149,
                height: 149,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 50),
              ),
            ),
          ),
          const SizedBox(height: 8),

          /// ✅ Tag
          Text(
            'Tag #${item.tagId}',
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF09243D),
            ),
          ),

          /// ✅ Gold Type
          Text(
            item.goldtype ?? "",
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF09243D),
              //const Color(0xFFFF9800),
            ),
          ),

          /// ✅ Description
          Text(
            item.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF09243D),
            ),
          ),

          const Spacer(),

          /// ✅ Price + Buy
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 20,

                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF09243D),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text(
                  '₹${item.price.toStringAsFixed(2)}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.selectedValue.value = item.price;
                  controller.openAddressBottomSheet();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB700),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
