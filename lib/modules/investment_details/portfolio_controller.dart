import 'package:get/get.dart';

class PortfolioController extends GetxController {
  final isPaidTab = true.obs;

  void toggleTab(bool paid) {
    isPaidTab.value = paid;
  }

  final paidTransactions = [
    {"ins": 1, "subins": 0, "date": "18-may-2025", "amount": "100.00"},
    {"ins": 2, "subins": 0, "date": "18-may-2025", "amount": "20.00"},
    {"ins": 3, "subins": 0, "date": "20-may-2025", "amount": "750.00"},
    {"ins": 4, "subins": 0, "date": "07-jun-2025", "amount": "1000.00"},
    {"ins": 5, "subins": 0, "date": "09-jun-2025", "amount": "1000.00"},
    {"ins": 6, "subins": 0, "date": "18-may-2025", "amount": "100.00"},
  ];

  final receivedTransactions = [
    {"ins": 1, "subins": 0, "date": "18-may-2025", "grams": "4.094"},
    {"ins": 2, "subins": 0, "date": "18-may-2025", "grams": "3.021"},
    {"ins": 3, "subins": 0, "date": "20-may-2025", "grams": "2.013"},
    {"ins": 4, "subins": 0, "date": "07-jun-2025", "grams": "5.012"},
  ];
}
