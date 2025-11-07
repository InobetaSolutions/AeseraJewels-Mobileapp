// models/gold_coin_payment_model.dart
class GoldCoinPaymentModel {
  final String? mobileNumber;
  final List<CoinItem> items;
  final double totalAmount;
  final double taxAmount;
  final double deliveryCharge;
  final double amountPayable;
  final double investAmount;
  final String? address;
  final String? city;
  final String? postCode;
  final String? status;

  GoldCoinPaymentModel({
    this.mobileNumber,
    required this.items,
    required this.totalAmount,
    required this.taxAmount,
    required this.deliveryCharge,
    required this.amountPayable,
    required this.investAmount,
    this.address,
    this.city,
    this.postCode,
    this.status,
  });

  factory GoldCoinPaymentModel.fromJson(Map<String, dynamic> json) {
    return GoldCoinPaymentModel(
      mobileNumber: json['mobileNumber'],
      items: (json['items'] as List? ?? [])
          .map((item) => CoinItem.fromJson(item))
          .toList(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      taxAmount: (json['taxAmount'] ?? 0).toDouble(),
      deliveryCharge: (json['deliveryCharge'] ?? 0).toDouble(),
      amountPayable: (json['amountPayable'] ?? 0).toDouble(),
      investAmount: (json['investAmount'] ?? 0).toDouble(),
      address: json['address'],
      city: json['city'],
      postCode: json['postCode'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mobileNumber': mobileNumber,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'taxAmount': taxAmount,
      'deliveryCharge': deliveryCharge,
      'amountPayable': amountPayable,
      'investAmount': investAmount,
      'address': address,
      'city': city,
      'postCode': postCode,
    };
  }
}

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

  Map<String, dynamic> toJson() {
    return {
      'coinGrams': coinGrams,
      'quantity': quantity,
      'amount': amount,
    };
  }
}

class CatalogPaymentResponse {
  final bool status;
  final String message;
  final GoldCoinPaymentModel? data;

  CatalogPaymentResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory CatalogPaymentResponse.fromJson(Map<String, dynamic> json) {
    return CatalogPaymentResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? GoldCoinPaymentModel.fromJson(json['data'])
          : null,
    );
  }
}