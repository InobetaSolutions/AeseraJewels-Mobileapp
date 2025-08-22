import 'package:aesera_jewels/modules/otpverification/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpView extends GetWidget<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              top: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/images/sample registraion 2-artguru 1.png',
                  height: 100,
                ),

                const SizedBox(
                  height: 40,
                ), // Reduced the gap to match the image
                // Title and Description
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'Enter the code we just sent you',
                        textAlign: TextAlign
                            .start, // Aligning text to the start (left)
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'We sent a verification code to +91 123-456-7890. Enter the code below to verify your account.',
                          textAlign: TextAlign
                              .start, // Aligning text to the start (left)
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16), // Reduced the gap
                // OTP Fields with auto-navigation and focus node handling
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 45, // Reduced width for smaller OTP fields
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              spreadRadius: 0.1,
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(-3, 3),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: controller.otpControllers[index],
                          focusNode: controller.focusNodes[index],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Color(0xFFF5FCFF),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            // Focus forward if not empty
                            if (value.isNotEmpty && index < 3) {
                              controller.focusNodes[index + 1].requestFocus();
                            }
                            // Focus backward if empty
                            if (value.isEmpty && index > 0) {
                              controller.focusNodes[index - 1].requestFocus();
                            }
                          },
                          onSubmitted: (_) {
                            if (index == 3) controller.verifyOtp();
                          },
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 18), // Reduced the gap
                // Did not receive code section (bottom left)
                Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Didn’t receive the code?',
                          style: TextStyle(color: Colors.blue),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                        onPressed: controller.resendCode,
                        child: const Text(
                          'Resend Code',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),
                // Verify OTP Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: controller.verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A2342),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Verify OTP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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
