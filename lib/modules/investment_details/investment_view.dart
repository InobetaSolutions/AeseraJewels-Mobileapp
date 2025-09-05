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
            await Future.delayed(const Duration(seconds: 0));
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
                if (controller.selectedTab.value ==
                    InvestmentController.TAB_PAID)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildHeaderRow(
                      titles: ["Ins No.", "Date & Time", "Amount", "Grams"],
                      flexValues: [2, 4, 2, 2],
                    ),
                  )
                else if (controller.selectedTab.value ==
                    InvestmentController.TAB_RECEIVED)
                  _buildHeaderRow(
                    titles: ["Ins No.", "Date & Time", "Amount", "Grams"],
                    flexValues: [2, 4, 2, 2],
                  ),
                const SizedBox(height: 8),
                _buildTabContent(),
              ],
            ),
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
            textAlign: TextAlign.start,
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.w800, // extra bold
              fontSize: 28, // bigger size
              color: const Color(0xFF1A0F12),
              letterSpacing: 1.2, // more spacing for uniqueness
              height: 1.3, // better line height
              shadows: [
                Shadow(
                  offset: const Offset(1.5, 1.5),
                  blurRadius: 3,
                  color: Colors.black.withOpacity(0.2), // soft shadow for depth
                ),
              ],
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
            padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 3),
          ),
          child: Text(
            "Logout",
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF000000),
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
            style: TextStyle(color: Colors.amber, fontSize: 20),
          ),
          const SizedBox(height: 6),
          Obx(
            () => Text(
              controller.formattedTotal,
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Total Allotment Grams",
            style: TextStyle(color: Colors.amber, fontSize: 20),
          ),
          const SizedBox(height: 6),
          Obx(
            () => Text(
              controller.formattedTotalGrams,
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 25,
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
                  fontSize: 20, // 👈 Added font size here
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
        return const Text(
          "Paid Transactions",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      case InvestmentController.TAB_RECEIVED:
        return const Text(
          "Gold Received",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      default:
        return const Text(
          "Purchased History",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
    }
  }

  Widget _buildHeaderRow({
    required List<String> titles,
    required List<int> flexValues,
  }) {
    assert(
      titles.length == flexValues.length,
      "Titles and flex values must match",
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(titles.length, (index) {
        return Expanded(
          flex: flexValues[index],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              titles[index],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
              textAlign: index < 2 ? TextAlign.start : TextAlign.right,
              softWrap: false,
            ),
          ),
        );
      }),
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
    final format = NumberFormat.currency(locale: 'en_IN', symbol: '');
    if (controller.paidTransactions.isEmpty) {
      return _styledContainer(
        Center(
          child: Text(
            "No Data Available",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
    return _styledContainer(
      Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.paidTransactions.length,
            itemBuilder: (context, index) {
              final tx = controller.paidTransactions[index];
              final dateTimeString = tx.timestamp != null
                  ? DateFormat('dd-MMM-yyyy h:mm a').format(tx.timestamp!)
                  : "N/A";
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 4,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0, left: 8.0),
                        child: Expanded(
                          flex: 2,
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 8.0),
                        child: Expanded(
                          flex: 4,
                          child: Text(
                            dateTimeString,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Expanded(
                          flex: 2,
                          child: Text(
                            format.format(tx.amount),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${(tx.gramAllocated > 0 ? tx.gramAllocated : tx.gram).toStringAsFixed(3)}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// RECEIVED LIST SAME AS PAID LIST
  Widget _buildReceivedList() {
    final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    if (controller.allotments.isEmpty) {
      return _styledContainer(
        Center(
          child: Text(
            "No Data Available",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
    return _styledContainer(
      Column(
        // 👈 Changed from ListView to Column
        children: List.generate(controller.allotments.length, (index) {
          final rx = controller.allotments[index];
          final dateTimeString = rx.timestamp != null
              ? DateFormat('dd-MMM-yyyy h:mm a').format(rx.timestamp)
              : "N/A";

          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0, left: 8.0),
                    child: Expanded(
                      flex: 2,
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 8.0),
                    child: Expanded(
                      flex: 4,
                      child: Text(
                        dateTimeString,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Expanded(
                      flex: 2,
                      child: Text(
                        format.format(rx.amountReduced ?? 0),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "${rx.gram.toStringAsFixed(3)} g",
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
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
                        ? DateFormat('dd-MMM-yyyy hh:mm a').format(p.timestamp!)
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
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }
}
