// import 'package:aesera_jewels/models/catalog_model.dart';
// import 'package:aesera_jewels/modules/investment_details/investment_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:aesera_jewels/services/storage_service.dart';

// class InvestmentDetailScreen extends StatelessWidget {
//   final InvestmentController controller = Get.put(InvestmentController());
//   final int initialTabIndex;

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
//             fontSize: 25,
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
//           onRefresh: () async {
//             await controller.refreshData();
//           },
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildHeader(),
//                 const SizedBox(height: 16),
//                 _buildTotalCard(width),
//                 const SizedBox(height: 24),
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

//   /// Header with username and logout button
//   Widget _buildHeader() {
//     return Row(
//       children: [
//         Obx(
//           () => Text(
//             controller.userName.value,
//             style: GoogleFonts.lexend(
//               fontWeight: FontWeight.w800,
//               fontSize: 28,
//               color: const Color(0xFF1A0F12),
//             ),
//           ),
//         ),
//         const Spacer(),
//         ElevatedButton(
//           onPressed: () async {
//             await StorageService().erase();
//             Get.offNamed('/login');
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
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   /// Total investment card
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
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold))),
//           const SizedBox(height: 7),
//           const Text("Total Allotment Grams",
//               style: TextStyle(color: Colors.amber, fontSize: 16)),
//           const SizedBox(height: 6),
//           Obx(() => Text(controller.formattedTotalGrams,
//               style: const TextStyle(
//                   color: Colors.amber,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold))),
//         ],
//       ),
//     );
//   }

