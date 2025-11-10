
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'otp_controller.dart';

class OtpScreen extends GetWidget<OtpController> {
  OtpScreen({super.key});
  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Image.asset('assets/images/onboarding screen.png', height: 100),
              const SizedBox(height: 40),

              Text(
                'Enter the code we just sent you',
                style: GoogleFonts.lexend(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A0F12),
                ),
              ),
              const SizedBox(height: 13),

              Obx(() => Text(
                    'We sent a verification code to +91 ${controller.mobile}. '
                    'Enter code to verify your account.\n(Current OTP: ${controller.otp})',
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      color: const Color(0xFF1A0F12),
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(height: 16),
                 Container(
                width: 240,
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 50,
                      height: 56,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6FDFF),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black, width: 1),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x66000000),
                              offset: Offset(0, 1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                         child: TextField(
                            controller: controller.otpControllers[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                            ),
                            style: TextStyle(fontSize: 24),
                            // ✅ Auto focus move only, no auto-submit
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 3) {
                                FocusScope.of(context).nextFocus();
                              }
                              if (value.isEmpty && index > 0) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                          ),
                        
                      ),
                    );
                  }),
                ),
              ),
              
              // ),
              const SizedBox(height: 24),

              /// ✅ Verify OTP Button
              Obx(() => SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF09243D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Verify OTP',
                              style: GoogleFonts.lexend(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  )),
              const SizedBox(height: 16),

              /// ✅ Resend Code
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Didn't receive the code? "),
                  GestureDetector(
                    onTap: () async {
                      await controller.resendOtp();
                    },
                    child: Text(
                      'Resend Code',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
