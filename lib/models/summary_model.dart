
class SummaryModel {
  final double goldRate;
  final double goldQuantity;
  final double goldValue;
  final double gst; // taxAmount % 
  final double amountPayable; // totalPayAmountWithTax

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
      gst: ((json['taxAmount'] ?? 0).toDouble()), // renamed taxAmount → gst
      amountPayable: (json['totalPayAmountWithTax'] ?? 0).toDouble(), // renamed
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
      "textSummary": textSummary,
      "offers": offers,
      "coupons": coupons,
      "timer": timer,
    };
  }
}
