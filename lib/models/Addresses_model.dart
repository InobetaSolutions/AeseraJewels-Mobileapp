// lib/modules/address/address_model.dart
class AddressModel {
  final String id;
  final String userId;
  final String name;
  final String address;
  final String city;
  final String postalCode;

  AddressModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.address,
    required this.city,
    required this.postalCode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json["_id"] ?? "",
      userId: json["userid"] ?? "",
      name: json["name"] ?? "",
      address: json["address"] ?? "",
      city: json["city"] ?? "",
      postalCode: json["postalCode"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "userid": userId,
      "name": name,
      "address": address,
      "city": city,
      "postalCode": postalCode,
    };
  }
}
