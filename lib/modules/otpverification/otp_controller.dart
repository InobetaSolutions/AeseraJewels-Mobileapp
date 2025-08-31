

// // // // // import 'dart:async';

// // // // // import 'package:aesera_jewels/Api/base_url.dart';
// // // // // import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// // // // // import 'dart:convert';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:get/get.dart';
// // // // // import 'package:http/http.dart' as http;

// // // // // class OtpController extends GetxController {
// // // // //   final otpControllers = List.generate(4, (_) => TextEditingController());
// // // // //   final focusNodes = List.generate(4, (_) => FocusNode());
// // // // //   final isLoading = false.obs;
// // // // //   final isResendAvailable = true.obs; // For enabling/disabling resend
// // // // //   final resendCountdown = 0.obs;
// // // // //   final otp =  ''.obs;
// // // // //   final name = ''.obs; 
// // // // //   var isNewUser = false;
// // // // //   bool lastVerifySuccess = false;
 
// // // // //  // Add this line to define the _timer variable

// // // // //   final mobile = ''.obs;
// // // // //   final otp = ''.obs;
// // // // //   final token = ''.obs;


// // // // //   @override
// // // // //   void onInit() {
// // // // //     // super.onInit(); // Removed due to superclass not defining onInit
// // // // //     final args = Get.arguments;
// // // // //     if(args != null) {
// // // // //        name.value = args['name']?.toString() ?? '';
// // // // //       isNewUser = args['isNewUser'] ?? false;
// // // // //     isNewUser = args['isNewUser'] ?? false;
// // // // //     mobile.value = args['mobile'] ?.toString() ?? ''; 
// // // // //     token.value = args['token'] ?? '';
// // // // //     otp.value = args['otp'] ?.toString() ?? '';
// // // // //     print("Received OTP: ${otp.value}");
// // // // //       return;
// // // // //     }
// // // // //     for (int i = 0; i < otpControllers.length; i++) {
// // // // //       otpControllers[i].addListener(() {
// // // // //         if (otpControllers[i].text.length == 1 && i < otpControllers.length - 1) {
// // // // //           focusNodes[i + 1].requestFocus();
// // // // //         } else if (otpControllers[i].text.isEmpty && i > 0) {
// // // // //           focusNodes[i - 1].requestFocus();
// // // // //         }
// // // // //       });
// // // // //     }
   
// // // // //   }

// // // // //   String get enteredOtp => otpControllers.map((c) => c.text).join();
// // // // //  get receivedOtp => null;
// // // // //   void verifyOtp() async {
// // // // //     if (enteredOtp.length != 4) {
// // // // //       Get.snackbar('Invalid OTP', 'Please enter the 4-digit OTP.');
// // // // //       return;
// // // // //     }

// // // // //     isLoading.value = true;

// // // // //     try {
// // // // //       final url = Uri.parse('${BaseUrl.baseUrl}verify-otp');
// // // // //       final headers = {
// // // // //         'Content-Type': 'application/json',
// // // // //         'Authorization': 'Bearer ${token.value}',
// // // // //       };

// // // // //       final body = json.encode({"mobile": mobile.value, "otp": enteredOtp});

// // // // //       final response = await http.post(url, headers: headers, body: body);
// // // // //       isLoading.value = false;

// // // // //       if (response.statusCode == 200) {
// // // // //         final data = jsonDecode(response.body);
// // // // //         if (data['message'].toString().toLowerCase().contains('success')) {
// // // // //           Get.snackbar('Success', 'OTP verified successfully');
// // // // //           //Get.offAllNamed('/dashboard');
// // // // //             Get.offAllNamed('/dashboard', arguments: {
// // // // //             'token': token,
// // // // //             'isNewUser': true,
// // // // //             'name': name,
            
