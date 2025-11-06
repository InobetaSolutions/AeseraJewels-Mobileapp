
import 'package:aesera_jewels/modules/Gold_Coin/goldcoin_controller.dart';
import 'package:aesera_jewels/modules/Gold_Coin_Payment/goldcoin_payment_screen.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GoldCoinView extends GetView<GoldCoinController> {
  GoldCoinView({super.key});

  final GoldCoinController controller = Get.put(GoldCoinController());

  final List<String> goldImages = [
    'assets/images/1 gm coin.png',
    'assets/images/2 gm coin.png',
    'assets/images/4 gm.png',
    'assets/images/10 gm.png',
    'assets/images/20 gm.png',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Gold Coin Catalog",
          style: GoogleFonts.lexend(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A0F12),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
              onPressed: () async {
                await StorageService().erase();
                Get.offNamed('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF09243D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Text(
                "Logout",
                style: GoogleFonts.lexend(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoadingRate.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.goldRate.value == null) {
          return const Center(child: Text("Unable to load gold rate"));
        }

        return SafeArea(
          child: Column(
            children: [
              Expanded(child: _buildGoldGrid(screenWidth)),
              const SizedBox(height: 16),
              _buildContinueButton(),
              const SizedBox(height: 10),
              Text(
                "24k Pure Gold | 100% Safe & Secured",
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: const Color(0xFF09243D),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildGoldGrid(double screenWidth) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: controller.weights.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.60,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (_, index) {
        final baseWeight = controller.weights[index];
        final imagePath = goldImages[index];
        final coinPrice = controller.getCoinPrice(baseWeight);

        return Obx(() {
          final quantity = controller.coinCount[index] ?? 0;
          final totalWeight = controller.getTotalWeightForCoin(index);

          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF09243D), width: 2),
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Image.asset(imagePath, height: 110, fit: BoxFit.fill),
                  const SizedBox(height: 8),
                  Text(
                    "$baseWeight GM Coin",
                    style: GoogleFonts.lexend(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF09243D),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "₹${coinPrice.toInt()}",
                    style: GoogleFonts.lexend(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFFB700),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _qtyButton("-", () => controller.decreaseCount(index),
                          const Color(0xFFFFB700)),
                      const SizedBox(width: 16),
                      Text("$quantity pcs",
                          style: GoogleFonts.lexend(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF09243D))),
                      const SizedBox(width: 16),
                      _qtyButton("+", () => controller.increaseCount(index),
                          const Color(0xFF09243D)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Total: ${totalWeight.toStringAsFixed(0)}g",
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Widget _qtyButton(String text, VoidCallback onTap, Color color) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Text(text,
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.white,
            )),
      ),
    );
  }

  Widget _buildContinueButton() {
    return ElevatedButton(
      onPressed: () {
        final selectedCoins = controller.getSelectedCoins();
        if (selectedCoins.isEmpty) {
          Get.snackbar("No Selection", "Please select at least one coin.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: const Color(0xFF09243D),
              colorText: Colors.white);
          return;
        }

        Get.to(() => GoldCoinPaymentScreen(selectedCoins: selectedCoins));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF09243D),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 80),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text("Continue",
          style: GoogleFonts.lexend(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
    );
  }
}
