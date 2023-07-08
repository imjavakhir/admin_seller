// To parse this JSON data, do
//
//     final clientInfo = clientInfoFromJson(jsonString);

import 'dart:convert';

List<ClientInfo> clientsInfoFromJson(List str) =>
    List<ClientInfo>.from(str.map((x) => ClientInfo.fromJson(x)));
ClientInfo clientInfoFromJson(String str) =>
    ClientInfo.fromJson(json.decode(str));

String clientInfoToJson(List<ClientInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClientInfo {
  final String? id;
  final String? details;
  final bool? isCanceled;
  final String? shared_seller;
  final bool? is_help;

  ClientInfo(
      {this.id,
      this.details,
      this.isCanceled,
      this.shared_seller,
      this.is_help});

  factory ClientInfo.fromJson(Map<String, dynamic> json) => ClientInfo(
      id: json["id"],
      details: json["details"],
      isCanceled: json["is_canceled"],
      shared_seller: json["shared_seller"],
      is_help: json["is_help"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "details": details,
        "is_canceled": isCanceled,
        "shared_seller": shared_seller,
        "is_help": is_help
      };
}

// To parse this JSON data, do
//
//     final clientInfo = clientInfoFromJson(jsonString);