// // // // //           });
// // // // //         } else {
// // // // //           Get.snackbar('Error', data['message'] ?? 'Invalid OTP');
// // // // //         }
// // // // //       } else {
// // // // //         print(  response.body);
// // // // //         Get.snackbar('Error', 'Server error: ${response.reasonPhrase}');
// // // // //       }
// // // // //     } catch (e) {
// // // // //       isLoading.value = false;
// // // // //       Get.snackbar('Error', 'Something went wrong: $e');
// // // // //     }
// // // // //   }

// // // // //   void resendCode() {
// // // // //      if (!isResendAvailable.value) return;
// // // // //     if (data["message"] == "OTP resent") {
// // // // //           otp.value = data["otp"]?.toString() ?? '';
// // // // //           Get.snackbar('OTP Sent', 'New OTP: ${otp.value}');
// // // // //         } else {
// // // // //           Get.snackbar('Error', data["message"] ?? 'Failed to resend OTP');
// // // // //         }
// // // // //       } else {
// // // // //         Get.snackbar('Error', response.reasonPhrase ?? 'Unknown error');
// // // // //       }
// // // // //     } catch (e) {
// // // // //       Get.snackbar('Error', 'Failed to resend OTP: ${e.toString()}');
// // // // //     }
// // // // //   }
// // // // //     Get.snackbar("Resend OTP : ${enteredOtp}", "OTP sent to ${mobile.value}");
// // // // //      isResendAvailable.value = false;
// // // // //     resendCountdown.value = 30;

   
// // // // //       if (resendCountdown.value > 0) {
// // // // //         resendCountdown.value--;
// // // // //       } else {
       
// // // // //         isResendAvailable.value = true;
// // // // //       }
// // // // //     });
// // // // //   }

// // // // //   @override
// // // // //   void onClose() {
// // // // //     for (var c in otpControllers) {
// // // // //       c.dispose();
// // // // //     }
// // // // //     for (var node in focusNodes) {
// // // // //       node.dispose();
// // // // //     }
// // // // //     _timer?.cancel();
// // // // //   }
// // // // // }

// // // // import 'dart:async';
// // // // import 'dart:convert';
// // // // import 'package:aesera_jewels/Api/base_url.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:get/get.dart';
// // // // import 'package:http/http.dart' as http;

// // // // class OtpController extends GetxController {
// // // //   final otpControllers = List.generate(4, (_) => TextEditingController());
// // // //   final focusNodes = List.generate(4, (_) => FocusNode());
// // // //   final isLoading = false.obs;
// // // //   final isResendAvailable = true.obs; 
// // // //   final resendCountdown = 0.obs;

// // // //   final otp = ''.obs;
// // // //   final name = ''.obs;
// // // //   final mobile = ''.obs;
// // // //   final token = ''.obs;

// // // //   var isNewUser = false;
// // // //   Timer? _timer;

// // // //   @override
// // // //   void onInit() {
// // // //     super.onInit();
// // // //     final args = Get.arguments;
// // // //     if (args != null) {
// // // //       name.value = args['name']?.toString() ?? '';
// // // //       isNewUser = args['isNewUser'] ?? false;
// // // //       mobile.value = args['mobile']?.toString() ?? '';
// // // //       token.value = args['token'] ?? '';
// // // //       otp.value = args['otp']?.toString() ?? '';
// // // //       print("Received OTP from server: ${otp.value}");
// // // //     }

// // // //     for (int i = 0; i < otpControllers.length; i++) {
// // // //       otpControllers[i].addListener(() {
// // // //         if (otpControllers[i].text.length == 1 && i < otpControllers.length - 1) {
// // // //           focusNodes[i + 1].requestFocus();
// // // //         } else if (otpControllers[i].text.isEmpty && i > 0) {
// // // //           focusNodes[i - 1].requestFocus();
// // // //         }
// // // //       });
// // // //     }
// // // //   }

// // // //   String get enteredOtp => otpControllers.map((c) => c.text).join();

