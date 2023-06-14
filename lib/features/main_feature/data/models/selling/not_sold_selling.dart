// To parse this JSON data, do
//
//     final notSoldSelling = notSoldSellingFromJson(jsonString);

import 'dart:convert';

NotSoldSelling notSoldSellingFromJson(String str) => NotSoldSelling.fromJson(json.decode(str));

String notSoldSellingToJson(NotSoldSelling data) => json.encode(data.toJson());

class NotSoldSelling {
    final bool isEmpty;
    final String details;
    final String customer;
    final String seller;
    final String branch;
    final bool isSold;
    final String id;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    NotSoldSelling({
        required this.isEmpty,
        required this.details,
        required this.customer,
        required this.seller,
        required this.branch,
        required this.isSold,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory NotSoldSelling.fromJson(Map<String, dynamic> json) => NotSoldSelling(
        isEmpty: json["is_empty"],
        details: json["details"],
        customer: json["customer"],
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
        "details": details,
        "customer": customer,
        "seller": seller,
        "branch": branch,
        "is_sold": isSold,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