//   /// TabBar for Paid, Received, Purchased
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
//           child: Padding(
//             padding: const EdgeInsets.all(3.5),
//             child: Container(
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: selected ? Colors.amber : Colors.transparent,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: selected ? Colors.black : Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   Widget _buildSectionTitle() {
//     switch (controller.selectedTab.value) {
//       case InvestmentController.TAB_PAID:
//         return const Text("Paid Transactions",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
//       case InvestmentController.TAB_RECEIVED:
//         return const Text("Gold Received",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
//       default:
//         return const Text("Purchased History",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
//     }
//   }

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

//   /// --- Paid Transactions List ---
//   Widget _buildPaidList() {
//     final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
//     if (controller.paidTransactions.isEmpty) {
//       return _styledContainer(const Center(child: Text("No Data Available")));
//     }

//     const double labelWidth = 120;

//     Widget buildRow(String label, String value) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 2),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: labelWidth,
//               child: Text(
//                 "$label :",
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//             Expanded(
//               child: Text(
//                 value,
//                 style: const TextStyle(fontWeight: FontWeight.normal),
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return Column(
//       children: controller.paidTransactions.map((p) {
//         final dateString = p.timestamp != null
//             ? DateFormat('dd-MMM-yyyy h:mm a').format(p.timestamp!)
//             : "N/A";
//         return _cardContainer([
//           buildRow("Ins No", "${controller.paidTransactions.indexOf(p) + 1}"),
//           buildRow("Date and Time", dateString),
//           buildRow("Amount", format.format(p.amount)),
//           buildRow(
//               "Grams",
//               (p.gramAllocated > 0 ? p.gramAllocated : p.gram)
//                   .toStringAsFixed(3)),
//           buildRow("Admin Status", p.status ),
//         ]);
//       }).toList(),
//     );
//   }

//   /// --- Received Gold List ---
//   Widget _buildReceivedList() {
//     if (controller.allotments.isEmpty) {
//       return _styledContainer(const Center(child: Text("No Data Available")));
//     }

//     const double labelWidth = 120;

//     Widget buildRow(String label, String value) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 2),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: labelWidth,
//               child: Text(
//                 "$label :",
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//             Expanded(
//               child: Text(
//                 value,
//                 style: const TextStyle(fontWeight: FontWeight.normal),
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return Column(
//       children: controller.allotments.map((r) {
//         final dateString = r.timestamp != null
//             ? DateFormat('dd-MMM-yyyy h:mm a').format(r.timestamp)
//             : "N/A";
//         return _cardContainer([
//           buildRow("Ins No", "${controller.allotments.indexOf(r) + 1}"),
//           buildRow("Date and Time", dateString),
//           buildRow("Gold", "${r.gram.toStringAsFixed(3)} g"),
//         ]);
//       }).toList(),
//     );
//   }

//   /// --- Purchased History List ---
//   Widget _buildPurchasedList() {
//     final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

//     if (controller.purchasedHistory.isEmpty) {
//       return _styledContainer(const Center(child: Text("No Data Available")));
//     }

//     const double labelWidth = 120;

//     Widget buildRow(String label, String value,
//         {FontWeight labelWeight = FontWeight.bold,
//         FontWeight valueWeight = FontWeight.normal,
//         Color valueColor = Colors.black}) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 2),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: labelWidth,
//               child: Text(
//                 "$label :",
//                 style: TextStyle(fontWeight: labelWeight),
//               ),
//             ),
//             Expanded(
//               child: Text(
//                 value,
//                 style: TextStyle(fontWeight: valueWeight, color: valueColor),
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return Column(
//       children: controller.purchasedHistory.map((p) {
//         final dateString = DateFormat('dd-MMM-yyyy').format(p.createdAt);
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 10),
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 5,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// Top Row → Tag ID & Date
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     RichText(
//                       text: TextSpan(
//                         children: [
//                           const TextSpan(
//                             text: "Tag ID",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.black),
//                           ),
//                           TextSpan(
//                             text: " # ${p.tagid}",
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.normal,
//                                 fontSize: 16,
//                                 color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Text(
//                       dateString,
//                       style: const TextStyle(
//                           color: Color.fromARGB(255, 131, 130, 130),
//                           fontSize: 14),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 6),

//                 /// Detail Rows
//                 buildRow("Address", p.address),
//                 buildRow("City", p.city),
//                 buildRow("Post Code", p.postCode),
//                 buildRow("Price", format.format(p.amount)),
//                 buildRow("Weight (gms)", "${p.grams}"),
//                 buildRow("Gold Type", p.goldType),
//                 buildRow("Description", p.description),

//                 /// Paid Amount row
//                 Row(
//                   children: [
//                     const Text(
//                       "Paid Amount:",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 15),
//                     ),
                    
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 20.0),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade200,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           " ${format.format(p.paidAmount)}",
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//                 buildRow(
//                   "Status",
//                   p.allotmentStatus,
//                   valueColor: p.allotmentStatus.toLowerCase() == 'delivered'
//                       ? Colors.green
//                       : Colors.pink,
//                   valueWeight: FontWeight.w600,
//                 ),
              
//               ],
//           ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   /// Common card container
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

//   /// Styled container for empty states
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
import 'package:aesera_jewels/models/catalog_model.dart';
import 'package:aesera_jewels/modules/investment_details/investment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aesera_jewels/services/storage_service.dart';

class InvestmentDetailScreen extends StatelessWidget {
  final InvestmentController controller = Get.put(InvestmentController());
  final int initialTabIndex;

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
            fontSize: 25,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () async {
            await controller.refreshData();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildTotalCard(width),
                const SizedBox(height: 24),
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

  /// Header with username and logout
  Widget _buildHeader() {
    return Row(
      children: [
        Obx(
          () => Text(
            controller.userName.value,
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.w800,
              fontSize: 28,
              color: const Color(0xFF1A0F12),
            ),
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () async {
            await StorageService().erase();
            Get.offNamed('/login');
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
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  /// Total card
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
                  fontSize: 25,
                  fontWeight: FontWeight.bold))),
          const SizedBox(height: 7),
          const Text("Total Allotment Grams",
              style: TextStyle(color: Colors.amber, fontSize: 16)),
          const SizedBox(height: 6),
          Obx(() => Text(controller.formattedTotalGrams,
              style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 25,
                  fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  /// TabBar
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
          child: Padding(
            padding: const EdgeInsets.all(3.5),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? Colors.amber : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSectionTitle() {
    switch (controller.selectedTab.value) {
      case InvestmentController.TAB_PAID:
        return const Text("Paid Transactions",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
      case InvestmentController.TAB_RECEIVED:
        return const Text("Gold Received",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
      default:
        return const Text("Purchased History",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
    }
  }

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

  /// Paid List
  Widget _buildPaidList() {
    final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    if (controller.paidTransactions.isEmpty) {
      return _styledContainer(const Center(child: Text("No Data Available")));
    }

    const double labelWidth = 120;

    Widget buildRow(String label, String value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: labelWidth,
              child: Text("$label :",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(child: Text(value)),
          ],
        ),
      );
    }

    return Column(
      children: controller.paidTransactions.map((p) {
        return _cardContainer([
          buildRow("Ins No", "${controller.paidTransactions.indexOf(p) + 1}"),
          buildRow("Date & Time", controller.formatDate(p.timestamp)),
          buildRow("Amount", format.format(p.amount)),
          buildRow("Grams",
              (p.gramAllocated > 0 ? p.gramAllocated : p.gram).toStringAsFixed(3)),
          buildRow("Admin Status", p.status),
        ]);
      }).toList(),
    );
  }

  /// Received List
  Widget _buildReceivedList() {
    if (controller.allotments.isEmpty) {
      return _styledContainer(const Center(child: Text("No Data Available")));
    }

    const double labelWidth = 120;

    Widget buildRow(String label, String value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: labelWidth,
              child: Text("$label :",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(child: Text(value)),
          ],
        ),
      );
    }

    return Column(
      children: controller.allotments.map((r) {
        return _cardContainer([
          buildRow("Ins No", "${controller.allotments.indexOf(r) + 1}"),
          buildRow("Date & Time", controller.formatDate(r.timestamp)),
          buildRow("Gold", "${r.gram.toStringAsFixed(3)} g"),
        ]);
      }).toList(),
    );
  }

  /// Purchased List
  Widget _buildPurchasedList() {
    final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

    if (controller.purchasedHistory.isEmpty) {
      return _styledContainer(const Center(child: Text("No Data Available")));
    }

    const double labelWidth = 120;

    Widget buildRow(String label, String value,
        {FontWeight labelWeight = FontWeight.bold,
        FontWeight valueWeight = FontWeight.normal,
        Color valueColor = Colors.black}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: labelWidth,
              child: Text("$label :",
                  style: TextStyle(fontWeight: labelWeight)),
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

    return Column(
      children: controller.purchasedHistory.map((p) {
        final dateString = DateFormat('dd-MMM-yyyy').format(p.createdAt);
        return _cardContainer([
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tag ID #${p.tagid}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              Text(dateString,
                  style: const TextStyle(
                      fontSize: 14, color: Colors.grey)),
            ],
          ),
          buildRow("Address", p.address),
          buildRow("City", p.city),
          buildRow("Post Code", p.postCode),
          buildRow("Price", format.format(p.amount)),
          buildRow("Weight (gms)", "${p.grams}"),
          buildRow("Gold Type", p.goldType),
          buildRow("Description", p.description),
          Row(
            children: [
              const Text("Paid Amount:",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
          buildRow("Status", p.allotmentStatus,
              valueWeight: FontWeight.w600,
              valueColor: p.allotmentStatus.toLowerCase() == "delivered"
                  ? Colors.green
                  : Colors.pink),
        ]);
      }).toList(),
    );
  }

  /// Common card
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
