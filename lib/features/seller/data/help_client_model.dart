// To parse this JSON data, do
//
//     final helpClientInfo = helpClientInfoFromJson(jsonString);

import 'dart:convert';

import 'package:admin_seller/features/seller/data/client_info_model.dart';

List<HelpClientInfo> helpClientsInfoFromJson(List str) =>
    List<HelpClientInfo>.from(str.map((x) => HelpClientInfo.fromJson(x)));
HelpClientInfo helpClientInfoFromJson(String str) =>
    HelpClientInfo.fromJson(json.decode(str));
String helpClientInfoToJson(List<HelpClientInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HelpClientInfo {
  final ClientInfo? notification;
  final SharedSeller? sharedSeller;
  final bool? isAccepted;
  final bool? isCanceled;

  HelpClientInfo({
    this.notification,
    this.sharedSeller,
    this.isAccepted,
    this.isCanceled,
  });

  factory HelpClientInfo.fromJson(Map<String, dynamic> json) => HelpClientInfo(
        notification: json["notification"] == null
            ? null
            : ClientInfo.fromJson(json["notification"]),
        sharedSeller: json["shared_seller"] == null
            ? null
            : SharedSeller.fromJson(json["shared_seller"]),
        isAccepted: json["is_accepted"],
        isCanceled: json["is_canceled"],
      );

  Map<String, dynamic> toJson() => {
        "notification": notification?.toJson(),
        "shared_seller": sharedSeller?.toJson(),
        "is_accepted": isAccepted,
        "is_canceled": isCanceled,
      };
}

class SharedSeller {
  final String? id;
  final String? fullname;

  SharedSeller({
    this.id,
    this.fullname,
  });

  factory SharedSeller.fromJson(Map<String, dynamic> json) => SharedSeller(
        id: json["id"],
        fullname: json["fullname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
      };
}