// // // //   /// Verify OTP
// // // //   Future<void> verifyOtp() async {
// // // //     if (enteredOtp.length != 4) {
// // // //       Get.snackbar('Invalid OTP', 'Please enter the 4-digit OTP.');
// // // //       return;
// // // //     }

// // // //     isLoading.value = true;
// // // //     try {
// // // //       final url = Uri.parse('${BaseUrl.baseUrl}verify-otp');
// // // //       final headers = {
// // // //         'Content-Type': 'application/json',
// // // //         'Authorization': 'Bearer ${token.value}',
// // // //       };
// // // //       final body = json.encode({"mobile": mobile.value, "otp": enteredOtp,});

// // // //       final response = await http.post(url, headers: headers, body: body);
// // // //       isLoading.value = false;

// // // //       if (response.statusCode == 200) {
// // // //         final data = jsonDecode(response.body);
// // // //         print("Verify OTP Response: $data");

// // // //         if (data['message'].toString().toLowerCase().contains('success')) {
// // // //           Get.snackbar('Success', 'OTP verified successfully');
// // // //          Get.offAllNamed('/dashboard', arguments: {
// // // //   'name': name.value,   // comes from OTP controller
// // // //   'token': token.value,
// // // //   'isNewUser': isNewUser,
// // // // });

// // // //         } else {
// // // //           Get.snackbar('Error', data['message'] ?? '$data');
// // // //         }
// // // //       } else {
// // // //         print(response.body);
// // // //         Get.snackbar('Error', 'Server error: ${response.reasonPhrase}');
// // // //       }
// // // //     } catch (e) {
// // // //       isLoading.value = false;
// // // //       Get.snackbar('Error', 'Something went wrong: $e');
// // // //     }
// // // //   }

// // // //   /// Resend OTP
// // // //   Future<void> resendCode() async {
// // // //     if (!isResendAvailable.value) return;

// // // //     try {
// // // //       final url = Uri.parse('${BaseUrl.baseUrl}resend-otp');
// // // //       final headers = {
// // // //         'Content-Type': 'application/json',
// // // //         'Authorization': 'Bearer ${token.value}',
// // // //       };
// // // //       final body = json.encode({"mobile": mobile.value});

// // // //       final response = await http.post(url, headers: headers, body: body);

// // // //       if (response.statusCode == 200) {
// // // //         final data = jsonDecode(response.body);
// // // //         print("Resend OTP Response: $data");

// // // //         if (data["message"] == "OTP resent") {
// // // //           otp.value = data["otp"]?.toString() ?? '';
// // // //           Get.snackbar('OTP Sent', 'New OTP: ${otp.value}');
// // // //         } else {
// // // //           Get.snackbar('Error', data["message"] ?? 'Failed to resend OTP');
// // // //         }
// // // //       } else {
// // // //         Get.snackbar('Error', response.reasonPhrase ?? 'Unknown error');
// // // //       }
// // // //     } catch (e) {
// // // //       Get.snackbar('Error', 'Failed to resend OTP: ${e.toString()}');
// // // //     }

// // // //     // Start countdown timer
// // // //     isResendAvailable.value = false;
// // // //     resendCountdown.value = 30;
// // // //     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
// // // //       if (resendCountdown.value > 0) {
// // // //         resendCountdown.value--;
// // // //       } else {
// // // //         isResendAvailable.value = true;
// // // //         timer.cancel();
// // // //       }
// // // //     });
// // // //   }

// // // //   @override
// // // //   void onClose() {
// // // //     for (var c in otpControllers) {
// // // //       c.dispose();
// // // //     }
// // // //     for (var node in focusNodes) {
// // // //       node.dispose();
// // // //     }
// // // //     _timer?.cancel();
// // // //     super.onClose();
// // // //   }
// // // // }
// // // import 'dart:convert';
// // // import 'package:aesera_jewels/Api/base_url.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:http/http.dart' as http;

// // // class OtpController extends GetxController {
// // //   final otpController = TextEditingController();

