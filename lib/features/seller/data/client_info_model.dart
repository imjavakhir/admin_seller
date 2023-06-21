// To parse this JSON data, do
//
//     final clientInfo = clientInfoFromJson(jsonString);

import 'dart:convert';


List<ClientInfo> clientsInfoFromJson(List str) => List<ClientInfo>.from(str.map((x) => ClientInfo.fromJson(x)));
ClientInfo clientInfoFromJson(String str) => ClientInfo.fromJson(json.decode(str));

String clientInfoToJson(List<ClientInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ClientInfo {
  final String? id;
  final String? details;
  final bool? isCanceled;

  ClientInfo({
    this.id,
    this.details,
    this.isCanceled,
  });

  factory ClientInfo.fromJson(Map<String, dynamic> json) => ClientInfo(
        id: json["id"],
        details: json["details"],
        isCanceled: json["is_canceled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "details": details,
        "is_canceled": isCanceled,
      };
}
