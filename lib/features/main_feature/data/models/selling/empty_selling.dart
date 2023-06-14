// To parse this JSON data, do
//
//     final emptySelling = emptySellingFromJson(jsonString);

import 'dart:convert';

EmptySelling emptySellingFromJson(String str) =>
    EmptySelling.fromJson(json.decode(str));

String emptySellingToJson(EmptySelling data) => json.encode(data.toJson());

class EmptySelling {
  final bool isEmpty;
  final String seller;
  final String branch;
  final bool isSold;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  EmptySelling({
    required this.isEmpty,
    required this.seller,
    required this.branch,
    required this.isSold,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory EmptySelling.fromJson(Map<String, dynamic> json) => EmptySelling(
        isEmpty: json["is_empty"],
        seller: json["seller"],
        branch: json["branch"],
        isSold: json["is_sold"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "is_empty": isEmpty,
        "seller": seller,
        "branch": branch,
        "is_sold": isSold,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
