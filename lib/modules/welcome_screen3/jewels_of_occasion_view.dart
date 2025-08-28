import 'package:aesera_jewels/modules/welcome_screen3/jewels_for_occasion_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JewelsForOccasionScreen extends GetWidget<JewelsForOccasionController> {
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
                  'assets/images/Depth 4, Frame 0.png',
                      width: 390,
                  height: MediaQuery.of(context).size.height * 0.59,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    width: 54,
                    height: 33,
                    child: ElevatedButton(
                      onPressed: controller.onSkip,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        //shape: StadiumBorder(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Skip',
                        style: TextStyle(fontFamily: 'Manrope',fontSize: 16,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w700,
                        ),
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
                    "Jewellery for Every Occasion",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0A2A4D),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Turn your savings into beautiful jewellery with ease.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black,fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400,fontStyle: FontStyle.normal),
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
                     children: [_dot(), _dot(), _dot(isActive: true)],
                  ),
                  const SizedBox(height: 22),
                  GestureDetector(
                    onTap: controller.goTologin,
                    child: Container(
                      width: 60,
                      height: 60,
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
    width: isActive ? 20 : 10,
    height: 8,
    decoration: BoxDecoration(
      color: isActive ? Colors.black : Colors.black26,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

