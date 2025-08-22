//import 'package:aesera_jewels/modules/JewelsForOccasion_screen1.dart/seamlesspayments_controller.dart';
import 'package:aesera_jewels/modules/welcome_screen1.dart/seamless_payments_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeamlessPaymentView extends GetView<SeamlessPaymentController> {
  const SeamlessPaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// Image & Skip Button
            Stack(
              children: [
                Image.asset(
                  "assets/images/Depth 3, Frame 0.png",
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.60,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: ElevatedButton(
                    onPressed: controller.onSkip,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    "Easy and Seamless Payments",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A2A4D),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Secure your financial future with gold effortless\n saving mode easy and seamless.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.5, color: Colors.black45),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [_dot(isActive: true), _dot(), _dot()],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: controller.onForward,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0A2A4D),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _dot({bool isActive = false}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    width: isActive ? 18 : 10,
    height: 10,
    decoration: BoxDecoration(
      color: isActive ? Colors.black : Colors.black26,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
