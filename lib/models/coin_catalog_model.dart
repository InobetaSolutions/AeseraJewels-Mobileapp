class ProductModel {
  final String? tagId;
  final String? goldtype;
  final String? description;
  final double price;
  final double? grams;
  final String? image;

  ProductModel({
    this.tagId,
    this.goldtype,
    this.description,
    required this.price,
    this.grams,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      tagId: json['tagid']?.toString(),
      goldtype: json['goldType'],
      description: json['description'],
      price: (json['price'] ?? 0).toDouble(),
      grams: (json['grams'] ?? 0).toDouble(),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        "tagid": tagId,
        "goldType": goldtype,
        "description": description,
        "price": price,
        "grams": grams,
        "image": image,
      };
}
