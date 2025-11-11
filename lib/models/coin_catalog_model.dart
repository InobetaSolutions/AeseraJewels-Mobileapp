import 'dart:convert';

/// ----------------------------
/// Product Model (Base Product)
/// ----------------------------
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
      goldtype: json['goldType']?.toString(),
      description: json['description']?.toString(),
      price: (json['amount'] ?? json['price'] ?? 0).toDouble(),
      grams: (json['grams'] ?? 0).toDouble(),
      image: json['image']?.toString(),
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

/// ----------------------------------------------------
/// Coin Catalog Payment Data (inside "data" object)
/// ----------------------------------------------------
class CoinCatalogPaymentData {
  final String? id;
  final String? mobileNumber;
  final String? tagid;
  final String? goldType;
  final String? description;
  final double? amount;
  final double? grams;
  final double? deductAmount;
  final double? paidAmount;
  final double? paidGrams;
  final double? totalBeforeDeduction;
  final double? finalTotal;
  final double? tax;
  final String? address;
  final String? city;
  final String? postCode;
  final String? paymentStatus;
  final String? allotmentStatus;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CoinCatalogPaymentData({
    this.id,
    this.mobileNumber,
    this.tagid,
    this.goldType,
    this.description,
    this.amount,
    this.grams,
    this.deductAmount,
    this.paidAmount,
    this.paidGrams,
    this.totalBeforeDeduction,
    this.finalTotal,
    this.tax,
    this.address,
    this.city,
    this.postCode,
    this.paymentStatus,
    this.allotmentStatus,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory CoinCatalogPaymentData.fromJson(Map<String, dynamic> json) {
    return CoinCatalogPaymentData(
      id: json['_id']?.toString(),
      mobileNumber: json['mobileNumber']?.toString(),
      tagid: json['tagid']?.toString(),
      goldType: json['goldType']?.toString(),
      description: json['description']?.toString(),
      amount: (json['amount'] ?? 0).toDouble(),
      grams: (json['grams'] ?? 0).toDouble(),
      deductAmount: (json['deductAmount'] ?? 0).toDouble(),
      paidAmount: (json['Paidamount'] ?? 0).toDouble(),
      paidGrams: (json['Paidgrams'] ?? 0).toDouble(),
      totalBeforeDeduction: (json['totalBeforeDeduction'] ?? 0).toDouble(),
      finalTotal: (json['finalTotal'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      address: json['address']?.toString(),
      city: json['city']?.toString(),
      postCode: json['postCode']?.toString(),
      paymentStatus: json['paymentStatus']?.toString(),
      allotmentStatus: json['allotmentStatus']?.toString(),
      v: json['__v'] is int ? json['__v'] : int.tryParse('${json['__v']}'),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "mobileNumber": mobileNumber,
        "tagid": tagid,
        "goldType": goldType,
        "description": description,
        "amount": amount,
        "grams": grams,
        "deductAmount": deductAmount,
        "Paidamount": paidAmount,
        "Paidgrams": paidGrams,
        "totalBeforeDeduction": totalBeforeDeduction,
        "finalTotal": finalTotal,
        "tax": tax,
        "address": address,
        "city": city,
        "postCode": postCode,
        "paymentStatus": paymentStatus,
        "allotmentStatus": allotmentStatus,
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

/// --------------------------------------------------------
/// Coin Catalog Payment Response (complete API structure)
/// --------------------------------------------------------
class CoinCatalogPaymentResponseModel {
  final bool status;
  final String? message;
  final CoinCatalogPaymentData? data;

  CoinCatalogPaymentResponseModel({
    required this.status,
    this.message,
    this.data,
  });

  factory CoinCatalogPaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return CoinCatalogPaymentResponseModel(
      status: json['status'] ?? false,
      message: json['message']?.toString(),
      data: json['data'] != null
          ? CoinCatalogPaymentData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };

  static CoinCatalogPaymentResponseModel fromRawJson(String str) =>
      CoinCatalogPaymentResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}


                                             // CatalogPaymentModel

class CatalogPaymentModel {
  String? mobileNumber;
  String? tagid;
  String? goldType;
  String? description;
  dynamic amount;
  dynamic paidAmount;
  dynamic WalletAmount;
  dynamic grams;
  String? address;
  String? city;
  String? postCode;
  dynamic taxAmount;
  dynamic deliveryCharge;
  String? paymentStatus;
  String? allotmentStatus;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  CatalogPaymentModel({
    this.mobileNumber,
    this.tagid,
    this.goldType,
    this.description,
    this.amount,
    this.paidAmount,
    this.WalletAmount,
    this.grams,
    this.address,
    this.city,
    this.postCode,
    this.taxAmount,
    this.deliveryCharge,
    this.paymentStatus,
    this.allotmentStatus,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CatalogPaymentModel.fromJson(Map<String, dynamic> json) {
    return CatalogPaymentModel(
      mobileNumber: json['mobileNumber'],
      tagid: json['tagid'],
      goldType: json['goldType'],
      description: json['description'],
      amount: json['amount'],
      paidAmount: json['Paidamount'],
      WalletAmount: json['WalletAmount'],
      grams: json['grams'],
      address: json['address'],
      city: json['city'],
      postCode: json['postCode'],
      taxAmount: json['taxAmount'],
      deliveryCharge: json['deliveryCharge'],
      paymentStatus: json['paymentStatus'],
      allotmentStatus: json['allotmentStatus'],
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mobileNumber': mobileNumber,
      'tagid': tagid,
      'goldType': goldType,
      'description': description,
      'amount': amount,
      'Paidamount': paidAmount,
      'WalletAmount': WalletAmount,
      'grams': grams,
      'address': address,
      'city': city,
      'postCode': postCode,
      'taxAmount': taxAmount,
      'deliveryCharge': deliveryCharge,
    };
  }
}