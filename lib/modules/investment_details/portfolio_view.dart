import 'package:aesera_jewels/modules/login/login_view.dart';
import 'package:aesera_jewels/modules/investment_details/portfolio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PortfolioScreen extends GetWidget<PortfolioController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F4FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Investment Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rama krishnan",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: StadiumBorder(),
                      ),
                      onPressed: () {
                        // TODO: handle logout
                      },
                      child: TextButton(
                        onPressed: () {
                          Get.offAll(() => LoginView());
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF0A2A4D),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Investment Amount",
                      style: TextStyle(color: Colors.amber),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "₹16,300",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildTabToggle(controller),
              SizedBox(height: 20),
              Text(
                controller.isPaidTab.value ? "Transaction" : "History",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Table(
                    columnWidths: {
                      0: FixedColumnWidth(40),
                      1: FixedColumnWidth(60),
                      2: FixedColumnWidth(100),
                      3: FixedColumnWidth(80),
                    },
                    children: [
                      TableRow(
                        children: [
                          _buildTableHeader("Ins No."),
                          _buildTableHeader("Subins No."),
                          _buildTableHeader("Date"),
                          Text(
                            controller.isPaidTab.value ? "Amount" : "Grams",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          _buildTableHeader("View"),
                        ],
                      ),
                      ...(controller.isPaidTab.value
                              ? controller.paidTransactions
                              : controller.receivedTransactions)
                          .map((item) {
                            return TableRow(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                              children: [
                                _buildTableCell("${item['ins']}"),
                                _buildTableCell("${item['subins']}"),
                                _buildTableCell("${item['date']}"),
                                _buildTableCell(
                                  controller.isPaidTab.value
                                      ? "${item['amount']}"
                                      : "${item['grams']}",
                                ),
                                Center(
                                  child: Icon(Icons.menu, color: Colors.amber),
                                ),
                              ],
                            );
                          })
                          .toList(),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTableHeader(String label) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTableCell(String content) {
    return Padding(padding: EdgeInsets.all(8), child: Text(content));
  }

  Widget _buildTabToggle(PortfolioController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF0A2A4D),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildTabButton("Paid Amount", true, controller),
          _buildTabButton("Received Gold", false, controller),
        ],
      ),
    );
  }

  Widget _buildTabButton(
    String text,
    bool isPaid,
    PortfolioController controller,
  ) {
    final isActive = controller.isPaidTab.value == isPaid;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.toggleTab(isPaid),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Colors.amber : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isActive ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