// // //   final isLoading = false.obs;
// // //   final otp = ''.obs;
// // //   final name = ''.obs;
// // //   final mobile = ''.obs;
// // //   final token = ''.obs;

// // //   var isNewUser = false;

// // //   var otpControllers;

// // //   @override
// // //   void onInit() {
// // //     super.onInit();
// // //     final args = Get.arguments;
// // //     if (args != null) {
// // //       name.value = args['name'] ?? '';
// // //       mobile.value = args['mobile'] ?? '';
// // //       token.value = args['token'] ?? '';
// // //       otp.value = args['otp'] ?? '';
// // //       isNewUser = args['isNewUser'] ?? false;
// // //     }
// // //   }

// // //   /// ✅ Verify OTP
// // //   Future<void> verifyOtp() async {
// // //     if (otpController.text.isEmpty) {
// // //       Get.snackbar('Invalid OTP', 'Please enter the OTP.');
// // //       return;
// // //     }

// // //     isLoading.value = true;
// // //     try {
// // //       final url = Uri.parse("${BaseUrl.baseUrl}verify-otp");
// // //       final response = await http.post(
// // //         url,
// // //         headers: {
// // //           "Content-Type": "application/json",
// // //           "Authorization": "Bearer ${token.value}",
// // //         },
// // //         body: jsonEncode({"mobile": mobile.value, "otp": otpController.text}),
// // //       );

// // //       isLoading.value = false;

// // //       if (response.statusCode == 200) {
// // //         final data = jsonDecode(response.body);
// // //         if (data['message'].toString().toLowerCase().contains("success")) {
// // //           Get.snackbar('Success', 'OTP verified successfully');
// // //           Get.offAllNamed('/dashboard', arguments: {
// // //             "name": name.value,
// // //             "token": token.value,
// // //             "isNewUser": isNewUser,
// // //           });
// // //         } else {
// // //           Get.snackbar("Error", data['message'] ?? "Invalid OTP");
// // //         }
// // //       } else {
// // //         Get.snackbar("Error", "Server error: ${response.reasonPhrase}");
// // //       }
// // //     } catch (e) {
// // //       isLoading.value = false;
// // //       Get.snackbar("Error", "Something went wrong: $e");
// // //     }
// // //   }

// // //   /// ✅ Resend OTP → update `otp` and show
// // //   Future<void> resendCode() async {
// // //     try {
// // //       final url = Uri.parse("${BaseUrl.baseUrl}resend-otp");
// // //       final response = await http.post(
// // //         url,
// // //         headers: {
// // //           "Content-Type": "application/json",
// // //           "Authorization": "Bearer ${token.value}",
// // //         },
// // //         body: jsonEncode({"mobile": mobile.value}),
// // //       );

// // //       if (response.statusCode == 200) {
// // //         final data = jsonDecode(response.body);
// // //         otp.value = data['otp'] ?? '';
// // //         Get.snackbar(
// // //           "OTP Resent",
// // //           "New OTP: ${otp.value}",
// // //           snackPosition: SnackPosition.BOTTOM,
// // //           backgroundColor: Colors.green.shade600,
// // //           colorText: Colors.white,
// // //         );
// // //       } else {
// // //         Get.snackbar("Error", "Resend failed");
// // //       }
// // //     } catch (e) {
// // //       Get.snackbar("Error", "Resend failed: $e");
// // //     }
// // //   }

// // //   @override
// // //   void onClose() {
// // //     otpController.dispose();
// // //     super.onClose();
// // //   }
// // // }
// // import 'dart:convert';
// // import 'package:aesera_jewels/Api/base_url.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;

// // class OtpController extends GetxController {
// //   /// 4 controllers for OTP boxes
// //   final otpControllers = List.generate(4, (_) => TextEditingController());
// //   final focusNodes = List.generate(4, (_) => FocusNode());

