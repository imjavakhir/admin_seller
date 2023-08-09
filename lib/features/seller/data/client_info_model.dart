// To parse this JSON data, do
//
//     final clientInfo = clientInfoFromJson(jsonString);

import 'dart:convert';

List<ClientInfo> clientsInfoFromJson(List str) =>
    List<ClientInfo>.from(str.map((x) => ClientInfo.fromJson(x)));

String clientInfoToJson(List<ClientInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClientInfo {
  final String? id;
  final String? details;
  final bool? isCanceled;
  final bool? isAccepted;
  final int? sentAt;

  ClientInfo({
    this.id,
    this.details,
    this.isCanceled,
    this.isAccepted,
    this.sentAt,
  });

  factory ClientInfo.fromJson(Map<String, dynamic> json) => ClientInfo(
        id: json["_id"],
        details: json["details"],
        isCanceled: json["is_canceled"],
        isAccepted: json["is_accepted"],
        sentAt: json["sent_at"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "details": details,
        "is_canceled": isCanceled,
        "is_accepted": isAccepted,
        "sent_at": sentAt,
      };
}

// To parse this JSON data, do
//
//     final clientInfo = clientInfoFromJson(jsonString);

List<HelpClientInfo> helpclientsInfoFromJson(List str) =>
    List<HelpClientInfo>.from(str.map((x) => HelpClientInfo.fromJson(x)));
HelpClientInfo helpclientInfoFromJson(String str) =>
    HelpClientInfo.fromJson(json.decode(str));

String helpclientInfoToJson(List<HelpClientInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HelpClientInfo {
  final String? id;
  final String? details;

  final String? fullname;

  HelpClientInfo({this.id, this.details, this.fullname});

  factory HelpClientInfo.fromJson(Map<String, dynamic> json) => HelpClientInfo(
      id: json["id"], details: json["details"], fullname: json["fullname"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "details": details, "fullname": fullname};
}
