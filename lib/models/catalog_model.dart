class ProductModel {
  final String id;
  final String tagId;
  final String goldtype;
  final String description;
  final double price;
  final String image;

  // Optional
  final double? originalPrice;
  final double? grams;

  ProductModel({
    required this.id,
    required this.tagId,
    required this.goldtype,
    required this.description,
    required this.price,
    required this.image,
    this.originalPrice,
    this.grams,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] ?? '',
      tagId: json['tagId'] ?? json['tagid'] ?? '',
      goldtype: json['goldtype'] ?? '',
      description: json['description'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      image: json['image'] ?? '',
      originalPrice: json['originalPrice'] != null
          ? double.tryParse(json['originalPrice'].toString())
          : null,
      grams: json['grams'] != null
          ? double.tryParse(json['grams'].toString())
          : null,
    );
  }
}


class CatalogPaymentModel {
  final String id;
  final String mobileNumber;
  final String tagid;
  final String goldType;
  final String description;
  final double amount;
  final double grams;
  final String address;
  final String city;
  final String postCode;
  final double paidAmount;
  final double paidGrams;
  final String allotmentStatus;

  CatalogPaymentModel({
    required this.id,
    required this.mobileNumber,
    required this.tagid,
    required this.goldType,
    required this.description,
    required this.amount,
    required this.grams,
    required this.address,
    required this.city,
    required this.postCode,
    required this.paidAmount,
    required this.paidGrams,
    required this.allotmentStatus,
  });

  factory CatalogPaymentModel.fromJson(Map<String, dynamic> json) {
    return CatalogPaymentModel(
      id: json["_id"] ?? "",
      mobileNumber: json["mobileNumber"] ?? "",
      tagid: json["tagid"] ?? "",
      goldType: json["goldType"] ?? "",
      description: json["description"] ?? "",
      amount: double.tryParse(json["amount"].toString()) ?? 0.0,
      grams: double.tryParse(json["grams"].toString()) ?? 0.0,
      address: json["address"] ?? "",
      city: json["city"] ?? "",
      postCode: json["postCode"] ?? "",
      paidAmount: double.tryParse(json["Paidamount"].toString()) ?? 0.0,
      paidGrams: double.tryParse(json["Paidgrams"].toString()) ?? 0.0,
      allotmentStatus: json["allotmentStatus"] ?? "",
    );
  }
}

