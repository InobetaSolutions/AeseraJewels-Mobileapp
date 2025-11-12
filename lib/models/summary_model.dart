
class SummaryModel {
  final double goldRate;
  final double goldQuantity;
  final double goldValue;
  final double gst; // taxAmount %
  final double amountPayable; // totalPayAmountWithTax

  // ✅ New Parameters
  final double taxAmount;
  final double deliveryCharge;
  final double totalWithTax;

  // ✅ Extra fields for new UI
  final String textSummary;
  final List<String> offers;
  final String coupons;
  final String timer;

  SummaryModel({
    required this.goldRate,
    required this.goldQuantity,
    required this.goldValue,
    required this.gst,
    required this.amountPayable,
    required this.taxAmount,
    required this.deliveryCharge,
    required this.totalWithTax,
    this.textSummary = "",
    this.offers = const [],
    this.coupons = "",
    this.timer = "",
  });

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    return SummaryModel(
      goldRate: (json['goldRate'] ?? 0).toDouble(),
      goldQuantity: (json['gram_allocated'] ?? 0).toDouble(),
      goldValue: (json['amount'] ?? 0).toDouble(),
      gst: (json['taxAmount'] ?? 0).toDouble(),
      amountPayable: (json['totalPayAmountWithTax'] ?? 0).toDouble(),
      taxAmount: (json['taxAmount'] ?? 0).toDouble(),
      deliveryCharge: (json['deliveryCharge'] ?? 0).toDouble(),
      totalWithTax: (json['totalWithTax'] ?? 0).toDouble(),
      textSummary: json['textSummary'] ?? "",
      offers: List<String>.from(json['offers'] ?? []),
      coupons: json['coupons'] ?? "",
      timer: json['timer'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "goldRate": goldRate,
      "goldQuantity": goldQuantity,
      "goldValue": goldValue,
      "gst": gst,
      "amountPayable": amountPayable,
      "taxAmount": taxAmount,
      "deliveryCharge": deliveryCharge,
      "totalWithTax": totalWithTax,
      "textSummary": textSummary,
      "offers": offers,
      "coupons": coupons,
      "timer": timer,
    };
  }
}
