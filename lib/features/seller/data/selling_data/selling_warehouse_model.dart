// To parse this JSON data, do
//
//     final sellingWarehouseModel = sellingWarehouseModelFromJson(jsonString);

import 'dart:convert';

SellingWarehouseModel sellingWarehouseModelFromJson(String str) => SellingWarehouseModel.fromJson(json.decode(str));

String sellingWarehouseModelToJson(SellingWarehouseModel data) => json.encode(data.toJson());

class SellingWarehouseModel {
    final int? totalAmount;
    final List<Product>? products;

    SellingWarehouseModel({
        this.totalAmount,
        this.products,
    });

    factory SellingWarehouseModel.fromJson(Map<String, dynamic> json) => SellingWarehouseModel(
        totalAmount: json["totalAmount"],
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalAmount": totalAmount,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    };
}

class Product {
    final String? id;
    final String? orderId;
    final String? warehouseId;
    final bool? isActive;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Warehouse? warehouse;
    final Order? order;

    Product({
        this.id,
        this.orderId,
        this.warehouseId,
        this.isActive,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.warehouse,
        this.order,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        orderId: json["order_id"],
        warehouseId: json["warehouse_id"],
        isActive: json["is_active"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        warehouse: json["warehouse"] == null ? null : Warehouse.fromJson(json["warehouse"]),
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "warehouse_id": warehouseId,
        "is_active": isActive,
        "deletedAt": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "warehouse": warehouse?.toJson(),
        "order": order?.toJson(),
    };
}

class Order {
    final String? id;
    final String? orderId;
    final String? cathegory;
    final String? tissue;
    final String? title;
    final String? cost;
    final String? sale;
    final int? qty;
    final String? sum;
    final bool? isFirst;
    final bool? copied;
    final String? status;
    final bool? isActive;
    final DateTime? endDate;
    final String? sellerId;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? dealId;
    final String? modelId;
    final Model? model;
    final bool? canChange;

    Order({
        this.id,
        this.orderId,
        this.cathegory,
        this.tissue,
        this.title,
        this.cost,
        this.sale,
        this.qty,
        this.sum,
        this.isFirst,
        this.copied,
        this.status,
        this.isActive,
        this.endDate,
        this.sellerId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.dealId,
        this.modelId,
        this.model,
        this.canChange,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        orderId: json["order_id"],
        cathegory: json["cathegory"],
        tissue: json["tissue"],
        title: json["title"],
        cost: json["cost"],
        sale: json["sale"],
        qty: json["qty"],
        sum: json["sum"],
        isFirst: json["is_first"],
        copied: json["copied"],
        status: json["status"],
        isActive: json["is_active"],
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        sellerId: json["seller_id"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        dealId: json["deal_id"],
        modelId: json["model_id"],
        model: json["model"] == null ? null : Model.fromJson(json["model"]),
        canChange: json["can_change"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "cathegory": cathegory,
        "tissue": tissue,
        "title": title,
        "cost": cost,
        "sale": sale,
        "qty": qty,
        "sum": sum,
        "is_first": isFirst,
        "copied": copied,
        "status": status,
        "is_active": isActive,
        "end_date": endDate?.toIso8601String(),
        "seller_id": sellerId,
        "deletedAt": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deal_id": dealId,
        "model_id": modelId,
        "model": model?.toJson(),
        "can_change": canChange,
    };
}

class Model {
    final String? id;
    final String? name;
    final Warehouse? furnitureType;

    Model({
        this.id,
        this.name,
        this.furnitureType,
    });

    factory Model.fromJson(Map<String, dynamic> json) => Model(
        id: json["id"],
        name: json["name"],
        furnitureType: json["furniture_type"] == null ? null : Warehouse.fromJson(json["furniture_type"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "furniture_type": furnitureType?.toJson(),
    };
}

class Warehouse {
    final String? id;
    final String? name;

    Warehouse({
        this.id,
        this.name,
    });

    factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
