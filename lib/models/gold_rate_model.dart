class GoldRateModel {
  final String id;
  final int timestamp;
  final double priceGram24k;
  final String istDate;

  GoldRateModel({
    required this.id,
    required this.timestamp,
    required this.priceGram24k,
    required this.istDate,
  });

  factory GoldRateModel.fromJson(Map<String, dynamic> json) {
    return GoldRateModel(
      id: json['_id'] ?? '',
      timestamp: json['timestamp'] ?? 0,
      priceGram24k: (json['price_gram_24k'] ?? 0).toDouble(),
      istDate: json['istDate'] ?? '',
    );
  }

double get rate => priceGram24k;
 
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'timestamp': timestamp,
      'price_gram_24k': priceGram24k,
      'istDate': istDate,
    };
  }
}
