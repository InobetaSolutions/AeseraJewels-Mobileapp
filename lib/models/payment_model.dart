class PaymentModel {
  final String mobile;
  final double amount;
  final String status;
  final String id;
  final DateTime timestamp;

  PaymentModel({
    required this.mobile,
    required this.amount,
    required this.status,
    required this.id,
    required this.timestamp,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      mobile: json['mobile'],
      amount: (json['amount'] as num).toDouble(),
      status: json['status'],
      id: json['_id'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
      'amount': amount,
      'status': status,
      '_id': id,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
