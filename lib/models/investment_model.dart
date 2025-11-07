
import 'package:flutter/material.dart';
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
    return items.map((item) => '${item.coinGrams}g × ${item.quantity}').join(', ');
  }

  double get totalGrams {
    return items.fold(0.0, (sum, item) => sum + (item.coinGrams * item.quantity));
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
