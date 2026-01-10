class SellModel {
  String? totalAmount;
  String? totalGrams;

  SellModel({this.totalAmount, this.totalGrams});

  factory SellModel.fromJson(Map<String, dynamic> json) {
    return SellModel(
      totalAmount: json["totalAmount"]?.toString() ?? "0",
      totalGrams: json["totalGrams"]?.toString() ?? "0",
    );
  }

  get paymentDate => null;
}

class SellPaymentResponse {
  final bool status;
  final String message;

  SellPaymentResponse({required this.status, required this.message});

  factory SellPaymentResponse.fromJson(Map<String, dynamic> json) {
    return SellPaymentResponse(
      status: json['message'] != null,
      message: json['message'] ?? '',
    );
  }
}


class TaxModel {
  final int percentage;

  TaxModel({required this.percentage});

  factory TaxModel.fromJson(Map<String, dynamic> json) {
    return TaxModel(
      percentage: json["data"]["percentage"],
    );
  }
}


class DeliveryChargeModel {
  final bool status;
  final String message;
  final int amount;

  DeliveryChargeModel({
    required this.status,
    required this.message,
    required this.amount,
  });

  factory DeliveryChargeModel.fromJson(Map<String, dynamic> json) {
    return DeliveryChargeModel(
      status: json["status"],
      message: json["message"],
      amount: json["data"]["amount"],
    );
  }
}


class PaymentGatewayModel {
  final int value;

  PaymentGatewayModel({required this.value});

  factory PaymentGatewayModel.fromJson(Map<String, dynamic> json) {
    return PaymentGatewayModel(
      value: json["paymentGatewayCharges"]["value"],
    );
  }
}



