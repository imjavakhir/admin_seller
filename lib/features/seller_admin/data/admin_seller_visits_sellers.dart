// To parse this JSON data, do
//
//     final adminSellerVisitSellers = adminSellerVisitSellersFromJson(jsonString);

import 'dart:convert';

List<AdminSellerVisitSellers?> adminSellerVisitSellersFromJson(List str) => List<AdminSellerVisitSellers?>.from(str.map((x) => AdminSellerVisitSellers.fromJson(x)));

String adminSellerVisitSellersToJson(List<AdminSellerVisitSellers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminSellerVisitSellers {
    final String? id;
    final String? fullname;
    final String? phoneNumber;
    final bool? isCanceled;
    final bool? isAccepted;
    final bool? isTimeout;

    AdminSellerVisitSellers({
        this.id,
        this.fullname,
        this.phoneNumber,
        this.isCanceled,
        this.isAccepted,
        this.isTimeout,
    });

    factory AdminSellerVisitSellers.fromJson(Map<String, dynamic> json) => AdminSellerVisitSellers(
        id: json["_id"],
        fullname: json["fullname"],
        phoneNumber: json["phone_number"],
        isCanceled: json["is_canceled"],
        isAccepted: json["is_accepted"],
        isTimeout: json["is_timeout"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fullname": fullname,
        "phone_number": phoneNumber,
        "is_canceled": isCanceled,
        "is_accepted": isAccepted,
        "is_timeout": isTimeout,
    };
}