// //   final isLoading = false.obs;
// //   final otp = ''.obs;     // OTP from backend (for debug/display)
// //   final name = ''.obs;    // user name
// //   final mobile = ''.obs;  // user mobile
// //   final token = ''.obs;   // API token

// //   var isNewUser = false;

// //   @override
// //   void onInit() {
// //     super.onInit();

// //     /// receive data from Register screen
// //     final args = Get.arguments;
// //     if (args != null) {
// //       name.value = args['name']?.toString() ?? '';
// //       mobile.value = args['mobile']?.toString() ?? '';
// //       token.value = args['token']?.toString() ?? '';
// //       otp.value = args['otp']?.toString() ?? '';
// //       isNewUser = args['isNewUser'] ?? false;
// //     }

// //     /// auto focus jump forward/backward
// //     for (int i = 0; i < otpControllers.length; i++) {
// //       otpControllers[i].addListener(() {
// //         if (otpControllers[i].text.length == 1 && i < otpControllers.length - 1) {
// //           focusNodes[i + 1].requestFocus();
// //         } else if (otpControllers[i].text.isEmpty && i > 0) {
// //           focusNodes[i - 1].requestFocus();
// //         }
// //       });
// //     }
// //   }

// //   /// collect entered OTP
// //   String get enteredOtp => otpControllers.map((c) => c.text).join();

// //   /// ✅ Verify OTP API
// //   Future<void> verifyOtp() async {
// //     if (enteredOtp.length != 4) {
// //       Get.snackbar('Invalid OTP', 'Please enter the 4-digit OTP.');
// //       return;
// //     }

// //     isLoading.value = true;
// //     try {
// //       final url = Uri.parse("${BaseUrl.baseUrl}verify-otp");
// //       final response = await http.post(
// //         url,
// //         headers: {
// //           "Content-Type": "application/json",
// //           "Authorization": "Bearer ${token.value}",
// //         },
// //         body: jsonEncode({
// //           "mobile": mobile.value,
// //           "otp": enteredOtp,
// //         }),
// //       );

// //       isLoading.value = false;

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);

// //         if (data['message'].toString().toLowerCase().contains("success")) {
// //           Get.snackbar('Success', '${name.value}');

// //           /// ✅ Pass dynamic name to Dashboard
// //           Get.offAllNamed('/dashboard', arguments: {
// //             "name": name.value,
// //             "token": token.value,
// //             "isNewUser": isNewUser,
// //           });
// //         } else {
// //           Get.snackbar("Error", data['message'] ?? "Invalid OTP");
// //         }
// //       } else {
// //         Get.snackbar("Error", "Server error: ${response.reasonPhrase}");
// //       }
// //     } catch (e) {
// //       isLoading.value = false;
// //       Get.snackbar("Error", "Something went wrong: $e");
// //     }
// //   }

// //   /// ✅ Resend OTP API
// //   Future<void> resendCode() async {
// //     try {
// //       final url = Uri.parse("${BaseUrl.baseUrl}resend-otp");
// //       final response = await http.post(
// //         url,
// //         headers: {
// //           "Content-Type": "application/json",
// //           "Authorization": "Bearer ${token.value}",
// //         },
// //         body: jsonEncode({"mobile": mobile.value}),
// //       );

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         otp.value = data['otp']?.toString() ?? '';

// //         Get.snackbar(
// //           "OTP Resent",
// //           "New OTP: ${otp.value}\nresendCode:${response.body}",
// //           snackPosition: SnackPosition.TOP,
// //           backgroundColor: Colors.green.shade600,
// //           colorText: Colors.white,
// //         );
// //       } else {
// //         Get.snackbar("Error", "Resend failed: ${response.reasonPhrase}");
// //       }
// //     } catch (e) {
// //       Get.snackbar("Error", "Resend failed: $e");
// //     }
// //   }

