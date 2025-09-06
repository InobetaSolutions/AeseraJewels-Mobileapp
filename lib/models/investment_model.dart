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
  final String? tag;
  final String? address;

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
    this.tag,
    this.address,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'] ?? '',
      mobile: json['mobile'] ?? '',
      status: json['status'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'])
          : null,
      gram: (json['gram'] ?? 0).toDouble(),
      amountAllocated: (json['amount_allocated'] ?? 0).toDouble(),
      gramAllocated: (json['gram_allocated'] ?? 0).toDouble(),
      gold: (json['gold'] ?? 0).toDouble(),
      tag: json['tag'],
      address: json['address'],
    );
  }
}

class Allotment {
  final String id;
  final String mobile;
  final double gram;
  final DateTime timestamp;
  final double amountReduced;

  Allotment({
    required this.id,
    required this.mobile,
    required this.gram,
    required this.timestamp,
    required this.amountReduced,
  });

  factory Allotment.fromJson(Map<String, dynamic> json) {
    return Allotment(
      id: json['_id'] ?? '',
      mobile: json['mobile'] ?? '',
      gram: (json['gram'] ?? 0).toDouble(),
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
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
      allotments:
          (json['allotments'] as List<dynamic>?)
              ?.map((e) => Allotment.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class UserCatalog {
  String id;
  String mobileNumber;
  String tagid;
  String goldType;
  String description;
  double amount;
  double grams;
  String address;
  String city;
  String postCode;
  double paidAmount;
  double paidGrams;
  String allotmentStatus;
  DateTime createdAt;
  DateTime updatedAt;

  UserCatalog({
    required this.id,
    required this.mobileNumber,
    required this.tagid,
    required this.goldType,
    required this.description,
    required this.amount,
    required this.grams,
    required this.address,
    required this.city,
    required this.postCode,
    required this.paidAmount,
    required this.paidGrams,
    required this.allotmentStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserCatalog.fromJson(Map<String, dynamic> json) {
    return UserCatalog(
      id: json['_id'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      tagid: json['tagid'] ?? '',
      goldType: json['goldType'] ?? '',
      description: json['description'] ?? '',
      amount: (json['amount']?.toDouble() ?? 0.0),
      grams: (json['grams']?.toDouble() ?? 0.0),
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      postCode: json['postCode'] ?? '',
      paidAmount: (json['Paidamount']?.toDouble() ?? 0.0),
      paidGrams: (json['Paidgrams']?.toDouble() ?? 0.0),
      allotmentStatus: json['allotmentStatus'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  static List<UserCatalog> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => UserCatalog.fromJson(json)).toList();
  }
}
