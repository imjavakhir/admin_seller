// To parse this JSON data, do
//
//     final sellingMyOrders = sellingMyOrdersFromJson(jsonString);

import 'dart:convert';

List<SellingMyOrders?> sellingMyOrdersFromJson(List str) => List<SellingMyOrders?>.from(str.map((x) => SellingMyOrders.fromJson(x)));

String sellingMyOrdersToJson(List<SellingMyOrders> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SellingMyOrders {
    final String? id;
    final int? dealId;
    final String? rest;
    final bool? copied;
    final DateTime? deliveryDate;
    final bool? isActive;
    final String? status;
    final String? companyId;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? sellerId;
    final String? clientId;
    final SellerSelling? seller;
    final ClientSelling? client;
    final List<OrderSelling>? orders;

    SellingMyOrders({
        this.id,
        this.dealId,
        this.rest,
        this.copied,
        this.deliveryDate,
        this.isActive,
        this.status,
        this.companyId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.sellerId,
        this.clientId,
        this.seller,
        this.client,
        this.orders,
    });

    factory SellingMyOrders.fromJson(Map<String, dynamic> json) => SellingMyOrders(
        id: json["id"],
        dealId: json["deal_id"],
        rest: json["rest"],
        copied: json["copied"],
        deliveryDate: json["delivery_date"] == null ? null : DateTime.parse(json["delivery_date"]),
        isActive: json["is_active"],
        status: json["status"],
        companyId: json["company_id"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        sellerId: json["seller_id"],
        clientId: json["client_id"],
        seller: json["seller"] == null ? null : SellerSelling.fromJson(json["seller"]),
        client: json["client"] == null ? null : ClientSelling.fromJson(json["client"]),
        orders: json["orders"] == null ? [] : List<OrderSelling>.from(json["orders"]!.map((x) => OrderSelling.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "deal_id": dealId,
        "rest": rest,
        "copied": copied,
        "delivery_date": deliveryDate?.toIso8601String(),
        "is_active": isActive,
        "status": status,
        "company_id": companyId,
        "deletedAt": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "seller_id": sellerId,
        "client_id": clientId,
        "seller": seller?.toJson(),
        "client": client?.toJson(),
        "orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toJson())),
    };
}

class ClientSelling {
    final String? id;
    final String? name;
    final String? phone;
    final String? whereFrom;
    final String? status;
    final bool? isActive;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    ClientSelling({
        this.id,
        this.name,
        this.phone,
        this.whereFrom,
        this.status,
        this.isActive,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory ClientSelling.fromJson(Map<String, dynamic> json) => ClientSelling(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        whereFrom: json["where_from"],
        status: json["status"],
        isActive: json["is_active"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "where_from": whereFrom,
        "status": status,
        "is_active": isActive,
        "deletedAt": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class OrderSelling {
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

    OrderSelling({
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
    });

    factory OrderSelling.fromJson(Map<String, dynamic> json) => OrderSelling(
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
    };
}

class SellerSelling {
    final String? id;
    final String? name;
    final String? phone;
    final String? password;
    final String? companyId;
    final String? role;
    final bool? isActive;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? compId;

    SellerSelling({
        this.id,
        this.name,
        this.phone,
        this.password,
        this.companyId,
        this.role,
        this.isActive,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.compId,
    });

    factory SellerSelling.fromJson(Map<String, dynamic> json) => SellerSelling(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        password: json["password"],
        companyId: json["company_id"],
        role: json["role"],
        isActive: json["is_active"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        compId: json["comp_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "password": password,
        "company_id": companyId,
        "role": role,
        "is_active": isActive,
        "deletedAt": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "comp_id": compId,
    };
}
