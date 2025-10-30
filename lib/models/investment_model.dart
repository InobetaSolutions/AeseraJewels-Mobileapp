
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

/// ---- Investment Response ----
class InvestmentResponse {
  final double totalAmount;
  final double totalGrams;
  final List<Transaction> payments;

  InvestmentResponse({
    required this.totalAmount,
    required this.totalGrams,
    required this.payments,
  });

  factory InvestmentResponse.fromJson(Map<String, dynamic> json) {
    return InvestmentResponse(
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      totalGrams: (json['totalGrams'] ?? 0).toDouble(),
      payments: (json['payments'] as List<dynamic>? ?? [])
          .map((e) => Transaction.fromJson(e))
          .toList(),
    );
  }
}

/// ---- Transaction Model (Paid Tab) ----
class Transaction {
  final String id;
  final String mobile;
  final String status;
  final double amount;
  final DateTime? timestamp;
  final double gram;
  final double amountAllocated;
  final double gramAllocated;
  final double gold;
  final double taxAmount;
  final double deliveryCharge; // ✅ New field
  final double totalWithTax; // ✅ New field (correct key)
  final String? tag;
  final String? address;
  final String? admin;

  Transaction({
    required this.id,
    required this.mobile,
    required this.status,
    required this.amount,
    required this.timestamp,
    required this.gram,
    required this.amountAllocated,
    required this.gramAllocated,
    required this.gold,
    required this.taxAmount,
    required this.deliveryCharge,
    required this.totalWithTax,
    this.tag,
    this.address,
    this.admin,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    DateTime? parsedDate;
    final raw = json['timestamp']?.toString().trim();

    if (raw != null && raw.isNotEmpty) {
      try {
        if (raw.contains("/")) {
          parsedDate = DateFormat("d/M/yyyy, h:mm:ss a").parseLoose(raw);
        } else {
          parsedDate = DateTime.tryParse(raw);
        }
      } catch (_) {
        parsedDate = null;
      }
    }

    return Transaction(
      id: json['_id'] ?? '',
      mobile: json['mobile'] ?? '',
      status: json['status'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      timestamp: parsedDate,
      gram: (json['gram'] ?? 0).toDouble(),
      amountAllocated: (json['amount_allocated'] ?? 0).toDouble(),
      gramAllocated: (json['gram_allocated'] ?? 0).toDouble(),
      gold: (json['gold'] ?? 0).toDouble(),
      taxAmount: (json['taxAmount'] ?? 0).toDouble(),
      deliveryCharge: (json['deliveryCharge'] ?? 0).toDouble(), // ✅ added
      totalWithTax: (json['totalWithTax'] ?? 0).toDouble(), // ✅ added
      tag: json['tag'],
      address: json['address'],
      admin: json['admin'],
    );
  }
}

// /// ---- Investment Response ----
// class InvestmentResponse {
//   final double totalAmount;
//   final double totalGrams;
//   final List<Transaction> payments;

//   InvestmentResponse({
//     required this.totalAmount,
//     required this.totalGrams,
//     required this.payments,
//   });

//   factory InvestmentResponse.fromJson(Map<String, dynamic> json) {
//     return InvestmentResponse(
//       totalAmount: (json['totalAmount'] ?? 0).toDouble(),
//       totalGrams: (json['totalGrams'] ?? 0).toDouble(),
//       payments: (json['payments'] as List<dynamic>? ?? [])
//           .map((e) => Transaction.fromJson(e))
//           .toList(),
//     );
//   }
// }

// /// ---- Transaction Model (Paid Tab) ----
// class Transaction {
//   final String id;
//   final String mobile;
//   final String status;
//   final double amount;
//   final DateTime? timestamp;
//   final double gram;
//   final double amountAllocated;
//   final double gramAllocated;
//   final double gold;
//   final double taxAmount; // ✅ New Field
//   final double totalPayWithTax; // ✅ New Field
//   final String? tag;
//   final String? address;
//   final String? admin;

//   Transaction({
//     required this.id,
//     required this.mobile,
//     required this.status,
//     required this.amount,
//     required this.timestamp,
//     required this.gram,
//     required this.amountAllocated,
//     required this.gramAllocated,
//     required this.gold,
//     required this.taxAmount,
//     required this.totalPayWithTax,
//     this.tag,
//     this.address,
//     this.admin,
//   });

//   factory Transaction.fromJson(Map<String, dynamic> json) {
//     DateTime? parsedDate;
//     final raw = json['timestamp']?.toString().trim();

//     if (raw != null && raw.isNotEmpty) {
//       try {
//         if (raw.contains("/")) {
//           parsedDate = DateFormat("d/M/yyyy, h:mm:ss a").parseLoose(raw);
//         } else {
//           parsedDate = DateTime.tryParse(raw);
//         }
//       } catch (_) {
//         parsedDate = null;
//       }
//     }

//     return Transaction(
//       id: json['_id'] ?? '',
//       mobile: json['mobile'] ?? '',
//       status: json['status'] ?? '',
//       amount: (json['amount'] ?? 0).toDouble(),
//       timestamp: parsedDate,
//       gram: (json['gram'] ?? 0).toDouble(),
//       amountAllocated: (json['amount_allocated'] ?? 0).toDouble(),
//       gramAllocated: (json['gram_allocated'] ?? 0).toDouble(),
//       gold: (json['gold'] ?? 0).toDouble(),
//       taxAmount: (json['taxAmount'] ?? 0).toDouble(), // ✅ Parse taxAmount
//       totalPayWithTax:
//           (json['totalPayAmountWithTax'] ?? 0).toDouble(), // ✅ Parse totalPayAmountWithTax
//       tag: json['tag'],
//       address: json['address'],
//       admin: json['admin'],
//     );
//   }
// }

/// ---- Allotment Model (Received Tab) ----
class Allotment {
  final String id;
  final String mobile;
  final double gram;
  final String? gold;
  final DateTime? timestamp;
  final double amountReduced;

  Allotment({
    required this.id,
    required this.mobile,
    required this.gram,
    required this.gold,
    required this.timestamp,
    required this.amountReduced,
  });

  factory Allotment.fromJson(Map<String, dynamic> json) {
    DateTime? parsedDate;
    final raw = json['timestamp']?.toString().trim();

    if (raw != null && raw.isNotEmpty) {
      try {
        if (raw.contains("/")) {
          parsedDate = DateFormat("d/M/yyyy, h:mm:ss a").parseLoose(raw);
        } else {
          parsedDate = DateTime.tryParse(raw);
        }
      } catch (_) {
        parsedDate = null;
      }
    }

    return Allotment(
      id: json['_id'] ?? '',
      mobile: json['mobile'] ?? '',
      gram: (json['gram'] ?? 0).toDouble(),
      gold: json['gold'],
      timestamp: parsedDate,
      amountReduced: (json['amountReduced'] ?? 0).toDouble(),
    );
  }
}

class AllotmentResponse {
  final String mobile;
  final List<Allotment> allotments;

  AllotmentResponse({required this.mobile, required this.allotments});

  factory AllotmentResponse.fromJson(Map<String, dynamic> json) {
    return AllotmentResponse(
      mobile: json['mobile'] ?? '',
      allotments: (json['allotments'] as List<dynamic>? ?? [])
          .map((e) => Allotment.fromJson(e))
          .toList(),
    );
  }
}

/// ---- Purchased Tab (User Catalog) ----
class UserCatalog {
  final String id;
  final String mobileNumber;
  final String tagid;
  final String goldType;
  final String description;
  final double amount;
  final String paymentStatus;
  final double grams;
  final String address;
  final String city;
  final String postCode;
  final double paidAmount;
  final double paidGrams;
  final String allotmentStatus;
  final DateTime? timestamp;
  final DateTime? updatedAt;

  UserCatalog({
    required this.id,
    required this.mobileNumber,
    required this.tagid,
    required this.goldType,
    required this.paymentStatus,
    required this.description,
    required this.amount,
    required this.grams,
    required this.address,
    required this.city,
    required this.postCode,
    required this.paidAmount,
    required this.paidGrams,
    required this.allotmentStatus,
    required this.timestamp,
    required this.updatedAt,
  });

  factory UserCatalog.fromJson(Map<String, dynamic> json) {
    DateTime? parsedTimestamp;
    DateTime? parsedUpdated;

    try {
      if (json['timestamp'] != null) {
        parsedTimestamp = DateTime.tryParse(json['timestamp']);
      }
      if (json['updatedAt'] != null) {
        parsedUpdated = DateTime.tryParse(json['updatedAt']);
      }
    } catch (_) {}

    return UserCatalog(
      id: json['_id'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      tagid: json['tagid'] ?? '',
      goldType: json['goldType'] ?? '',
      description: json['description'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      amount: (json['amount']?.toDouble() ?? 0.0),
      grams: (json['grams']?.toDouble() ?? 0.0),
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      postCode: json['postCode'] ?? '',
      paidAmount: (json['Paidamount']?.toDouble() ?? 0.0),
      paidGrams: (json['Paidgrams']?.toDouble() ?? 0.0),
      allotmentStatus: json['allotmentStatus'] ?? '',
      timestamp: parsedTimestamp ?? DateTime.now(),
      updatedAt: parsedUpdated,
    );
  }

  static List<UserCatalog> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => UserCatalog.fromJson(json)).toList();
  }
}