// //   @override
// //   void onClose() {
// //     for (var c in otpControllers) {
// //       c.dispose();
// //     }
// //     for (var node in focusNodes) {
// //       node.dispose();
// //     }
// //     super.onClose();
// //   }
// // }
// import 'dart:convert';
// import 'package:aesera_jewels/Api/base_url.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class OtpController extends GetxController {
//   /// 4 controllers for OTP boxes
//   final otpControllers = List.generate(4, (_) => TextEditingController());
//   final focusNodes = List.generate(4, (_) => FocusNode());

//   final isLoading = false.obs;
//   final otp = ''.obs;     // OTP from backend (for debug/display)
//   final name = ''.obs;    // user name
//   final mobile = ''.obs;  // user mobile
//   final token = ''.obs;   // API token

//   var isNewUser = false;

//   @override
//   void onInit() {
//     super.onInit();

//     /// receive data from Register screen
//     final args = Get.arguments;
//     if (args != null) {
//       name.value = args['name']?.toString() ?? '';
//       mobile.value = args['mobile']?.toString() ?? '';
//       token.value = args['token']?.toString() ?? '';
//       otp.value = args['otp']?.toString() ?? '';
//       isNewUser = args['isNewUser'] ?? false;
//     }

//     /// auto focus jump forward/backward
//     for (int i = 0; i < otpControllers.length; i++) {
//       otpControllers[i].addListener(() {
//         if (otpControllers[i].text.length == 1 && i < otpControllers.length - 1) {
//           focusNodes[i + 1].requestFocus();
//         } else if (otpControllers[i].text.isEmpty && i > 0) {
//           focusNodes[i - 1].requestFocus();
//         }
//       });
//     }
//   }

//   /// collect entered OTP
//   String get enteredOtp => otpControllers.map((c) => c.text).join();

//   /// ✅ Verify OTP API
//   Future<void> verifyOtp() async {
//     if (enteredOtp.length != 4) {
//       Get.snackbar('Invalid OTP', 'Please enter the 4-digit OTP.');
//       return;
//     }

//     isLoading.value = true;
//     try {
//       final url = Uri.parse("${BaseUrl.baseUrl}verify-otp");
//       final response = await http.post(
//         url,
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer ${token.value}",
//         },
//         body: jsonEncode({
//           "mobile": mobile.value,
//           "otp": enteredOtp,
//         }),
//       );

