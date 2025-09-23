// import 'package:aesera_jewels/modules/investment_details/investment_controller.dart';
// import 'package:aesera_jewels/services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// class InvestmentDetailScreen extends StatelessWidget {
//   final int initialTabIndex;
//   final InvestmentController controller = Get.put(InvestmentController());

//   InvestmentDetailScreen({super.key, required this.initialTabIndex});

//   @override
//   Widget build(BuildContext context) {
//     controller.changeTab(initialTabIndex);
//     final width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F4FA),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           'Investment Details',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         return RefreshIndicator(
//           onRefresh: controller.refreshData,
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildHeader(),
//                 const SizedBox(height: 16),
//                 _buildTotalCard(width),
//                 const SizedBox(height: 20),
//                 _buildTabBar(),
//                 const SizedBox(height: 16),
//                 _buildSectionTitle(),
//                 const SizedBox(height: 12),
//                 _buildTabContent(),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   /// -------------------- Header (Name + Logout) --------------------
//   Widget _buildHeader() {
//     return Row(
//       children: [
//         Obx(() => Text(
//               controller.userName.value,
//               style: GoogleFonts.lexend(
//                 fontWeight: FontWeight.w800,
//                 fontSize: 26,
//                 color: const Color(0xFF1A0F12),
//               ),
//             )),
//         const Spacer(),
//         ElevatedButton(
//           onPressed: () async {
//             await StorageService().erase();
//             Get.offAllNamed('/login');
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFFFFB700),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(18),
//             ),
//           ),
//           child: Text(
//             "Logout",
//             style: GoogleFonts.lexend(
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   /// -------------------- Total Card --------------------
//   Widget _buildTotalCard(double width) {
//     return Container(
//       width: width,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: const Color(0xFF0A2A4D),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text("Total Investment Amount",
//               style: TextStyle(color: Colors.amber, fontSize: 16)),
//           const SizedBox(height: 4),
//           Obx(() => Text(controller.formattedTotal,
//               style: const TextStyle(
//                   color: Colors.amber,
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold))),
//           const SizedBox(height: 12),
//           const Text("Total Allotment Grams",
//               style: TextStyle(color: Colors.amber, fontSize: 16)),
//           const SizedBox(height: 4),
//           Obx(() => Text(controller.formattedTotalGrams,
//               style: const TextStyle(
//                   color: Colors.amber,
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold))),
//         ],
//       ),
//     );
//   }

//   /// -------------------- Tab Bar --------------------
//   Widget _buildTabBar() {
//     return Container(
//       height: 48,
//       decoration: BoxDecoration(
//         color: const Color(0xFF0A2A4D),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Row(
//         children: [
//           _tabButton("Paid Amount", InvestmentController.TAB_PAID),
//           _tabButton("Received Gold", InvestmentController.TAB_RECEIVED),
//           _tabButton("Purchased", InvestmentController.TAB_PURCHASED),
//         ],
//       ),
//     );
//   }

//   Widget _tabButton(String title, int index) {
//     return Expanded(
//       child: Obx(() {
//         final selected = controller.selectedTab.value == index;
//         return GestureDetector(
//           onTap: () => controller.changeTab(index),
//           child: Container(
//             alignment: Alignment.center,
//             margin: const EdgeInsets.all(3.5),
//             decoration: BoxDecoration(
//               color: selected ? Colors.amber : Colors.transparent,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Text(
//               title,
//               style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: selected ? Colors.black : Colors.white),
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   /// -------------------- Section Title --------------------
//   Widget _buildSectionTitle() {
//     switch (controller.selectedTab.value) {
//       case InvestmentController.TAB_PAID:
//         return const Text("Paid Transactions",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
//       case InvestmentController.TAB_RECEIVED:
//         return const Text("Gold Received",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
//       default:
//         return const Text("Purchased History",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
//     }
//   }

//   /// -------------------- Tab Content --------------------
//   Widget _buildTabContent() {
//     switch (controller.selectedTab.value) {
//       case InvestmentController.TAB_PAID:
//         return _buildPaidList();
//       case InvestmentController.TAB_RECEIVED:
//         return _buildReceivedList();
//       default:
//         return _buildPurchasedList();
//     }
//   }

