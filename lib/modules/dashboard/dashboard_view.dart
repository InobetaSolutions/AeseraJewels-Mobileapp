import 'package:aesera_jewels/modules/Gold_Coin_Payment/goldcoin_payment_controller.dart';
import 'package:aesera_jewels/modules/Gold_Coin_Payment/goldcoin_payment_screen.dart';
import 'package:aesera_jewels/modules/auth_controller.dart';
import 'package:aesera_jewels/modules/catalog/catalog_controller.dart';
import 'package:aesera_jewels/modules/catalog/catalog_view.dart';
import 'package:aesera_jewels/modules/coin_catalog/coin_catalog_controller.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());
  final authController = Get.put(AuthController());
  final CatalogScreen = Get.put(CatalogController());
  final GoldCoinPaymentScreen = Get.put(GoldCoinPaymentController());
  //final  CoinCatalogScreen  = Get.put(CoinCatalogController());

  DashboardScreen({super.key}) {
    authController.loadUser(); // Load saved user
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Dashboard",
          style: GoogleFonts.lexend(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A0F12),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 14,
              top: 10.5,
              bottom: 10.5,
            ),
            child: ElevatedButton(
              onPressed: () async {
                await StorageService().erase();
                Get.offNamed('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFB700),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Logout",
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF000000),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isOffline.value) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text("You are offline"),
              ],
            ),
          );
        }

        if (controller.isLoadingRate.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Welcome Text
                Obx(
                  () => Text(
                    " ${controller.userName.value}",
                    style: GoogleFonts.lexend(
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                      color: const Color(0xFF1A0F12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// GOLD RATE CARD
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 297,
                    height: 170,
                    decoration: BoxDecoration(
                      color: const Color(0xFF09243D),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Rate Gold (24K)",
                          style: GoogleFonts.lexend(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: const Color(0xFFFFB700),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Obx(() {
                          if (controller.goldRate.value != null) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rs. ${controller.goldRate.value!.priceGram24k.toStringAsFixed(2)}",
                                  style: GoogleFonts.lexend(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                    color: const Color(0xFFFFB700),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Updated: ${controller.goldRate.value!.istDate}",
                                  style: GoogleFonts.lexend(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            );
                          } else {
                            return Text(
                              "No Data",
                              style: GoogleFonts.lexend(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: const Color(0xFFFFB700),
                              ),
                            );
                          }
                        }),
                        const Spacer(),

                        /// ✅ Wrapped Invest & Buy buttons in a Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: controller.goTosellCoin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFB700),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.05,
                                  vertical: 0,
                                ),
                              ),
                              child: Text(
                                "Sell",
                                style: GoogleFonts.lexend(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: controller.goToPayment,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFB700),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.05,
                                  vertical: 0,
                                ),
                              ),
                              child: Text(
                                "Invest",
                                style: GoogleFonts.lexend(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 298,
                    height: 241,
                    decoration: BoxDecoration(
                      color: const Color(0xFF09243D),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// 🔹 CARD CONTENT
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/catalog1.png",
                                    width: 90,
                                    height: 75,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 10),
                                  Image.asset(
                                    "assets/images/catelog2.png",
                                    width: 90,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Image.asset(
                                  "assets/images/catalog_gold_img.png",
                                  width: 150,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),

                          /// 🔹 SHOP COINS BUTTON (INSIDE CARD)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: controller.goToGoldCoin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFB700),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                        0.08,
                                    vertical: 10,
                                  ),
                                ),
                                child: Text(
                                  "Shop Coins",
                                  style: GoogleFonts.lexend(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // /// CATALOG CARD
                // Align(
                //   alignment: Alignment.center,
                //   child: Container(
                //     width: 298,
                //     height: 241,
                //     decoration: BoxDecoration(
                //       color: const Color(0xFF09243D),
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.only(left: 12, right: 12),
                //       child: Row(
                //         crossAxisAlignment: CrossAxisAlignment.stretch,
                //         children: [
                //           Column(
                //             children: [
                //               Image.asset(
                //                 "assets/images/catalog1.png",
                //                 width: 90,
                //                 height: 75,
                //                 fit: BoxFit.cover,
                //               ),
                //               const SizedBox(height: 10),
                //               Image.asset(
                //                 "assets/images/catelog2.png",
                //                 width: 90,
                //                 height: 60,
                //                 fit: BoxFit.cover,
                //               ),
                //               const SizedBox(height: 12),
                //             ],
                //           ),
                //           const SizedBox(width: 10),
                //           Padding(
                //             padding: const EdgeInsets.only(top: 40, bottom: 0),
                //             child: Image.asset(
                //               "assets/images/catalog_gold_img.png",
                //               width: 150,
                //               height: 240,
                //               fit: BoxFit.cover,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 23),

                /// PORTFOLIO BUTTON
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: controller.goToInvestment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF09243D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 95,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      "Portfolio",
                      style: GoogleFonts.lexend(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFFFB700),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// CONTACT SUPPORT CARD
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 298,
                    decoration: BoxDecoration(
                      color: const Color(0xFF09243D),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Obx(() {
                      if (controller.isLoadingSupport.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contact Support:",
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: const Color(0xFFFFB700),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Mobile: ${controller.supportMobile.value}",
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Email: ${controller.supportEmail.value}",
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      }),
    );
  }
}
