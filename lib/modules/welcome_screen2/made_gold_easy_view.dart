import 'package:aesera_jewels/modules/welcome_screen2/made_gold_easy_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MadeGoldEasyScreen extends  GetWidget<MadeGoldEasyController> {
  const MadeGoldEasyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MadeGoldEasyController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// Image & Skip Button
            Stack(
              children: [
                Image.asset(
                  'assets/images/Depth 2, Frame 0.png',
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
                      onPressed: controller.skip,
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
                    "Saving in Gold Made Easy",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0A2A4D),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Start building wealth with ease - saving in\n gold mode simple, accessible and hassle-free",
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
                   children: [_dot(),  _dot(isActive: true),_dot(),]
                  ),
                  const SizedBox(height: 22),
                  GestureDetector(
                    onTap: controller.goToJewelsForOccasion,
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

