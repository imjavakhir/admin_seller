// To parse this JSON data, do
//
//     final adminVisitsInfo = adminVisitsInfoFromJson(jsonString);

import 'dart:convert';

List<AdminVisitsInfo> adminVisitsInfoFromJson(List str) => List<AdminVisitsInfo>.from(str.map((x) => AdminVisitsInfo.fromJson(x)));

String adminVisitsInfoToJson(List<AdminVisitsInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminVisitsInfo {
    final String? id;
    final String? details;
    final SellerAd? seller;
    final bool? isAccepted;
    final bool? isCanceled;
    final bool? isTimeout;
    final bool? isStored;
    final DateTime? createdAt;

    AdminVisitsInfo({
        this.id,
        this.details,
        this.seller,
        this.isAccepted,
        this.isCanceled,
        this.isTimeout,
        this.isStored,
        this.createdAt,
    });

    factory AdminVisitsInfo.fromJson(Map<String, dynamic> json) => AdminVisitsInfo(
        id: json["_id"],
        details: json["details"],
        seller: json["seller"] == null ? null : SellerAd.fromJson(json["seller"]),
        isAccepted: json["is_accepted"],
        isCanceled: json["is_canceled"],
        isTimeout: json["is_timeout"],
        isStored: json["is_stored"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "details": details,
        "seller": seller?.toJson(),
        "is_accepted": isAccepted,
        "is_canceled": isCanceled,
        "is_timeout": isTimeout,
        "is_stored": isStored,
        "createdAt": createdAt?.toIso8601String(),
    };
}

class SellerAd {
    final String? id;
    final String? fullname;
    final String? phoneNumber;

    SellerAd({
        this.id,
        this.fullname,
        this.phoneNumber,
    });

    factory SellerAd.fromJson(Map<String, dynamic> json) => SellerAd(
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
