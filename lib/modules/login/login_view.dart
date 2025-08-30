
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_controller.dart';

class LoginView extends GetWidget<LoginController> {
  LoginView({super.key});
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 64),
              Image.asset(
                'assets/images/onboarding_logo.png',
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 75),

              /// Login card
              Container(width: 359,height: 47,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(8),
                
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      color: const Color(0xFF1A0F12),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              /// Mobile Number Label
              Align(
                alignment: Alignment.centerLeft,
                child: _buildLabel('Mobile Number'),
              ),

              const SizedBox(height: 8),

              /// Mobile Number Input
              _buildInputField(
                controller: controller.mobileController,
                hintText: 'Enter your mobile number',
                hintStyle: GoogleFonts.lexend(
                  color: const Color(0xFF2596BE),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),

              const SizedBox(height: 32),

              /// Submit button
              Obx(
                () => SizedBox(
                  width: 358,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A2342),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          )
                        : Text(
                            'Submit',
                            style: GoogleFonts.lexend(
                              color: const Color(0xFFFAFAFA),
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
                 Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn't have an account?",
                      style: GoogleFonts.lexend(
                          color: const Color(0xFF2596BE), fontSize: 12)),
                  TextButton(
                    onPressed: controller.register,
                    child: Text("register",
                        style: GoogleFonts.lexend(
                            color: const Color(0xFF2596BE), fontSize: 12)),
                  )
                ],
              ),
             
             
            ],
          ),
        ),
      ),
    );
  }

  /// Helper for label
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.lexend(
        color: const Color(0xFF1A0F12),
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  /// Helper for input field
  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextStyle? hintStyle,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      width: 358,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF6FDFF),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 3),
            spreadRadius: 0.02,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
