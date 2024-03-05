// To parse this JSON data, do
//
//     final walletModel = walletModelFromJson(jsonString);

import 'dart:convert';

List<WalletModel?> walletModelFromJson(List str) =>
    List<WalletModel?>.from(str.map((x) => WalletModel.fromJson(x)));

String walletModelToJson(List<WalletModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WalletModel {
  final String? id;
  final String? name;
  final String? type;
  final String? amountSum;
  final String? amountDollar;
  final bool? isActive;
  final String? status;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  WalletModel({
    this.id,
    this.name,
    this.type,
    this.amountSum,
    this.amountDollar,
    this.isActive,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        amountSum: json["amount_sum"],
        amountDollar: json["amount_dollar"],
        isActive: json["is_active"],
        status: json["status"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "amount_sum": amountSum,
        "amount_dollar": amountDollar,
        "is_active": isActive,
        "status": status,
        "deletedAt": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
