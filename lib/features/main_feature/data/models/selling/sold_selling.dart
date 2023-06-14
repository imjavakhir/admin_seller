// To parse this JSON data, do
//
//     final soldSelling = soldSellingFromJson(jsonString);

import 'dart:convert';

SoldSelling soldSellingFromJson(String str) => SoldSelling.fromJson(json.decode(str));

String soldSellingToJson(SoldSelling data) => json.encode(data.toJson());

class SoldSelling {
    final bool isEmpty;
    final String details;
    final String customer;
    final String seller;
    final String branch;
    final bool isSold;
    final int sellingPrice;
    final String id;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    SoldSelling({
        required this.isEmpty,
        required this.details,
        required this.customer,
        required this.seller,
        required this.branch,
        required this.isSold,
        required this.sellingPrice,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory SoldSelling.fromJson(Map<String, dynamic> json) => SoldSelling(
        isEmpty: json["is_empty"],
        details: json["details"],
        customer: json["customer"],
        seller: json["seller"],
        branch: json["branch"],
        isSold: json["is_sold"],
        sellingPrice: json["selling_price"],
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
        "selling_price": sellingPrice,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
