// To parse this JSON data, do
//
//     final emptySelling = emptySellingFromJson(jsonString);

import 'dart:convert';

EmptySelling emptySellingFromJson(String str) => EmptySelling.fromJson(json.decode(str));

String emptySellingToJson(EmptySelling data) => json.encode(data.toJson());

class EmptySelling {
    final bool? isEmpty;
    final String? seller;
    final String? branch;
    final bool? isSold;
    final String? dataStatus;
    final String? whereComeFrom;
    final String? id;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    EmptySelling({
        this.isEmpty,
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

    factory EmptySelling.fromJson(Map<String, dynamic> json) => EmptySelling(
        isEmpty: json["is_empty"],
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
