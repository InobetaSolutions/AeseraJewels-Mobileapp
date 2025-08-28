// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'otp_controller.dart';

// class OtpView extends GetWidget<OtpController> {
//   OtpView({super.key});
// final OtpController controller = Get.put(OtpController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Scrollbar(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.only(
//               left: 24,
//               right: 24,
//               bottom: MediaQuery.of(context).viewInsets.bottom + 24,
//               top: 32,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: 5),
//                 Image.asset(
//                   'assets/images/onboarding_logo.png',
//                   height: 100,
//                   width: 100,
//                   fit: BoxFit.contain,
//                 ),
//                 const SizedBox(height: 40),
//                  Text(
//                   'Enter the code we just sent you',
//                   style:GoogleFonts.lexend(
//                   textStyle: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFF1A0F12),
//                   ),
//              ) //TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
//                 ),
//                  SizedBox(height: 13),
//                 Obx(
//                   () => Text(
//                      'We sent a verification code to +91 ${controller.mobile}. Enter the code below to verify your account.',
//                   style: GoogleFonts.lexend(
                  
//                     fontSize: 16,
//                     color: Color(0xFF1A0F12),
//                    fontWeight: FontWeight.w400,
//                     height: 1.5
                  
//                   ),
//                    textAlign: TextAlign.start,
//                     //'We sent a verification code to +91 ${controller.mobile}.',
//                   ),
//                 ),
//                  SizedBox(height: 16),
//                  SizedBox(
//   width: 240,
//   height: 56,
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: List.generate(4, (index) {
//       return SizedBox(
//         width: 50,
//         height: 56,
//         child: Container(
//           decoration: BoxDecoration(
//             color: const Color(0xFFF6FDFF),
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(
//               color: Colors.black,
//               width: 2,
//             ),
//             boxShadow: const [
//               BoxShadow(
//                 color: Color(0x66000000), // #00000040
//                 offset: Offset(0, -4),
//                 blurRadius: 4,
//                 spreadRadius: 0,
//                 inset: true, // Flutter doesn't support inset by default
//               ),
//             ],
//           ),
//           child: TextField(
//             controller: controller.otpControllers[index],
//             focusNode: controller.focusNodes[index],
//             keyboardType: TextInputType.number,
//             maxLength: 1,
//             textAlign: TextAlign.center,
//             style: GoogleFonts.lexend(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//             decoration: const InputDecoration(
//               counterText: '',
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.symmetric(vertical: 8),
//             ),
//           ),
//         ),
//       );
//     }),
//   ),
// )

                      
                
//                           onChanged: (value) {
//                             if (value.isNotEmpty && index < 3) {
//                               controller.focusNodes[index + 1].requestFocus();
//                             }
//                             if (value.isEmpty && index > 0) {
//                               controller.focusNodes[index - 1].requestFocus();
//                             }
//                             if (controller.enteredOtp.length == 4) {
//                            controller.verifyOtp();
//                           }
//                           },
//                           onSubmitted: (_) {
//                             if (index == 3) controller.verifyOtp();
//                           },
//                       ),
//                       );
//                     },
//                     ),
//                   ), 
//                 ),
//                  SizedBox(height: 19),

//                 Align(
//                   alignment: Alignment.bottomLeft,
//                   child: TextButton(
//                     onPressed: controller.resendCode,
//                     child: Text(
//                       'Didnt receive the code?',
//                        style: GoogleFonts.lexend(
//                         fontSize: 14,
//                         color: Color(0xFF2596BE),
                       
//                         fontWeight: FontWeight.w400,
//                       ),
//                   ),
//                 ),
//                 ),
//                 Obx(() => Align(
//                     alignment: Alignment.bottomLeft,
//                   child: TextButton(
//                             onPressed: controller.isResendAvailable.value
//                                 ? controller.resendCode
//                                 : null,
//                             child: Text(
//                               controller.isResendAvailable.value
//                                   ? 'Resend Code'
//                                   : 'Resend in ${controller.resendCountdown.value}s',
//                               style:  GoogleFonts.lexend(
//                                 color: Color(0xFF2596BE),
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                               ),
//                             ),
//                 ),
//                       ),
//               SizedBox(height: 10),

//               /// Verify Button
//               Obx(
//                   () => SizedBox(
//                     width: 358,
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed: controller.isLoading.value
//                           ? null
//                           : controller.verifyOtp,
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
//                               'Verify OTP',
//                               style:GoogleFonts.lexend(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                               color: Colors.white,
                              
//                               ),
//                             ),
//                     ),
//                   ),
//                 ),
//             ),
//               ],
//           ),
//         ),
//     ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'otp_controller.dart';

class OtpView extends GetWidget<OtpController> {
  OtpView({super.key});

  final OtpController controller = Get.put(OtpController());

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
                const SizedBox(height: 5),
                Image.asset(
                  'assets/images/onboarding_logo.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 40),
                Text(
                  'Enter the code we just sent you',
                  style: GoogleFonts.lexend(
                    textStyle: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A0F12),
                    ),
                  ),
                ),
                const SizedBox(height: 13),
                Obx(
                  () => Text(
                    'We sent a verification code to +91 ${controller.mobile}. Enter the code below to verify your account.',
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      color: Color(0xFF1A0F12),
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(height: 16),

                /// OTP Input Boxes
                SizedBox(
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
                            border: Border.all(
                              color: Colors.black,
                              width: 1.5,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x66000000), // #00000040
                                offset: Offset(0, 1),
                                blurRadius: 4,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: controller.otpControllers[index],
                            focusNode: controller.focusNodes[index],
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lexend(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 3) {
                                controller.focusNodes[index + 1].requestFocus();
                              }
                              if (value.isEmpty && index > 0) {
                                controller.focusNodes[index - 1].requestFocus();
                              }
                              if (controller.enteredOtp.length == 4) {
                                controller.verifyOtp();
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
                ),
                const SizedBox(height: 19),
               Align(
                  alignment: Alignment.bottomLeft,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   // Align children to left
                   children: [
                     Text(
                       'Didn’t receive the code?',
                       style: GoogleFonts.lexend(
                         fontSize: 14,
                         color: const Color(0xFF2596BE),
                         fontWeight: FontWeight.w400,
                       ),
                     ),
                     Obx(
                       () => TextButton(
                         style: TextButton.styleFrom(
                           // removes extra padding for better alignment
                            // ensures text stays left
                         ),
                         onPressed: controller.isResendAvailable.value
                             ? controller.resendCode
                             : null,
                         child: Text(
                           controller.isResendAvailable.value
                               ? 'Resend Code'
                               : 'Resend in ${controller.resendCountdown.value}s',
                           style: GoogleFonts.lexend(
                             color: const Color(0xFF2596BE),
                             fontSize: 14,
                             fontWeight: FontWeight.w400,
                           ),
                           //textAlign: TextAlign.start,
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
const SizedBox(height: 10),


                
                Obx(
                  () => SizedBox(
                    width: 358,
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
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            )
                          : Text(
                              'Verify OTP',
                              style: GoogleFonts.lexend(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
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
