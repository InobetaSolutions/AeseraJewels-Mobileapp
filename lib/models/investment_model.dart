import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

class InvestmentResponse {
  final String totalAmount;
  final String totalGrams;
  final List<Transaction> payments;

  InvestmentResponse({
    required this.totalAmount,
    required this.totalGrams,
    required this.payments,
  });

  factory InvestmentResponse.fromJson(Map<String, dynamic> json) {
    return InvestmentResponse(
      totalAmount: json['totalAmount'] ?? "0.00",
      totalGrams: json['totalGrams'] ?? "0.00",
      payments: (json['payments'] as List? ?? [])
          .map((item) => Transaction.fromJson(item))
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
  // final double deliveryCharge;
  final double totalWithTax;
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
    //  required this.deliveryCharge,
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
      //  deliveryCharge: (json['deliveryCharge'] ?? 0).toDouble(),
      totalWithTax: (json['totalWithTax'] ?? 0).toDouble(),
      tag: json['tag'],
      address: json['address'],
      admin: json['admin'],
    );
  }
}

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
  final double investAmount; // ✅ NEW FIELD ADDED
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
    required this.investAmount,
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
      investAmount: (json['investAmount']?.toDouble() ?? 0.0), // ✅ parsed here
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

/// ---- Coin Payment Response ----
class CoinPaymentResponse {
  final bool status;
  final List<CoinPayment> data;
  final CoinPaymentSummary summary;

  CoinPaymentResponse({
    required this.status,
    required this.data,
    required this.summary,
  });

  factory CoinPaymentResponse.fromJson(Map<String, dynamic> json) {
    return CoinPaymentResponse(
      status: json['status'] ?? false,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => CoinPayment.fromJson(e))
          .toList(),
      summary: CoinPaymentSummary.fromJson(json['summary'] ?? {}),
    );
  }
}

/// ---- Coin Payment Model ----
class CoinPayment {
  final String id;
  final String mobileNumber;
  final List<CoinItem> items;
  final double totalAmount;
  final double taxAmount;
  final double deliveryCharge;
  final double amountPayable;
  final double investAmount;
  final String address;
  final String city;
  final String postCode;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? approvedAt;

  CoinPayment({
    required this.id,
    required this.mobileNumber,
    required this.items,
    required this.totalAmount,
    required this.taxAmount,
    required this.deliveryCharge,
    required this.amountPayable,
    required this.investAmount,
    required this.address,
    required this.city,
    required this.postCode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.approvedAt,
  });

  factory CoinPayment.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(String? dateString) {
      if (dateString == null) return null;
      try {
        return DateTime.tryParse(dateString);
      } catch (_) {
        return null;
      }
    }

    return CoinPayment(
      id: json['_id'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => CoinItem.fromJson(e))
          .toList(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      taxAmount: (json['taxAmount'] ?? 0).toDouble(),
      deliveryCharge: (json['deliveryCharge'] ?? 0).toDouble(),
      amountPayable: (json['amountPayable'] ?? 0).toDouble(),
      investAmount: (json['investAmount'] ?? 0).toDouble(),
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      postCode: json['postCode'] ?? '',
      status: json['status'] ?? '',
      createdAt: parseDate(json['createdAt']),
      updatedAt: parseDate(json['updatedAt']),
      approvedAt: parseDate(json['approvedAt']),
    );
  }

  String get formattedCreatedAt {
    if (createdAt == null) return "N/A";
    return DateFormat('dd-MMM-yyyy, hh:mm a').format(createdAt!);
  }

  String get formattedUpdatedAt {
    if (updatedAt == null) return "N/A";
    return DateFormat('dd-MMM-yyyy, hh:mm a').format(updatedAt!);
  }

