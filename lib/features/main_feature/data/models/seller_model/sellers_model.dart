// To parse this JSON data, do
//
//     final seller = sellerFromJson(jsonString);

import 'package:admin_seller/app_const/app_exports.dart';


List<Sellers?> sellerFromJson(List str) =>
    List<Sellers?>.from(str.map((x) => Sellers.fromJson(x)));

String sellerToJson(List<Sellers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sellers {
  final String? id;
  final String? fullname;
  final String? phoneNumber;

  Sellers({
    required this.id,
    required this.fullname,
    required this.phoneNumber,
  });

  factory Sellers.fromJson(Map<String, dynamic> json) => Sellers(
        id: json["_id"],
        fullname: json["fullname"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullname": fullname,
        "phone_number": phoneNumber,
      };
}
