
import 'package:get/get.dart';

class InvestmentController extends GetxController {
  var selectedTab = 0.obs; // 0 = Paid Amount, 1 = Received Gold, 2 = Purchased

  final paidTransactions = [
    {"insNo": 1, "subIns": 0, "date": "18-may-2025", "amount": "₹100.00"},
    {"insNo": 2, "subIns": 0, "date": "18-may-2025", "amount": "₹20.00"},
    {"insNo": 3, "subIns": 0, "date": "20-may-2025", "amount": "₹750.00"},
    {"insNo": 4, "subIns": 0, "date": "07-jun-2025", "amount": "₹1000.00"},
    {"insNo": 5, "subIns": 0, "date": "09-jun-2025", "amount": "₹1000.00"},
    {"insNo": 6, "subIns": 0, "date": "18-may-2025", "amount": "₹100.00"},
  ];

  final receivedTransactions = [
    {"insNo": 1, "subIns": 0, "date": "18-may-2025", "grams": "4.094"},
    {"insNo": 2, "subIns": 0, "date": "18-may-2025", "grams": "3.021"},
    {"insNo": 3, "subIns": 0, "date": "20-may-2025", "grams": "2.013"},
    {"insNo": 4, "subIns": 0, "date": "07-jun-2025", "grams": "5.012"},
  ];

  final purchasedHistory = [
    {
      "tag": "#PD1303925",
      "date": "18-may-2025",
      "address": "Btm Layout second stage\n16th Main road\nBengaluru, 560076.",
      "amount": "₹13,329.78",
    },
    {
      "tag": "#PD1303926",
      "date": "19-may-2025",
      "address": "Btm Layout second stage\n16th Main road\nBengaluru, 560076.",
      "amount": "₹12,000.50",
    },
    {
      "tag": "#PD1303925",
      "date": "18-may-2025",
      "address": "Btm Layout second stage\n16th Main road\nBengaluru, 560076.",
      "amount": "₹13,329.78",
    },
    {
      "tag": "#PD1303926",
      "date": "19-may-2025",
      "address": "Btm Layout second stage\n16th Main road\nBengaluru, 560076.",
      "amount": "₹12,000.50",
    },
    {
      "tag": "#PD1303925",
      "date": "18-may-2025",
      "address": "Btm Layout second stage\n16th Main road\nBengaluru, 560076.",
      "amount": "₹13,329.78",
    },
    {
      "tag": "#PD1303926",
      "date": "19-may-2025",
      "address": "Btm Layout second stage\n16th Main road\nBengaluru, 560076.",
      "amount": "₹12,000.50",
    },
    {
      "tag": "#PD1303925",
      "date": "18-may-2025",
      "address": "Btm Layout second stage\n16th Main road\nBengaluru, 560076.",
      "amount": "₹13,329.78",
    },
    {
      "tag": "#PD1303926",
      "date": "19-may-2025",
      "address": "Btm Layout second stage\n16th Main road\nBengaluru, 560076.",
      "amount": "₹12,000.50",
    },
  ];

  void changeTab(int index) {
    selectedTab.value = index;
  }
}

