
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../login/login_view.dart';
// import 'portfolio_controller.dart';

// class InvestmentScreen extends StatelessWidget {
//   final int initialTabIndex;
//   final InvestmentController controller = Get.put(InvestmentController());

//   InvestmentScreen({Key? key, this.initialTabIndex = 0}) : super(key: key);

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
//           style: TextStyle(color: Colors.black),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       body: Scrollbar(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Obx(() {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildHeader(),
//                 const SizedBox(height: 16),
//                 _buildTotalInvestmentCard(width),
//                 const SizedBox(height: 24),
//                 _buildTabBar(),
//                 const SizedBox(height: 16),
//                 _buildSectionTitle(),
//                 const SizedBox(height: 8),
//                 if (controller.selectedTab.value == InvestmentController.TAB_PAID)
//                   _buildHeaderRow(["Ins No.", "SubIns", "Date", "Amount"])
//                 else if (controller.selectedTab.value ==
//                     InvestmentController.TAB_RECEIVED)
//                   _buildHeaderRow(["Ins No.", "SubIns", "Date", "Grams"]),
//                 const SizedBox(height: 8),
//                 _buildTabContent(),
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }

//   /// HEADER WITH LOGOUT BUTTON
//   Widget _buildHeader() {
//     return Row(
//       children: [
//         const Text("Rama Krishnan",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//         const Spacer(),
//         ElevatedButton(
//           onPressed: () => Get.offAll(() => LoginView()),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.amber,
//             shape: const StadiumBorder(),
//             elevation: 0,
//           ),
//           child: const Text('Logout', style: TextStyle(color: Colors.black)),
//         ),
//       ],
//     );
//   }

//   /// TOTAL INVESTMENT CARD
//   Widget _buildTotalInvestmentCard(double width) {
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
//           const SizedBox(height: 6),
//           Text(
//             controller.formattedTotalInvestment,
//             style: const TextStyle(
//                 color: Colors.amber, fontSize: 26, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }

//   /// TABS
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
//     final isSelected = controller.selectedTab.value == index;
//     return Expanded(
//       child: GestureDetector(
//         onTap: () => controller.changeTab(index),
//         child: Container(
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.amber : Colors.transparent,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Text(
//             title,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: isSelected ? Colors.black : Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// SECTION TITLE
//   Widget _buildSectionTitle() {
//     switch (controller.selectedTab.value) {
//       case InvestmentController.TAB_PAID:
//         return const Text("Paid Transactions",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
//       case InvestmentController.TAB_RECEIVED:
//         return const Text("Gold Received",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
//       case InvestmentController.TAB_PURCHASED:
//       default:
//         return const Text("Purchased History",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
//     }
//   }

//   /// HEADER ROW FOR TABLES
//   Widget _buildHeaderRow(List<String> titles) {
//     return Row(
//       children: titles.map((t) {
//         return Expanded(
//           child: Text(
//             t,
//             style: const TextStyle(fontWeight: FontWeight.bold),
//             textAlign:
//                 t == "Amount" || t == "Grams" ? TextAlign.right : TextAlign.left,
//           ),
//         );
//       }).toList(),
//     );
//   }

//   /// TAB CONTENT SWITCH
//   Widget _buildTabContent() {
//     switch (controller.selectedTab.value) {
//       case InvestmentController.TAB_PAID:
//         return _buildPaidList();
//       case InvestmentController.TAB_RECEIVED:
//         return _buildReceivedList();
//       case InvestmentController.TAB_PURCHASED:
//       default:
//         return _buildPurchasedList();
//     }
//   }

//   /// PAID LIST
//   Widget _buildPaidList() {
//     final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
//     return _styledContainer(
//       ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: controller.paidTransactions.length,
//         itemBuilder: (context, index) {
//           final tx = controller.paidTransactions[index];
//           return _transactionRow(
//             tx["insNo"].toString(),
//             tx["subIns"].toString(),
//             tx["date"].toString(),
//             format.format(tx["amount"]),
//           );
//         },
//       ),
//     );
//   }

//   /// RECEIVED LIST
//   Widget _buildReceivedList() {
//     return _styledContainer(
//       ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: controller.receivedTransactions.length,
//         itemBuilder: (context, index) {
//           final rx = controller.receivedTransactions[index];
//           return _transactionRow(
//             rx["insNo"].toString(),
//             rx["subIns"].toString(),
//             rx["date"].toString(),
//             "${rx["grams"]} g",
//           );
//         },
//       ),
//     );
//   }

//   /// PURCHASED LIST
//   Widget _buildPurchasedList() {
//     final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: controller.purchasedHistory.length,
//       itemBuilder: (context, index) {
//         final p = controller.purchasedHistory[index];
//         return Container(
//           margin: const EdgeInsets.symmetric(vertical: 8),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: const Color.fromARGB(255, 232, 240, 242),
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 6,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text("${p['tag']}",
//                       style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF0A2A4D))),
//                   const Spacer(),
//                   Text("${p['date']}",
//                       style: const TextStyle(color: Colors.grey)),
//                 ],
//               ),
//               const SizedBox(height: 4),
//               Text("${p['address']}"),
//               const SizedBox(height: 8),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
//                   decoration: BoxDecoration(
//                       color: const Color(0xFFCADBEA),
//                       borderRadius: BorderRadius.circular(20)),
//                   child: Text(format.format(p['amount']),
//                       style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF0A2A4D))),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   /// COMMON STYLED CONTAINER FOR LISTS
//   Widget _styledContainer(Widget child) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFF0A2A4D),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: child,
//     );
//   }

//   /// COMMON ROW WIDGET FOR TRANSACTIONS
//   Widget _transactionRow(
//       String insNo, String subIns, String date, String value) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//       padding: const EdgeInsets.all(12),
//       decoration:
//           BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
//       child: Row(
//         children: [
//           Expanded(child: Text(insNo)),
//           Expanded(child: Text(subIns)),
//           Expanded(child: Text(date)),
//           Expanded(
//             child: Text(value,
//                 textAlign: TextAlign.right,
//                 style: const TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           const SizedBox(width: 8),
//           const Icon(Icons.drag_handle, color: Colors.amber),
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:aesera_jewels/modules/investment_details/portfolio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class InvestmentScreen extends StatelessWidget {
  final InvestmentController controller = Get.put(InvestmentController());

  InvestmentScreen({super.key, required int initialTabIndex});

  @override
  Widget build(BuildContext context) {
    controller.changeTab(InvestmentController.TAB_PAID);

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Investment Details', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildTotalInvestmentCard(width),
                const SizedBox(height: 24),
                _buildTabBar(),
                const SizedBox(height: 16),
                _buildSectionTitle(),
                const SizedBox(height: 8),
                if (controller.selectedTab.value == InvestmentController.TAB_PAID)
                  _buildHeaderRow(["Ins No.", "SubIns", "Date", "Amount"])
                else if (controller.selectedTab.value == InvestmentController.TAB_RECEIVED)
                  _buildHeaderRow(["Ins No.", "SubIns", "Date", "Grams"]),
                const SizedBox(height: 8),
                _buildTabContent(),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Text("Rama Krishnan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const Spacer(),
        ElevatedButton(
          onPressed: () => Get.back(), // Replace with logout logic
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            shape: const StadiumBorder(),
            elevation: 0,
          ),
          child: const Text('Logout', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }

  Widget _buildTotalInvestmentCard(double width) {
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
          const Text("Total Investment Amount", style: TextStyle(color: Colors.amber, fontSize: 16)),
          const SizedBox(height: 6),
          Obx(() => Text(
                controller.formattedTotalInvestment,
                style: const TextStyle(
                    color: Colors.amber, fontSize: 26, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }

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
        final isSelected = controller.selectedTab.value == index;
        return GestureDetector(
          onTap: () => controller.changeTab(index),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? Colors.amber : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.black : Colors.white,
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
      case InvestmentController.TAB_RECEIVED:
        return const Text("Gold Received",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
      default:
        return const Text("Purchased History",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
    }
  }

  Widget _buildHeaderRow(List<String> titles) {
    return Row(
      children: titles.map((t) {
        return Expanded(
          child: Text(
            t,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign:
                t == "Amount" || t == "Grams" ? TextAlign.right : TextAlign.left,
          ),
        );
      }).toList(),
    );
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

  Widget _buildPaidList() {
    final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

    return Obx(() {
      if (controller.isLoadingPaid.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.paidTransactions.isEmpty) {
        return const Center(child: Text("No paid transactions found."));
      }

      return _styledContainer(
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.paidTransactions.length,
          itemBuilder: (context, index) {
            final tx = controller.paidTransactions[index];
            final timestamp = DateTime.tryParse(tx['timestamp'] ?? '');
            final formattedDate = timestamp != null
                ? DateFormat('dd-MMM-yyyy').format(timestamp)
                : "N/A";

            return _transactionRow(
              "${index + 1}",
              "0", // SubIns
              formattedDate,
              format.format(tx["amount"]),
            );
          },
        ),
      );
    });
  }

  Widget _buildReceivedList() {
    return _styledContainer(
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.receivedTransactions.length,
        itemBuilder: (context, index) {
          final rx = controller.receivedTransactions[index];
          return _transactionRow(
            rx["insNo"].toString(),
            rx["subIns"].toString(),
            rx["date"].toString(),
            "${rx["grams"]} g",
          );
        },
      ),
    );
  }

  Widget _buildPurchasedList() {
    final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.purchasedHistory.length,
      itemBuilder: (context, index) {
        final p = controller.purchasedHistory[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 232, 240, 242),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("${p['tag']}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Color(0xFF0A2A4D))),
                  const Spacer(),
                  Text("${p['date']}", style: const TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 4),
              Text("${p['address']}"),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                      color: const Color(0xFFCADBEA),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(format.format(p['amount']),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0A2A4D))),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _styledContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A2A4D),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }

  Widget _transactionRow(String ins, String subIns, String date, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(ins, style: const TextStyle(color: Colors.white))),
          Expanded(child: Text(subIns, style: const TextStyle(color: Colors.white))),
          Expanded(child: Text(date, style: const TextStyle(color: Colors.white))),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}