//   /// -------------------- Reusable aligned row --------------------
//   Widget _alignedRow(String label, String value,
//       {FontWeight labelWeight = FontWeight.bold,
//       FontWeight valueWeight = FontWeight.normal,
//       Color valueColor = Colors.black,
//       double labelWidth = 120}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(
//             width: labelWidth,
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(label, style: TextStyle(fontWeight: labelWeight)),
//             ),
//           ),
//           const SizedBox(
//             width: 20,
//             child: Center(
//               child: Text(":", style: TextStyle(fontWeight: FontWeight.bold)),
//             ),
//           ),
//           Expanded(
//             child: Text(value,
//                 style: TextStyle(
//                     fontWeight: valueWeight, color: valueColor)),
//           ),
//         ],
//       ),
//     );
//   }

//   /// -------------------- Paid List --------------------
//  Widget _buildPaidList() {
//   final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
//   if (controller.paidTransactions.isEmpty) {
//     return _styledContainer(const Center(child: Text("No Data Available")));
//   }

//   return Column(
//     children: controller.paidTransactions.map((p) {
//       // Format date and time
//       final dateTimeString = p.timestamp != null
//           ? DateFormat('dd-MMM-yyyy, hh:mm a').format(p.timestamp!)
//           : "N/A";

//       // Determine color based on status
//       Color statusColor;
//       if (p.status.toLowerCase().contains("pending")) {
//         statusColor = Colors.red;
//       } else if (p.status.toLowerCase().contains("approved") ||
//                  p.status.toLowerCase().contains("confirm")) {
//         statusColor = Colors.green;
//       } else {
//         statusColor = Colors.black; // fallback
//       }

//       return _cardContainer([
//         _alignedRow("Ins No", "${controller.paidTransactions.indexOf(p) + 1}"),
//         _alignedRow("Date & Time", dateTimeString),
//         _alignedRow("Amount", format.format(p.amount)),
//         _alignedRow(
//             "Grams",
//             (p.gramAllocated > 0 ? p.gramAllocated : p.gram)
//                 .toStringAsFixed(3)),
//         _alignedRow(
//           "Payment Status",
//           p.status,
//           valueWeight: FontWeight.w600,
//           valueColor: statusColor,
//         ),
//       ]);
//     }).toList(),
//   );
// }



//   /// -------------------- Received List --------------------
//  Widget _buildReceivedList() {
//   if (controller.allotments.isEmpty) {
//     return _styledContainer(const Center(child: Text("No Data Available")));
//   }

//   return Column(
//     children: controller.allotments.map((r) {
//       // Format date and time
//       final dateTimeString = r.timestamp != null
//           ? DateFormat('dd-MMM-yyyy, hh:mm a').format(r.timestamp!)
//           : "N/A";

//       return _cardContainer([
//         _alignedRow("Ins No", "${controller.allotments.indexOf(r) + 1}"),
//         _alignedRow("Date & Time", dateTimeString),
//         _alignedRow("Gold", "${r.gram.toStringAsFixed(3)}"),
//       ]);
//     }).toList(),
//   );
// }


//   /// -------------------- Purchased List --------------------
// // Widget _buildPurchasedList() {
// //   final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
// //   if (controller.purchasedHistory.isEmpty) {
// //     return _styledContainer(const Center(child: Text("No Data Available")));
// //   }

// //   return Column(
// //     children: controller.purchasedHistory.map((p) {
// //       // Format date and time
// //       final dateTimeString = p.createdAt != null
// //           ? DateFormat('dd-MMM-yyyy,hh:mm a').format(p.createdAt!)
// //           : "N/A";

