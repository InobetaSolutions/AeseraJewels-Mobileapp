class PaymentModel {
  final String mobile;
  final String others;
  final double amount;
  final double totalAmount;
  final String timestamp;
  final String status;
  final double gram;
  final double amountAllocated;
  final double gramAllocated;
  final String id;

  PaymentModel({
    required this.mobile,
    required this.others,
    required this.amount,
    required this.totalAmount,
    required this.timestamp,
    required this.status,
    required this.gram,
    required this.amountAllocated,
    required this.gramAllocated,
    required this.id,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      mobile: json['mobile'] ?? '',
      others: json['others'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      timestamp: json['timestamp'] ?? '',
      status: json['status'] ?? '',
      gram: (json['gram'] ?? 0).toDouble(),
      amountAllocated: (json['amount_allocated'] ?? 0).toDouble(),
      gramAllocated: (json['gram_allocated'] ?? 0).toDouble(),
      id: json['_id'] ?? '',
    );
  }
}
