
// import 'dart:convert';
// import 'package:aesera_jewels/modules/investment_details/portfolio_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';

// class InvestmentScreen extends StatelessWidget {
//   final InvestmentController controller = Get.put(InvestmentController());

//   InvestmentScreen({super.key, required int initialTabIndex});

//   @override
//   Widget build(BuildContext context) {
//     controller.changeTab(InvestmentController.TAB_PAID);

//     final width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F4FA),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text('Investment Details', style: TextStyle(color: Colors.black)),
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
//                 else if (controller.selectedTab.value == InvestmentController.TAB_RECEIVED)
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

//   Widget _buildHeader() {
//     return Row(
//       children: [
//         const Text("Rama Krishnan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//         const Spacer(),
//         ElevatedButton(
//           onPressed: () => Get.back(), // Replace with logout logic
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
//           const Text("Total Investment Amount", style: TextStyle(color: Colors.amber, fontSize: 16)),
//           const SizedBox(height: 6),
//           Obx(() => Text(
//                 controller.formattedTotalInvestment,
//                 style: const TextStyle(
//                     color: Colors.amber, fontSize: 26, fontWeight: FontWeight.bold),
//               )),
//         ],
//       ),
//     );
//   }

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
//         final isSelected = controller.selectedTab.value == index;
//         return GestureDetector(
//           onTap: () => controller.changeTab(index),
//           child: Container(
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: isSelected ? Colors.amber : Colors.transparent,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: isSelected ? Colors.black : Colors.white,
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
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
//       case InvestmentController.TAB_RECEIVED:
//         return const Text("Gold Received",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
//       default:
//         return const Text("Purchased History",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
//     }
//   }

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

//   Widget _buildPaidList() {
//     final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

//     return Obx(() {
//       if (controller.isLoadingPaid.value) {
//         return const Center(child: CircularProgressIndicator());
//       }

//       if (controller.paidTransactions.isEmpty) {
//         return const Center(child: Text("No paid transactions found."));
//       }

//       return _styledContainer(
//         ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: controller.paidTransactions.length,
//           itemBuilder: (context, index) {
//             final tx = controller.paidTransactions[index];
//             final timestamp = DateTime.tryParse(tx['timestamp'] ?? '');
//             final formattedDate = timestamp != null
//                 ? DateFormat('dd-MMM-yyyy').format(timestamp)
//                 : "N/A";

//             return _transactionRow(
//               "${index + 1}",
//               "0", // SubIns
//               formattedDate,
//               format.format(tx["amount"]),
//             );
//           },
//         ),
//       );
//     });
//   }

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
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text("${p['tag']}",
//                       style: const TextStyle(
//                           fontWeight: FontWeight.bold, color: Color(0xFF0A2A4D))),
//                   const Spacer(),
//                   Text("${p['date']}", style: const TextStyle(color: Colors.grey)),
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

//   Widget _styledContainer(Widget child) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFF0A2A4D),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: child,
//     );
//   }

//   Widget _transactionRow(String ins, String subIns, String date, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Expanded(child: Text(ins, style: const TextStyle(color: Colors.white))),
//           Expanded(child: Text(subIns, style: const TextStyle(color: Colors.white))),
//           Expanded(child: Text(date, style: const TextStyle(color: Colors.white))),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(color: Colors.white),
//               textAlign: TextAlign.right,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:aesera_jewels/modules/investment_details/portfolio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InvestmentDetailScreen extends GetWidget<InvestmentController> {
  final controller = Get.put(InvestmentController());

  InvestmentDetailScreen({super.key, required int initialTabIndex});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Investment Details",
          style: GoogleFonts.lexend(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // -------------------- Tabs --------------------
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(controller.tabs.length, (index) {
                final isSelected = controller.selectedTab.value == index;
                return GestureDetector(
                  onTap: () => controller.changeTab(index),
                  child: Container(
                    width: (width - 48) / 3,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      controller.tabs[index],
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }),
            )),

            const SizedBox(height: 20),

            // -------------------- Total Card --------------------
            Obx(() => Container(
              width: width,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.tabs[controller.selectedTab.value],
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    controller.getTotalValue(),
                    style: GoogleFonts.lexend(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )),

            const SizedBox(height: 20),

            // -------------------- Transaction History --------------------
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Transaction History",
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: Obx(() {
                final transactions = controller.getTransactions();
                if (transactions.isEmpty) {
                  return Center(
                    child: Text(
                      "No transactions yet",
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: transactions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final tx = transactions[index];
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left side
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tx['title'] ?? '',
                                style: GoogleFonts.lexend(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                tx['date'] ?? '',
                                style: GoogleFonts.manrope(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),

                          // Right side
                          Text(
                            tx['amount'] ?? '',
                            style: GoogleFonts.lexend(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