// //       return _cardContainer([
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Text("TagID ${p.tagid}",
// //                 style: const TextStyle(
// //                     fontSize: 16, fontWeight: FontWeight.bold)),
// //             Text(dateTimeString,
// //                 style: const TextStyle(
// //                     fontSize: 14, color: Color.fromARGB(255, 81, 81, 81))),
// //           ],
// //         ),
// //         _alignedRow("Address", p.address),
// //         _alignedRow("City", p.city),
// //         _alignedRow("Post Code", p.postCode),
// //         _alignedRow("Price", format.format(p.amount)),
// //         _alignedRow("Weight (gms)", "${p.grams}"),
// //         _alignedRow("Gold Type", p.goldType),
// //         _alignedRow("Description", p.description),
// //         Row(
// //           children: [
// //             const Text("Paid Amount ",
// //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
// //             const SizedBox(width: 40),
// //             Container(
// //               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
// //               decoration: BoxDecoration(
// //                 color: Colors.grey.shade200,
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //               child: Text(
// //                 format.format(p.paidAmount),
// //                 style: const TextStyle(
// //                     fontWeight: FontWeight.bold, fontSize: 15),
// //               ),
// //             ),
// //           ],
// //         ),
// //         _alignedRow("Payment Status", p.paymentStatus,
// //             valueWeight: FontWeight.w600,
// //             valueColor: p.paymentStatus.toLowerCase() == "paid"
// //                 ? Colors.green
// //                 : Colors.red),
// //         _alignedRow("Delivered Status", p.allotmentStatus,
// //             valueWeight: FontWeight.w600,
// //             valueColor: p.allotmentStatus.toLowerCase() == "delivered"
// //                 ? Colors.green
// //                 : Colors.red),
// //       ]);
// //     }).toList(),
// //   );
// // }
// Widget _buildPurchasedList() {
//   final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
//   if (controller.purchasedHistory.isEmpty) {
//     return _styledContainer(const Center(child: Text("No Data Available")));
//   }

//   return Column(
//     children: controller.purchasedHistory.map((p) {
//       // Format date and time
//       final dateTimeString = p.createdAt != null
//           ? DateFormat('dd-MMM-yyyy, hh:mm a').format(p.createdAt!)
//           : "N/A";

//       // Payment Status color
//       Color paymentColor;
//       final paymentStatus = p.paymentStatus.toLowerCase();
//       if (paymentStatus.contains("pending")) {
//         paymentColor = Colors.red;
//       } else if (paymentStatus.contains("approved")) {
//         paymentColor = Colors.blue; // approved but not delivered yet
//       } else {
//         paymentColor = Colors.black;
//       }

//       // Delivery Status color
//       Color deliveryColor;
//       final deliveryStatus = p.allotmentStatus.toLowerCase();
//       if (deliveryStatus.contains("not delivered")) {
//         deliveryColor = Colors.red;
//       } else if (deliveryStatus.contains("in progress")) {
//         deliveryColor = Colors.blue;
//       } else if (deliveryStatus.contains("delivered") &&
//           paymentStatus.contains("approved")) {
//         deliveryColor = Colors.green;
//       } else {
//         deliveryColor = Colors.black;
//       }

//       return _cardContainer([
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("TagID ${p.tagid}",
//                 style: const TextStyle(
//                     fontSize: 16, fontWeight: FontWeight.bold)),
//             Text(dateTimeString,
//                 style: const TextStyle(
//                     fontSize: 14, color: Color.fromARGB(255, 81, 81, 81))),
//           ],
//         ),
//         _alignedRow("Address", p.address),
//         _alignedRow("City", p.city),
//         _alignedRow("Post Code", p.postCode),
//         _alignedRow("Price", format.format(p.amount)),
//         _alignedRow("Weight (gms)", "${p.grams}"),
//         _alignedRow("Gold Type", p.goldType),
//         _alignedRow("Description", p.description),
//         Row(
//           children: [
//             const Text("Paid Amount ",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//             const SizedBox(width: 40),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 format.format(p.paidAmount),
//                 style: const TextStyle(
//                     fontWeight: FontWeight.bold, fontSize: 15),
//               ),
//             ),
//           ],
//         ),
//         _alignedRow("Payment Status", p.paymentStatus,
//             valueWeight: FontWeight.w600, valueColor: paymentColor),
//         _alignedRow("Delivered Status", p.allotmentStatus,
//             valueWeight: FontWeight.w600, valueColor: deliveryColor),
//       ]);
//     }).toList(),
//   );
// }




//   /// -------------------- Helpers --------------------
//   Widget _cardContainer(List<Widget> children) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10.0),
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: children,
//         ),
//       ),
//     );
//   }

//   Widget _styledContainer(Widget child) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: const Color(0xFF0A2A4D),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: child,
//     );
//   }
// }
import 'package:aesera_jewels/modules/address/address_controller.dart';
import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
import 'package:aesera_jewels/modules/investment_details/investment_controller.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:aesera_jewels/modules/address/address_screen.dart'; // 👈 added import
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class InvestmentDetailScreen extends StatelessWidget {
  final int initialTabIndex;
  final InvestmentController controller = Get.put(InvestmentController());

  InvestmentDetailScreen({super.key, required this.initialTabIndex});

  @override
  Widget build(BuildContext context) {
    controller.changeTab(initialTabIndex);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Investment Details',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.to(()=>DashboardScreen()),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildTotalCard(width),
                const SizedBox(height: 20),

                /// 👇 Update Address Button added here
                _buildUpdateAddressButton(context),
                const SizedBox(height: 20),

                _buildTabBar(),
                const SizedBox(height: 16),
                _buildSectionTitle(),
                const SizedBox(height: 12),
                _buildTabContent(),
              ],
            ),
          ),
        );
      }),
    );
  }

  /// -------------------- Header (Name + Logout) --------------------
  Widget _buildHeader() {
    return Row(
      children: [
        Obx(() => Text(
              controller.userName.value,
              style: GoogleFonts.lexend(
                fontWeight: FontWeight.w800,
                fontSize: 26,
                color: const Color(0xFF1A0F12),
              ),
            )),
        const Spacer(),
        ElevatedButton(
          onPressed: () async {
            await StorageService().erase();
            Get.offAllNamed('/login');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFB700),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Text(
            "Logout",
            style: GoogleFonts.lexend(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

 

  /// -------------------- Total Card --------------------
  Widget _buildTotalCard(double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0A2A4D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Total Investment Amount",
              style: TextStyle(color: Colors.amber, fontSize: 16)),
          const SizedBox(height: 4),
          Obx(() => Text(controller.formattedTotal,
              style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 22,
                  fontWeight: FontWeight.bold))),
          const SizedBox(height: 12),
          const Text("Total Allotment Grams",
              style: TextStyle(color: Colors.amber, fontSize: 16)),
          const SizedBox(height: 4),
          Obx(() => Text(controller.formattedTotalGrams,
              style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 22,
                  fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

/// -------------------- Update Address Button --------------------
Widget _buildUpdateAddressButton(BuildContext context) {
  return Container(
    height: 48,
    margin: const EdgeInsets.all(3.5),
    decoration: BoxDecoration(
      color: const Color(0xFF0A2A4D),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Center(
      child: SizedBox(
        width: 300,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60),
            ),
          ),
          onPressed: () {
            Get.to(() => AddressScreen())?.then((_) {
              // refresh addresses when coming back
              final controller = Get.find<AddressController>();
              controller.fetchAddresses();
            });
          },
          child: const Text(
            "Update Address",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}

  /// -------------------- Tab Bar --------------------
  Widget _buildTabBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF0A2A4D),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _tabButton("Paid Amount", InvestmentController.TAB_PAID),
          _tabButton("Received Gold", InvestmentController.TAB_RECEIVED),
          _tabButton("Purchased", InvestmentController.TAB_PURCHASED),
        ],
      ),
    );
  }

  Widget _tabButton(String title, int index) {
    return Expanded(
      child: Obx(() {
        final selected = controller.selectedTab.value == index;
        return GestureDetector(
          onTap: () => controller.changeTab(index),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(3.5),
            decoration: BoxDecoration(
              color: selected ? Colors.amber : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.black : Colors.white),
            ),
          ),
        );
      }),
    );
  }

  /// -------------------- Section Title --------------------
  Widget _buildSectionTitle() {
    switch (controller.selectedTab.value) {
      case InvestmentController.TAB_PAID:
        return const Text("Paid Transactions",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
      case InvestmentController.TAB_RECEIVED:
        return const Text("Gold Received",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
      default:
        return const Text("Purchased History",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
    }
  }

  /// -------------------- Tab Content --------------------
  Widget _buildTabContent() {
    switch (controller.selectedTab.value) {
      case InvestmentController.TAB_PAID:
        return _buildPaidList();
      case InvestmentController.TAB_RECEIVED:
        return _buildReceivedList();
      default:
        return _buildPurchasedList();
    }
  }

  /// -------------------- Reusable aligned row --------------------
  Widget _alignedRow(String label, String value,
      {FontWeight labelWeight = FontWeight.bold,
      FontWeight valueWeight = FontWeight.normal,
      Color valueColor = Colors.black,
      double labelWidth = 120}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: labelWidth,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(label, style: TextStyle(fontWeight: labelWeight)),
            ),
          ),
          const SizedBox(
            width: 20,
            child: Center(
              child: Text(":", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(
                    fontWeight: valueWeight, color: valueColor)),
          ),
        ],
      ),
    );
  }

  /// -------------------- Paid List --------------------
  Widget _buildPaidList() {
    final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    if (controller.paidTransactions.isEmpty) {
      return _styledContainer(const Center(child: Text("No Data Available")));
    }

    return Column(
      children: controller.paidTransactions.map((p) {
        final dateTimeString = p.timestamp != null
            ? DateFormat('dd-MMM-yyyy, hh:mm a').format(p.timestamp!)
            : "N/A";

        Color statusColor;
        if (p.status.toLowerCase().contains("pending")) {
          statusColor = Colors.red;
        } else if (p.status.toLowerCase().contains("approved") ||
            p.status.toLowerCase().contains("confirm")) {
          statusColor = Colors.green;
        } else {
          statusColor = Colors.black;
        }

        return _cardContainer([
          _alignedRow("Ins No", "${controller.paidTransactions.indexOf(p) + 1}"),
          _alignedRow("Date & Time", dateTimeString),
          _alignedRow("Amount", format.format(p.amount)),
          _alignedRow("Grams",
              (p.gramAllocated > 0 ? p.gramAllocated : p.gram).toStringAsFixed(3)),
          _alignedRow("Payment Status", p.status,
              valueWeight: FontWeight.w600, valueColor: statusColor),
        ]);
      }).toList(),
    );
  }

  /// -------------------- Received List --------------------
  Widget _buildReceivedList() {
    if (controller.allotments.isEmpty) {
      return _styledContainer(const Center(child: Text("No Data Available")));
    }

    return Column(
      children: controller.allotments.map((r) {
        final dateTimeString = r.timestamp != null
            ? DateFormat('dd-MMM-yyyy, hh:mm a').format(r.timestamp!)
            : "N/A";

        return _cardContainer([
          _alignedRow("Ins No", "${controller.allotments.indexOf(r) + 1}"),
          _alignedRow("Date & Time", dateTimeString),
          _alignedRow("Gold", "${r.gram.toStringAsFixed(3)}"),
        ]);
      }).toList(),
    );
  }

  /// -------------------- Purchased List --------------------
  Widget _buildPurchasedList() {
    final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    if (controller.purchasedHistory.isEmpty) {
      return _styledContainer(const Center(child: Text("No Data Available")));
    }

    return Column(
      children: controller.purchasedHistory.map((p) {
        final dateTimeString = p.createdAt != null
            ? DateFormat('dd-MMM-yyyy, hh:mm a').format(p.createdAt!)
            : "N/A";

        Color paymentColor;
        final paymentStatus = p.paymentStatus.toLowerCase();
        if (paymentStatus.contains("pending")) {
          paymentColor = Colors.red;
        } else if (paymentStatus.contains("approved")) {
          paymentColor = Colors.blue;
        } else {
          paymentColor = Colors.black;
        }

        Color deliveryColor;
        final deliveryStatus = p.allotmentStatus.toLowerCase();
        if (deliveryStatus.contains("not delivered")) {
          deliveryColor = Colors.red;
        } else if (deliveryStatus.contains("in progress")) {
          deliveryColor = Colors.blue;
        } else if (deliveryStatus.contains("delivered") &&
            paymentStatus.contains("approved")) {
          deliveryColor = Colors.green;
        } else {
          deliveryColor = Colors.black;
        }

        return _cardContainer([
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("TagID ${p.tagid}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              Text(dateTimeString,
                  style: const TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 81, 81, 81))),
            ],
          ),
          _alignedRow("Address", p.address),
          _alignedRow("City", p.city),
          _alignedRow("Post Code", p.postCode),
          _alignedRow("Price", format.format(p.amount)),
          _alignedRow("Weight (gms)", "${p.grams}"),
          _alignedRow("Gold Type", p.goldType),
          _alignedRow("Description", p.description),
          Row(
            children: [
              const Text("Paid Amount ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(width: 40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  format.format(p.paidAmount),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ],
          ),
          _alignedRow("Payment Status", p.paymentStatus,
              valueWeight: FontWeight.w600, valueColor: paymentColor),
          _alignedRow("Delivered Status", p.allotmentStatus,
              valueWeight: FontWeight.w600, valueColor: deliveryColor),
        ]);
      }).toList(),
    );
  }

  /// -------------------- Helpers --------------------
  Widget _cardContainer(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _styledContainer(Widget child) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0A2A4D),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