  String get formattedStatus {
    switch (status.toLowerCase()) {
      case 'payment confirmed':
        return 'Confirmed';
      case 'approval pending':
        return 'Pending';
      default:
        return status;
    }
  }

  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'payment confirmed':
        return Colors.green;
      case 'approval pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String get itemsDescription {
    return items
        .map((item) => '${item.coinGrams}g × ${item.quantity}')
        .join(', ');
  }

  double get totalGrams {
    return items.fold(
      0.0,
      (sum, item) => sum + (item.coinGrams * item.quantity),
    );
  }
}

/// ---- Coin Item Model ----
class CoinItem {
  final double coinGrams;
  final int quantity;
  final double amount;

  CoinItem({
    required this.coinGrams,
    required this.quantity,
    required this.amount,
  });

  factory CoinItem.fromJson(Map<String, dynamic> json) {
    return CoinItem(
      coinGrams: (json['coinGrams'] ?? 0).toDouble(),
      quantity: (json['quantity'] ?? 0).toInt(),
      amount: (json['amount'] ?? 0).toDouble(),
    );
  }
}

/// ---- Coin Payment Summary ----
class CoinPaymentSummary {
  final int count;
  final double totalAmount;
  final double totalTax;
  final double totalDelivery;
  final double totalPayable;
  final double totalInvest;

  CoinPaymentSummary({
    required this.count,
    required this.totalAmount,
    required this.totalTax,
    required this.totalDelivery,
    required this.totalPayable,
    required this.totalInvest,
  });

  factory CoinPaymentSummary.fromJson(Map<String, dynamic> json) {
    return CoinPaymentSummary(
      count: (json['count'] ?? 0).toInt(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      totalTax: (json['totalTax'] ?? 0).toDouble(),
      totalDelivery: (json['totalDelivery'] ?? 0).toDouble(),
      totalPayable: (json['totalPayable'] ?? 0).toDouble(),
      totalInvest: (json['totalInvest'] ?? 0).toDouble(),
    );
  }
}

class SellPaymentHistory {
  final String id;
  final String mobileNumber;
  final double amount;
  final double? gram;
  final double paymentGatewayCharges;
  final double taxAmount;
  final double deliveryCharges;
  final String paymentStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String timestamp;

  SellPaymentHistory({
    required this.id,
    required this.mobileNumber,
    required this.amount,
    this.gram,
    required this.paymentGatewayCharges,
    required this.taxAmount,
    required this.deliveryCharges,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.timestamp,
  });

  factory SellPaymentHistory.fromJson(Map<String, dynamic> json) {
    return SellPaymentHistory(
      id: json['_id'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      amount: json['amount'] != null ? json['amount'].toDouble() : 0.0,
      gram: json['gram'] != null ? json['gram'].toDouble() : null,
      paymentGatewayCharges: json['paymentGatewayCharges'] != null
          ? json['paymentGatewayCharges'].toDouble()
          : 0.0,
      taxAmount: json['taxAmount'] != null ? json['taxAmount'].toDouble() : 0.0,
      deliveryCharges: json['deliveryCharges'] != null
          ? json['deliveryCharges'].toDouble()
          : 0.0,
      paymentStatus: json['paymentStatus'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      timestamp: json['timestamp'] ?? '',
    );
  }

  String get formattedAmount {
    final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    return format.format(amount);
  }

  String get formattedTotalAmount {
    final total = amount + taxAmount + deliveryCharges + paymentGatewayCharges;
    final format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    return format.format(total);
  }

  Color get statusColor {
    final status = paymentStatus.toLowerCase();
    if (status.contains('approved') || status.contains('confirm')) {
      return Colors.green;
    } else if (status.contains('pending') || status.contains('processing')) {
      return Colors.orange;
    } else if (status.contains('failed') || status.contains('rejected')) {
      return Colors.red;
    }
    return Colors.grey;
  }
}

class SellPaymentResponse {
  final bool success;
  final String message;
  final List<SellPaymentHistory> data;

  SellPaymentResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SellPaymentResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'] ?? [];
    return SellPaymentResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: dataList
          .map<SellPaymentHistory>((item) => SellPaymentHistory.fromJson(item))
          .toList(),
    );
  }
}
