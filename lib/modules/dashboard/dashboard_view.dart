
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aesera_jewels/modules/dashboard/dashboard_controller.dart';
import 'package:aesera_jewels/modules/login/login_view.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final buttonWidth = width * 0.25;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: const Text("Dashboard", style: TextStyle(color: Colors.black)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            child: ElevatedButton(
              onPressed: () => Get.offAll(() => LoginView()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: const StadiumBorder(),
                padding: EdgeInsets.symmetric(
                  horizontal: buttonWidth * 0.5,
                  vertical: 10,
                ),
              ),
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.black, fontSize: 12),
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Title
                const Text(
                  "Rama Krishnan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(height: 20),

                // GOLD RATE CARD
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF032541),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Current Rate Gold (24K)",
                        style: TextStyle(color: Colors.amber),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Rs. 9,450",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: controller.goToBuyGold,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            shape: const StadiumBorder(),
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.08,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            "Pay",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // SHOP NOW SECTION
                GestureDetector(
                  onTap: controller.goToCatalog,
                  child: Container(
                    width: double.infinity,
                    height: 230,
                    decoration: BoxDecoration(
                      color: const Color(0xFF032541),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              "assets/images/catalog1.png",
                              width: 70,
                              height: 70,
                            ),
                            const SizedBox(height: 10),
                            Image.asset(
                              "assets/images/catelog2.png",
                              width: 70,
                              height: 50,
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: controller.goToCatalog,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.06,
                                  vertical: 10,
                                ),
                              ),
                              child: const Text(
                                "Shop Now",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Image.asset(
                            "assets/images/catelog3.png",
                            width: double.infinity,
                            height: 210,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // PORTFOLIO BUTTON
                Center(
                  child: ElevatedButton(
                    onPressed: controller.goToInvestment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF032541),
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.2,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Portfolio",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
