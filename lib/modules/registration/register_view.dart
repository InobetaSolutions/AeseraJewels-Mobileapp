
import 'package:aesera_jewels/modules/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'register_controller.dart';

class RegisterView extends GetWidget<RegisterController> {
  RegisterView({super.key});
   final authController = Get.put(AuthController());

  final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Image.asset('assets/images/onboarding_logo.png',
                  height: 100, width: 100, fit: BoxFit.contain),
              const SizedBox(height: 21),

              Text(
                'Register',
                style: GoogleFonts.lexend(
                  color: const Color(0xFF1A0F12),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 32),

              _buildLabel('User Name'),
              _buildInputField(
                controller: controller.nameController,
                hintText: 'Enter your name',
                hintStyle: GoogleFonts.lexend(
                  color: const Color(0xFF2596BE),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  LengthLimitingTextInputFormatter(30),
                ],
              ),

              const SizedBox(height: 20),

              _buildLabel('Mobile Number'),
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

              Obx(() => SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF09243D),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white))
                          : Text("Register",
                              style: GoogleFonts.lexend(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              )),
                    ),
                  )),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                      style: GoogleFonts.lexend(
                          color: const Color(0xFF2596BE), fontSize: 12)),
                           GestureDetector(
                    onTap: ()  {
                    controller.login();
                    },
                    child: Text("Login",
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

  Widget _buildLabel(String text) => Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(text,
              style: GoogleFonts.lexend(
                color: const Color(0xFF1A0F12),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
        ),
      );

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextStyle? hintStyle,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) =>
      Container(
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
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      );
}
