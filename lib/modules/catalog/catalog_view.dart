
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
        centerTitle: true,
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
            return CatalogItemCard(item: item, screenWidth: screenWidth);
          },
        );
      }),
    );
  }
}

class CatalogItemCard extends StatelessWidget {
  final ProductModel item;
  final double screenWidth;

  const CatalogItemCard({
    super.key,
    required this.item,
    required this.screenWidth,
  });

  Widget _alignedRow(String label, String value,
      {FontWeight labelWeight = FontWeight.w600,
      FontWeight valueWeight = FontWeight.w400,
      Color valueColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: labelWeight,
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          // Value
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: valueWeight,
                fontSize: 12,
                color: valueColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CatalogController>();

    return Container(
      width:double.infinity,
       height: 120,
      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 4 ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF09243D), width: 2.5),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ✅ Product Image
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "${ImageUrl.imageUrl}${item.image}",
                width: double.infinity,
                height:120,
                fit: BoxFit.fill,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.broken_image,
                  size: 60,
                  color: Color(0xFF09243D),
                ),
              ),
            ),
          ),
          const SizedBox(height: 1),

          /// ✅ Details Section
          _alignedRow("Tag", item.tagId ?? ""),
          _alignedRow("GoldType", item.goldtype ?? ""),
          _alignedRow("Grams", "${item.grams ?? 0} gm"),
         // _alignedRow("Original Price", (item.originalPrice ?? "").toString()),

          _alignedRow("Description", item.description ?? ""),
        
          const Spacer(),

          /// ✅ Price + Buy Button at bottom
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF09243D).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  '₹${item.price.toStringAsFixed(2)}',
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.openAddressBottomSheet(item);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB700),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Buy",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
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
