// To parse this JSON data, do
//
//     final furnitureModelTypeModel = furnitureModelTypeModelFromJson(jsonString);

import 'package:admin_seller/app_const/app_exports.dart';

List<FurnitureModelTypeModel?> furnitureModelTypeModelFromJson(List str) =>
    List<FurnitureModelTypeModel?>.from(
        str.map((x) => FurnitureModelTypeModel.fromJson(x)));

String furnitureModelTypeModelToJson(List<FurnitureModelTypeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FurnitureModelTypeModel {
  final String? id;
  final String? name;
  final String? price;
  final dynamic sale;
  final dynamic code;
  final bool? isActive;
  final String? companyId;
  final String? status;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? typeId;
  final FurnitureType? furnitureType;

  FurnitureModelTypeModel({
    this.id,
    this.name,
    this.price,
    this.sale,
    this.code,
    this.isActive,
    this.companyId,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.typeId,
    this.furnitureType,
  });

  factory FurnitureModelTypeModel.fromJson(Map<String, dynamic> json) =>
      FurnitureModelTypeModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        sale: json["sale"],
        code: json["code"],
        isActive: json["is_active"],
        companyId: json["company_id"],
        status: json["status"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        typeId: json["type_id"],
        furnitureType: json["furniture_type"] == null
            ? null
            : FurnitureType.fromJson(json["furniture_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "sale": sale,
        "code": code,
        "is_active": isActive,
        "company_id": companyId,
        "status": status,
        "deletedAt": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "type_id": typeId,
        "furniture_type": furnitureType?.toJson(),
      };
}

class FurnitureType {
  final String? id;
  final String? name;

  FurnitureType({
    this.id,
    this.name,
  });

  factory FurnitureType.fromJson(Map<String, dynamic> json) => FurnitureType(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
