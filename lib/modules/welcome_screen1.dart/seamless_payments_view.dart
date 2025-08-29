//import 'package:aesera_jewels/modules/JewelsForOccasion_screen1.dart/seamlesspayments_controller.dart';
import 'package:aesera_jewels/modules/welcome_screen1.dart/seamless_payments_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeamlessPaymentView extends GetWidget<SeamlessPaymentController> {
   SeamlessPaymentView({Key? key}) : super(key: key);
final SeamlessPaymentController controller = Get.put(SeamlessPaymentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            /// Image & Skip Button
            Stack(
              children: [
                Image.asset(
                  "assets/images/Depth 3, Frame 0.png",
                  
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
                    "Easy and Seamless Payments",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.7,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0A2A4D),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Secure your financial future with gold\n effortless saving mode easy and seamless.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.black,fontFamily: 'Lexend',
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
                    children: [_dot(isActive: true), _dot(), _dot()],
                  ),
                  const SizedBox(height: 22),
                  GestureDetector(
                    onTap: controller.onForward,
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
