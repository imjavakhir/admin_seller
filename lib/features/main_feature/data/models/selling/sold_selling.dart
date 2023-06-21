// To parse this JSON data, do
//
//     final soldSelling = soldSellingFromJson(jsonString);

import 'dart:convert';

SoldSelling soldSellingFromJson(String str) => SoldSelling.fromJson(json.decode(str));

String soldSellingToJson(SoldSelling data) => json.encode(data.toJson());

class SoldSelling {
    final bool? isEmpty;
    final String? details;
    final String? customer;
    final String? seller;
    final String? branch;
    final bool? isSold;
    final int? sellingPrice;
    final String? dataStatus;
    final String? whereComeFrom;
    final String? id;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    SoldSelling({
        this.isEmpty,
        this.details,
        this.customer,
        this.seller,
        this.branch,
        this.isSold,
        this.sellingPrice,
        this.dataStatus,
        this.whereComeFrom,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory SoldSelling.fromJson(Map<String, dynamic> json) => SoldSelling(
        isEmpty: json["is_empty"],
        details: json["details"],
        customer: json["customer"],
        seller: json["seller"],
        branch: json["branch"],
        isSold: json["is_sold"],
        sellingPrice: json["selling_price"],
        dataStatus: json["data_status"],
        whereComeFrom: json["where_come_from"],
        id: json["_id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
        "data_status": dataStatus,
        "where_come_from": whereComeFrom,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
