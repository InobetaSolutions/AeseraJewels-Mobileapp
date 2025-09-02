
import 'package:aesera_jewels/modules/investment_details/portfolio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aesera_jewels/services/storage_service.dart';
import 'package:flutter/services.dart';
import 'package:aesera_jewels/modules/login/login_view.dart';

class InvestmentDetailScreen extends StatelessWidget {
  final InvestmentController controller = Get.put(InvestmentController());

  final int initialTabIndex;
  InvestmentDetailScreen({super.key, required this.initialTabIndex});

  @override
  Widget build(BuildContext context) {
    Get.put(InvestmentController());
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
          style: TextStyle(color: Colors.black),
        ),
        leading: BackButton(color: Colors.black, onPressed: () => Get.back()),
      
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
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
              const SizedBox(height: 8),
              if (controller.selectedTab.value == InvestmentController.TAB_PAID)
                _buildHeaderRow(["Ins No.", "Date", "Amount"])
              else if (controller.selectedTab.value ==
                  InvestmentController.TAB_RECEIVED)
                _buildHeaderRow(["Ins No.", "Date", "Grams"]),
              const SizedBox(height: 8),
              _buildTabContent(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Obx(
          () => Text(
            controller.userName.value,
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: const Color(0xFF1A0F12),
            ),
          ),
        ),
        const Spacer(),
   TextButton(
  onPressed: () async {
    Get.off(LoginView());
  },

    child: const Text("Logout", style: TextStyle(color: Colors.white)),
  ),
  Padding(
    padding: const EdgeInsets.only(
        left: 12, right: 16, top: 10.5, bottom: 10.5),
    child: ElevatedButton(
      onPressed: () async {
        await StorageService().erase();
        SystemNavigator.pop(); // exit app
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFB700),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        padding:
            const EdgeInsets.symmetric(horizontal: 21, vertical: 3),
      ),
      child: Text(
        "Logout",
        style: GoogleFonts.lexend(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF000000),
        ),
      ),
    ),
  ),
      ],
    );
  }
  

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
          const Text(
            "Total Investment Amount",
            style: TextStyle(color: Colors.amber, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Obx(
            () => Text(
              controller.formattedTotal,
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
        final selected = controller.selectedTab.value == index;
        return GestureDetector(
          onTap: () => controller.changeTab(index),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? Colors.amber : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selected ? Colors.black : Colors.white,
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
        return const Text(
          "Paid Transactions",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        );
      case InvestmentController.TAB_RECEIVED:
        return const Text(
          "Gold Received",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        );
      default:
        return const Text(
          "Purchased History",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        );
    }
  }

  Widget _buildHeaderRow(List<String> titles) {
    return Row(
      children: titles
          .map(
            (t) => Expanded(
              child: Text(
                t,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: (t == "Amount" || t == "Grams")
                    ? TextAlign.right
                    : TextAlign.left,
              ),
            ),
          )
          .toList(),
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
    return _styledContainer(
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.paidTransactions.length,
        itemBuilder: (context, index) {
          final tx = controller.paidTransactions[index];
          final date = tx.timestamp != null
              ? DateFormat('dd-MMM-yyyy').format(tx.timestamp!)
              : "N/A";
          return _transactionRow(
            "${index + 1}",
            date,
            format.format(tx.amount),
          );
        },
      ),
    );
  }

  Widget _buildReceivedList() {
    return _styledContainer(
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.paidTransactions.length,
        itemBuilder: (context, index) {
          final rx = controller.paidTransactions[index];
          final date = rx.timestamp != null
              ? DateFormat('dd-MMM-yyyy').format(rx.timestamp!)
              : "N/A";
          return _transactionRow("${index + 1}", date, "${rx.gold} g");
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
                  Text(
                    p.tag ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A2A4D),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    p.timestamp != null
                        ? DateFormat('dd-MMM-yyyy').format(p.timestamp!)
                        : "N/A",
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(p.address ?? ''),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCADBEA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    format.format(p.amount),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A2A4D),
                    ),
                  ),
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

  Widget _transactionRow(String ins, String date, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(ins, style: const TextStyle(color: Colors.white)),
          ),
          Expanded(
            child: Text(date, style: const TextStyle(color: Colors.white)),
          ),
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
