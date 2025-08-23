import 'package:aesera_jewels/modules/investment_details/portfolio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login/login_view.dart';

class InvestmentScreen extends StatelessWidget {
  final InvestmentController controller = Get.put(InvestmentController());

  InvestmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Investment Details',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Obx(
            () => Column(
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
                if (controller.selectedTab.value == 0) _buildPaidHeaderRow(),
                if (controller.selectedTab.value == 1)
                  _buildReceivedHeaderRow(),
                const SizedBox(height: 8),
                _buildTabContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Text(
          "Rama Krishnan",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () => Get.offAll(() => LoginView()),
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total Investment Amount",
            style: TextStyle(color: Colors.amber, fontSize: 16),
          ),
          SizedBox(height: 6),
          Text(
            "₹16,300",
            style: TextStyle(
              color: Colors.amber,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Obx(
      () => Container(
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFF0A2A4D),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            _tabButton("Paid Amount", 0),
            _tabButton("Received Gold", 1),
            _tabButton("Purchased", 2),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(String title, int index) {
    final isSelected = controller.selectedTab.value == index;
    return Expanded(
      child: GestureDetector(
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
      ),
    );
  }

  Widget _buildSectionTitle() {
    switch (controller.selectedTab.value) {
      case 0:
        return const Text(
          "Paid Transactions",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        );
      case 1:
        return const Text(
          "Gold Received",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        );
      case 2:
      default:
        return const Text(
          "Purchased History",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        );
    }
  }

  Widget _buildPaidHeaderRow() {
    return Row(
      children: const [
        Expanded(
          child: Text("Ins No.", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Text("SubIns", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Text(
            "Amount",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(width: 24), // for icon
      ],
    );
  }

  Widget _buildReceivedHeaderRow() {
    return Row(
      children: const [
        Expanded(
          child: Text("Ins No.", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Text("SubIns", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Text(
            "Grams",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(width: 24), // for icon
      ],
    );
  }

  Widget _buildTabContent() {
    switch (controller.selectedTab.value) {
      case 0:
        return _buildPaidList();
      case 1:
        return _buildReceivedList();
      case 2:
      default:
        return _buildPurchasedList();
    }
  }

  Widget _buildPaidList() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A2A4D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.paidTransactions.length,
        itemBuilder: (context, index) {
          final tx = controller.paidTransactions[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(child: Text("${tx['insNo']}")),
                Expanded(child: Text("${tx['subIns']}")),
                Expanded(child: Text("${tx['date']}")),
                Expanded(
                  child: Text(
                    "₹${tx['amount']}",
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.drag_handle, color: Colors.amber),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildReceivedList() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A2A4D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.receivedTransactions.length,
        itemBuilder: (context, index) {
          final rx = controller.receivedTransactions[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(child: Text("${rx['insNo']}")),
                Expanded(child: Text("${rx['subIns']}")),
                Expanded(child: Text("${rx['date']}")),
                Expanded(
                  child: Text(
                    "${rx['grams']} g",
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.drag_handle, color: Colors.amber),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPurchasedList() {
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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${p['tag']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A2A4D),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${p['date']}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text("${p['address']}"),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCADBEA),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "₹${p['amount']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A2A4D),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
