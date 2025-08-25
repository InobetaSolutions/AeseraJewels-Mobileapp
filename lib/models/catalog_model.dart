class ProductModel {
  final String id;
  final String tagId;
  final String goldtype;
  final String description;
  final double price;
  final String image;

  // Optional
  final double? originalPrice;

  ProductModel({
    required this.id,
    required this.tagId,
    required this.goldtype,
    required this.description,
    required this.price,
    required this.image,
    this.originalPrice,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] ?? '',
      tagId: json['tagId'] ?? '',
      goldtype: json['goldtype'] ?? '',
      description: json['description'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      image: json['image'] ?? '',
      originalPrice: json['originalPrice'] != null
          ? double.tryParse(json['originalPrice'].toString())
          : null,
    );
  }
}
