// To parse this JSON data, do
//
//     final notSoldSelling = notSoldSellingFromJson(jsonString);

import 'dart:convert';

NotSoldSelling notSoldSellingFromJson(String str) => NotSoldSelling.fromJson(json.decode(str));

String notSoldSellingToJson(NotSoldSelling data) => json.encode(data.toJson());

class NotSoldSelling {
    final bool? isEmpty;
    final String? details;
    final String? customer;
    final String? seller;
    final String? branch;
    final bool? isSold;
    final String? dataStatus;
    final String? whereComeFrom;
    final String? id;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    NotSoldSelling({
        this.isEmpty,
        this.details,
        this.customer,
        this.seller,
        this.branch,
        this.isSold,
        this.dataStatus,
        this.whereComeFrom,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory NotSoldSelling.fromJson(Map<String, dynamic> json) => NotSoldSelling(
        isEmpty: json["is_empty"],
        details: json["details"],
        customer: json["customer"],
        seller: json["seller"],
        branch: json["branch"],
        isSold: json["is_sold"],
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
        "data_status": dataStatus,
        "where_come_from": whereComeFrom,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