//       isLoading.value = false;

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         if (data['message']?.toString().toLowerCase().contains("success") ?? false) {
//           Get.snackbar(
//             'Success',
//             'OTP verified successfully',
//             snackPosition: SnackPosition.TOP,
//             backgroundColor: Colors.green.shade600,
//             colorText: Colors.white,
//           );

//           /// ✅ Navigate to Dashboard with args
//           Get.offAllNamed('/dashboard', arguments: {
//             "name": name.value,
//             "token": token.value,
//             "isNewUser": isNewUser,
//           });
//         } else {
//           Get.snackbar("Error", data['message'] ?? "Invalid OTP");
//         }
//       } else {
//         Get.snackbar("Error", "Server error: ${response.reasonPhrase}");
//       }
//     } catch (e) {
//       isLoading.value = false;
//       Get.snackbar("Error", "Something went wrong: $e");
//     }
//   }

//   /// ✅ Resend OTP API
//   Future<void> resendCode() async {
//     try {
//       final url = Uri.parse("${BaseUrl.baseUrl}resend-otp");
//       final response = await http.post(
//         url,
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer ${token.value}",
//         },
//         body: jsonEncode({"mobile": mobile.value}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         otp.value = data['otp']?.toString() ?? '';

//         Get.snackbar(
//           "OTP Resent",
//           "A new OTP has been sent to ${mobile.value}",
//           snackPosition: SnackPosition.TOP,
//           backgroundColor: Colors.blue.shade600,
//           colorText: Colors.white,
//         );

//         /// clear old input fields
//         for (var c in otpControllers) {
//           c.clear();
//         }
//         focusNodes.first.requestFocus();
//       } else {
//         Get.snackbar("Error", "Resend failed: ${response.reasonPhrase}");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Resend failed: $e");
//     }
//   }

//   @override
//   void onClose() {
//     for (var c in otpControllers) {
//       c.dispose();
//     }
//     for (var node in focusNodes) {
//       node.dispose();
//     }
//     super.onClose();
//   }
// }
import 'dart:convert';
import 'package:aesera_jewels/Api/base_url.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OtpController extends GetxController {
  /// 4 controllers for OTP boxes
  final otpControllers = List.generate(4, (_) => TextEditingController());
  final focusNodes = List.generate(4, (_) => FocusNode());

  final isLoading = false.obs;
  final otp = ''.obs;     // OTP from backend (debug/display)
  final name = ''.obs;    // user name
  final mobile = ''.obs;  // user mobile
  final token = ''.obs;   // API token
  var isNewUser = false;

  @override
  void onInit() {
    super.onInit();

    /// receive data from Register screen
    final args = Get.arguments;
    if (args != null) {
      mobile.value = args['mobile']?.toString() ?? '';
      token.value  = args['token']?.toString() ?? '';
      otp.value    = args['otp']?.toString() ?? '';
      isNewUser    = args['isNewUser'] ?? false;
    }

    /// Auto focus move
    for (int i = 0; i < otpControllers.length; i++) {
      otpControllers[i].addListener(() {
        if (otpControllers[i].text.length == 1 && i < otpControllers.length - 1) {
          focusNodes[i + 1].requestFocus();
        } else if (otpControllers[i].text.isEmpty && i > 0) {
          focusNodes[i - 1].requestFocus();
        }
      });
    }
  }

  /// collect entered OTP
  String get enteredOtp => otpControllers.map((c) => c.text).join();

  /// ✅ Verify OTP API
  Future<void> verifyOtp() async {
    if (enteredOtp.length != 4) {
      Get.snackbar('Invalid OTP', 'Please enter the 4-digit OTP.');
      return;
    }

    isLoading.value = true;
    try {
      final url = Uri.parse("${BaseUrl.baseUrl}verify-otp");
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token.value}",
        },
        body: jsonEncode({
          "mobile": mobile.value,
          "otp": enteredOtp,
        }),
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("data: $data");

        print("name.value, token.value, isNewUser: $name.value, ${token.value}, $isNewUser");
        Get.snackbar('Success', 'OTP verified successfully');

        /// ✅ Save user data in local storage
        final userId = data['data']['_id']?.toString() ?? '';
        final userName = data['data']['name']?.toString() ?? '';
        final userToken = data['data']['token']?.toString() ?? '';

        print("Storing name: $userName, userId: $userId");
              await StorageService().saveUser(
  userName,
  userToken,
  mobile.value,
  userId,
);
        // await StorageService.saveLogin(
        //   userToken,
        //   mobile.value,
        //   userName,
        //   userId,
        // );

        /// ✅ Navigate to Dashboard with name + token
        Get.offAllNamed('/dashboard', arguments: {
          "token": token.value,
          "isNewUser": isNewUser,
        });
      } else {
        Get.snackbar("Error", "Server error: ${response.reasonPhrase}");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  /// ✅ Resend OTP API
  Future<void> resendCode() async {
    try {
      final url = Uri.parse("${BaseUrl.baseUrl}resend-otp");
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token.value}",
        },
        body: jsonEncode({"mobile": mobile.value}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Resend OTP Response: $data");
        print("New OTP: ${data['otp']}");
        otp.value = data['otp']?.toString() ?? '';

        Get.snackbar(
          "OTP Resent",
          "New OTP sent successfully.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.shade600,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar("Error", "Resend failed: ${response.reasonPhrase}");
      }
    } catch (e) {
      Get.snackbar("Error", "Resend failed: $e");
    }
  }

  @override
  void onClose() {
    for (var c in otpControllers) {
      c.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}

