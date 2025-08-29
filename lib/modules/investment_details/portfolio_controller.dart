
// import 'dart:convert';

// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';

// class InvestmentController extends GetxController {
//   static const int TAB_PAID = 0;
//   static const int TAB_RECEIVED = 1;
//   static const int TAB_PURCHASED = 2;

//   var selectedTab = TAB_PAID.obs;
//   var paidTransactions = <Map<String, dynamic>>[].obs;
//   var isLoadingPaid = false.obs;

//   final receivedTransactions = [
//     {"insNo": 1, "subIns": 0, "date": "18-May-2025", "grams": 4.094},
//     {"insNo": 2, "subIns": 0, "date": "18-May-2025", "grams": 3.021},
//     {"insNo": 3, "subIns": 0, "date": "20-May-2025", "grams": 2.013},
//     {"insNo": 4, "subIns": 0, "date": "07-Jun-2025", "grams": 5.012},
//   ];

//   final purchasedHistory = [
//     {
//       "tag": "#PD1303925",
//       "date": "18-May-2025",
//       "address": "BTM Layout Second Stage\n16th Main Road\nBengaluru, 560076",
//       "amount": 13329.78,
//     },
//     {
//       "tag": "#PD1303926",
//       "date": "19-May-2025",
//       "address": "BTM Layout Second Stage\n16th Main Road\nBengaluru, 560076",
//       "amount": 12000.50,
//     },
//   ];

//   void changeTab(int index) {
//     selectedTab.value = index;
//     if (index == TAB_PAID) getPaidTransactions();
//   }

//   Future<void> getPaidTransactions() async {
//     isLoadingPaid.value = true;

//     const url = 'http://13.204.96.244:3000/api/getpaymenthistory';
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization':
//           'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtb2JpbGUiOiI5Nzg3MTIxMjIyIiwibmFtZSI6ImthcnRoaTEiLCJpYXQiOjE3NTU5NTA1ODksImV4cCI6MTc1NTk1NDE4OX0.FyJANRokRY'
//     };
//     final body = json.encode({"mobile": "6305453841"});

//     try {
//       final request = http.Request('POST', Uri.parse(url));
//       request.headers.addAll(headers);
//       request.body = body;

//       final response = await request.send();

//       if (response.statusCode == 200) {
//         final raw = await response.stream.bytesToString();
//         final List<dynamic> data = json.decode(raw);

//         paidTransactions.value =
//             data.where((e) => e['status'] == 'approved').toList().cast<Map<String, dynamic>>();
//       } else {
//         Get.snackbar("Error", "Failed to fetch paid transactions.");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Something went wrong: $e");
//     }

//     isLoadingPaid.value = false;
//   }

//   double get totalInvestment =>
//       paidTransactions.fold(0.0, (sum, tx) => sum + (tx["amount"] ?? 0));

//   String get formattedTotalInvestment {
//     final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
//     return format.format(totalInvestment);
//   }
// }
import 'package:get/get.dart';

class InvestmentController extends GetxController {
  var selectedTab = 0.obs;

  List<String> tabs = ["Paid Amount", "Received Gold", "Purchased"];

  void changeTab(int index) {
    selectedTab.value = index;
  }

  String getTotalValue() {
    if (selectedTab.value == 0) return "₹ 1,20,000";
    if (selectedTab.value == 1) return "15 gm";
    return "₹ 80,000";
  }

  List<Map<String, String>> getTransactions() {
    if (selectedTab.value == 0) {
      return [
        {"title": "Payment", "date": "12 Aug 2025", "amount": "₹ 50,000"},
        {"title": "Payment", "date": "5 Jul 2025", "amount": "₹ 70,000"},
      ];
    } else if (selectedTab.value == 1) {
      return [
        {"title": "Gold Received", "date": "10 Aug 2025", "amount": "5 gm"},
        {"title": "Gold Received", "date": "2 Jul 2025", "amount": "10 gm"},
      ];
    } else {
      return [
        {"title": "Purchase", "date": "15 Aug 2025", "amount": "₹ 40,000"},
        {"title": "Purchase", "date": "8 Jul 2025", "amount": "₹ 40,000"},
      ];
    }
  }
}
