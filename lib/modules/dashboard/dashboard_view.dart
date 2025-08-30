
import 'package:aesera_jewels/modules/auth_controller.dart';
import 'package:aesera_jewels/modules/onboard/onboard_view.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_controller.dart';
import 'package:aesera_jewels/modules/login/login_view.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());
  final authController = Get.put(AuthController());

  DashboardScreen({super.key}) {
    authController.loadUser(); // Load saved user
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Dashboard",
          style: GoogleFonts.lexend(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A0F12),
          ),
        ),
actions: [
  TextButton(
    onPressed: () async {
      Get.offAll(() => LoginView());
    },
    child: const Text("Logout", style: TextStyle(color: Colors.white)),
  ),
  Padding(
    padding: const EdgeInsets.only(
        left: 12, right: 16, top: 10.5, bottom: 10.5),
    child: ElevatedButton(
      onPressed: () {
        StorageService.erase();
        SystemNavigator.pop(); // exit app
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFB700),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        padding:
            const EdgeInsets.symmetric(horizontal: 21, vertical: 3),
      ),
      child: Text(
        "Logout",
        style: GoogleFonts.lexend(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF000000),
        ),
      ),
    ),
  ),
],
      ),
      body: SafeArea(
        child: Scrollbar(
          thickness: 6,
          radius: const Radius.circular(10),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
              bottom: bottomPadding + 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Welcome Text
                Obx(() => Text(
                       "Welcome, ${controller.userName.value}",
                       
                      style: GoogleFonts.lexend(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: const Color(0xFF1A0F12),
                      ),
                    )),

                const SizedBox(height: 16),

                /// GOLD RATE CARD
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 297,
                    height: 160,
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
                        const SizedBox(height: 8),

                        /// Dynamic Gold Rate
                        Obx(() {
                          if (controller.isLoadingRate.value) {
                            return Text(
                              "Loading...",
                              style: GoogleFonts.lexend(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: const Color(0xFFFFB700),
                              ),
                            );
                          } else if (controller.goldRate.value != null) {
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
                                const SizedBox(height: 6),
                                Text(
                                  "Updated: ${controller.goldRate.value!.istDate}",
                                  style: GoogleFonts.lexend(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: controller.goToBuyGold,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFB700),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.06,
                                vertical: 0,
                              ),
                            ),
                            child: Text(
                              "Pay",
                              style: GoogleFonts.lexend(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// CATALOG CARD
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
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          /// Left Section: Images + Button
                          Column(
                            children: [
                              Image.asset(
                                "assets/images/catalog1.png",
                                width: 90,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 10),
                              Image.asset(
                                "assets/images/catelog2.png",
                                width: 90,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 12),

                              /// Shop Now Button
                              TextButton(
                                onPressed: controller.goToCatalog,
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFB700),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 23, vertical: 6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "Shop\n Now",
                                  style: GoogleFonts.lexend(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 14),

                          /// Right Image
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 40, bottom: 0),
                            child: Image.asset(
                              "assets/images/catalog_gold_img.png",
                              width: 150,
                              height: 240,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
