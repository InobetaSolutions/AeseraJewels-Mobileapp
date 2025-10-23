import 'package:aesera_jewels/Api/base_url.dart';
import 'package:aesera_jewels/models/catalog_model.dart';
import 'package:aesera_jewels/modules/coin_catalog/coin_catalog_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CoinCatalogScreen extends GetWidget<CoinCatalogController> {
  CoinCatalogScreen({super.key});
  final CoinCatalogController controller = Get.put(CoinCatalogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Coin Catalog",
            style: GoogleFonts.lexend(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A0F12),
            )),
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
              child: Text("No products available",
                  style: GoogleFonts.lexend(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54)));
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

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CoinCatalogController>();

    return Container(
      padding: const EdgeInsets.all(6),
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
                height: 120,
                fit: BoxFit.fill,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.broken_image,
                  size: 60,
                  color: Color(0xFF09243D),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),

          Text("Tag: ${item.tagId ?? ''}",
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          Text("GoldType: ${item.goldtype ?? ''}",
              style: const TextStyle(fontSize: 12)),
          Text("Grams: ${item.grams ?? 0} gm",
              style: const TextStyle(fontSize: 12)),
          Text("Description: ${item.description ?? ''}",
              style: const TextStyle(fontSize: 12)),

          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF09243D),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  '₹${item.price.toStringAsFixed(2)}',
                  style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ElevatedButton(
  onPressed: () {
    controller.showPaymentMethodDialog(item); // Show dialog instead of directly opening bottom sheet
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFFFB700),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    elevation: 0,
  ),
  child: const Text(
    "Buy",
    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
  ),
),


            ],
         
          ),
        ],
      ),
    );
  }
}