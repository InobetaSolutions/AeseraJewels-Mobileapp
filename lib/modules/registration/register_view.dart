
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'register_controller.dart';

// class RegisterView extends GetWidget<RegisterController> {
//   RegisterView({super.key});
//   final controller = Get.put(RegisterController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SizedBox(
//           width: 390,
//           height: 844,
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 50),
//                 Image.asset(
//                   'assets/images/onboarding_logo.png',
//                   height: 100,
//                   fit: BoxFit.contain,
//                   width: 100,
//                 ),
//                 const SizedBox(height: 21),
//                 const Text(
//                   'Register', textAlign: TextAlign.center,
//                   style: TextStyle(fontFamily: 'Lexend',color: Color(0xFF1A0F12),fontSize: 18, fontWeight: FontWeight.w700),
//                 ),
//                 const SizedBox(height: 32),
          
//                 _buildLabel('User Name',style:GoogleFonts.lexend(
//                   color: Color(0xFF1A0F12),
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 ),
//                 // TextStyle(fontFamily: 'Lexend',color: Color(0xFF1A0F12),fontSize: 16, fontWeight: FontWeight.w500),
              
//                 _buildInputField(
//                   controller: controller.nameController,
//                   hintText: 'Enter your name',hintStyle: GoogleFonts.lexend(
//                     color:Color(0xFF2596BE),
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                   ),//(fontFamily: 'Lexend',color: Color(0xFF2596BE),fontSize: 16, fontWeight: FontWeight.w400),
//                   keyboardType: TextInputType.name,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
//                     LengthLimitingTextInputFormatter(30),
//                   ],
//                   // Pass the hintStyle as an argument if needed
                 
//                 ),
//                 const SizedBox(height: 20),
          
//                 _buildLabel('Mobile Number', style: GoogleFonts.lexend(
//                   color: Color(0xFF1A0F12),
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 //TextStyle(fontFamily: 'Lexend',color: Color(0xFF1A0F12),fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 _buildInputField(
//                   controller: controller.mobileController,
//                   hintText: 'Enter your mobile number',hintStyle:GoogleFonts.lexend(
//                     color:Color(0xFF2596BE),
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   // TextStyle(fontFamily: 'Lexend',color: Color(0xFF2596BE),fontSize: 16, fontWeight: FontWeight.w400),
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     LengthLimitingTextInputFormatter(10),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
          
                
//                 Obx(
//                   () => SizedBox(
//                     width: 398,
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed: controller.isLoading.value
//                           ? null
//                           : controller.register,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFF09243D),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: controller.isLoading.value
//                           ? const CircularProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation<Color>(
//                                 Colors.white,
//                               ),
//                             )
//                           :  Text(
//                               'Register',
//                               textAlign: TextAlign.center,
//                               style:GoogleFonts.lexend(
                                
//                                 color:Color(0xFFFAFAFA),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                               ),
                              
//                             ),
                            
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 32),
          
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                      Text(
//                       'Already have an account?',
//                       style: GoogleFonts.lexend(
//                         color: Color(0xFF2596BE),
//                         fontWeight: FontWeight.w400,
//                         fontSize: 12,
//                       ),
//                       //TextStyle(color: Color(0xFF2596BE),fontFamily: 'Lexend',fontWeight: FontWeight.w400,fontSize: 12),
//                     ),
//                     TextButton(
//                       onPressed: controller.login,
//                       child:  Text(
//                         'Login',
//                         style:GoogleFonts.lexend(
//                           color: Color(0xFF2596BE),
//                           fontWeight: FontWeight.w400,
//                           fontSize: 12,
//                         ),
//                         // TextStyle(color: Color(0xFF2596BE),fontFamily: 'Lexend',fontWeight: FontWeight.w400,fontSize: 12),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//               ],

//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLabel(String text, {required TextStyle style}) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 8.0),
//         child: Text(
//           text,
//           style: style,
//         ),
//       ),
//     );
//   }
//   Widget _buildInputField({
//     required TextEditingController controller,
//     required String hintText,
//     TextInputType keyboardType = TextInputType.text,
//     List<TextInputFormatter>? inputFormatters,
//     TextStyle? hintStyle,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 236, 247, 252),
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: const [
//           BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(-0,3), spreadRadius: 0.02),
//         ],
//       ),
//       child: TextField(
//         controller: controller,
//         keyboardType: keyboardType,
//         inputFormatters: inputFormatters,
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: hintStyle,
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 16,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'register_controller.dart';

class RegisterView extends GetWidget<RegisterController> {
  RegisterView({super.key});

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

              /// Logo
              Image.asset(
                'assets/images/onboarding_logo.png',
                height: 100,
                width: 100,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 21),

              /// Title
              Text(
                'Register',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  color: const Color(0xFF1A0F12),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 32),

              /// User Name
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

              /// Mobile Number
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

              /// Register Button
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF09243D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            'Register',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lexend(
                              color: const Color(0xFFFAFAFA),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// Login Option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: GoogleFonts.lexend(
                      color: const Color(0xFF2596BE),
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  TextButton(
                    onPressed: controller.login,
                    child: Text(
                      'Login',
                      style: GoogleFonts.lexend(
                        color: const Color(0xFF2596BE),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  /// Label
  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          text,
          style: GoogleFonts.lexend(
            color: const Color(0xFF1A0F12),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// Input Field
  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextStyle? hintStyle,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF6FDFF),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(-0, 3),
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
