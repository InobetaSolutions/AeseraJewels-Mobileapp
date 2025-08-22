// import 'dart:io';

// import 'package:aesera_jewels/modules/payment_selection/payment_selection_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PaymentScreen extends StatelessWidget {
//   final PaymentController controller = Get.put(PaymentController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment'),
//         bottom: TabBar(
//           controller: controller.tabController,
//           tabs: [
//             Tab(text: 'Own Number'),
//             Tab(text: 'Others Number'),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: TabBarView(
//                 controller: controller.tabController,
//                 children: [
//                   _buildPaymentForm(), // Own Number Form
//                   _buildPaymentForm(), // Others Number Form
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => controller.submitPayment(),
//               child: Text('Payment Completed'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPaymentForm() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Payment Mobile Number', style: TextStyle(fontSize: 16)),
//         TextField(
//           onChanged: (value) => controller.mobileNumber.value = value,
//           decoration: InputDecoration(hintText: 'Enter Payment Mobile Number'),
//         ),
//         SizedBox(height: 20),

//         Text('Amount Paid', style: TextStyle(fontSize: 16)),
//         TextField(
//           onChanged: (value) => controller.amountPaid.value = value,
//           decoration: InputDecoration(hintText: 'Enter Paid Amount'),
//           keyboardType: TextInputType.number,
//         ),
//         SizedBox(height: 20),

//         Text('Upload Screenshot (Optional)', style: TextStyle(fontSize: 16)),
//         ElevatedButton(
//           onPressed: controller.pickScreenshot,
//           child: Text('Upload'),
//         ),
//         SizedBox(height: 20),

//         Obx(() {
//           if (controller.screenshot != null) {
//             return Image.file(File(controller.screenshot!.path), height: 200, width: 200);
//           }
//           return SizedBox.shrink();
//         }),
//       ],
//     );
//   }
// }
import 'package:aesera_jewels/modules/payment_selection/payment_selection_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PaymentScreen extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('Payment')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Payment Mobile Number Input Field
            Text(
              'Payment Mobile Number',
              style: TextStyle(
                fontSize: width * 0.05,
              ), // Adjust font size based on screen width
            ),
            TextField(
              onChanged: (value) => controller.mobileNumber.value = value,
              decoration: InputDecoration(
                hintText: 'Enter Payment Mobile Number',
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: height * 0.02,
            ), // Adjust spacing based on screen height
            // Amount Paid Input Field
            Text(
              'Amount Paid',
              style: TextStyle(
                fontSize: width * 0.05,
              ), // Adjust font size based on screen width
            ),
            TextField(
              onChanged: (value) => controller.amountPaid.value = value,
              decoration: InputDecoration(hintText: 'Enter Paid Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: height * 0.02,
            ), // Adjust spacing based on screen height
            // Upload Screenshot Section
            Text(
              'Upload Screenshot (Optional)',
              style: TextStyle(
                fontSize: width * 0.05,
              ), // Adjust font size based on screen width
            ),
            ElevatedButton(
              onPressed: controller.pickScreenshot,
              child: Text('Upload'),
            ),
            SizedBox(
              height: height * 0.02,
            ), // Adjust spacing based on screen height
            // Display Image if Screenshot is Picked
            Obx(() {
              if (controller.screenshot.value != null) {
                return Image.file(
                  File(controller.screenshot.value!.path),
                  height:
                      width *
                      0.4, // Make image height responsive to screen width
                  width:
                      width *
                      0.4, // Make image width responsive to screen width
                  fit: BoxFit.cover,
                );
              }
              return SizedBox.shrink();
            }),

            SizedBox(
              height: height * 0.05,
            ), // Adjust spacing based on screen height
            // Payment Completed Button
            ElevatedButton(
              onPressed: controller.submitPayment,
              child: Text('Payment Completed'),
            ),
          ],
        ),
      ),
    );
  }
}
