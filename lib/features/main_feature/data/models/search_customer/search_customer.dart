// To parse this JSON data, do
//
//     final searchedCustomer = searchedCustomerFromJson(jsonString);

import 'dart:convert';

List<SearchedCustomer?> searchedCustomerFromJson(List str) =>
    List<SearchedCustomer?>.from(str.map((x) => SearchedCustomer.fromJson(x)));

String searchedCustomerToJson(List<SearchedCustomer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchedCustomer {
  final String id;
  final String fullname;
  final String? phoneNumber;
  final int v;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SearchedCustomer({
    required this.id,
    required this.fullname,
    required this.phoneNumber,
    required this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory SearchedCustomer.fromJson(Map<String, dynamic> json) =>
      SearchedCustomer(
        id: json["_id"],
        fullname: json["fullname"],
        phoneNumber: json["phone_number"],
        v: json["__v"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullname": fullname,
        "phone_number": phoneNumber,
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
