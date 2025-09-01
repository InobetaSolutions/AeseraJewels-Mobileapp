

/// Transaction model
class Transaction {
  final String id;
  final String mobile;
  final double amount;
  final double gold;
  final String status;
  final DateTime? timestamp;
  final String? tag;
  final String? address;

  Transaction({
    required this.id,
    required this.mobile,
    required this.amount,
    required this.gold,
    required this.status,
    this.timestamp,
    this.tag,
    this.address,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'] ?? '',
      mobile: json['mobile'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      gold: (json['gold'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'])
          : null,
      tag: json['tag'],
      address: json['address'],
    );
  }
}