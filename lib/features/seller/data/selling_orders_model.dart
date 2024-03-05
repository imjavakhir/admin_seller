// To parse this JSON data, do
//
//     final sellingOrderWihoutId = sellingOrderWihoutIdFromJson(jsonString);

import 'dart:convert';

SellingOrderWihoutId sellingOrderWihoutIdFromJson(String str) =>
    SellingOrderWihoutId.fromJson(json.decode(str));

String sellingOrderWihoutIdToJson(SellingOrderWihoutId data) =>
    json.encode(data.toJson());

class SellingOrderWihoutId {
  final String? model;
  final String? tissue;
  final String? title;
  final int? price;
  final double? sale;
  final int? qty;
  final int? sum;
  final String? cathegory;

  SellingOrderWihoutId({
    this.model,
    this.tissue,
    this.title,
    this.price,
    this.sale,
    this.qty,
    this.sum,
    this.cathegory,
  });

  factory SellingOrderWihoutId.fromJson(Map<String, dynamic> json) =>
      SellingOrderWihoutId(
        model: json["model"],
        tissue: json["tissue"],
        title: json["title"],
        price: json["price"],
        sale: json["sale"],
        qty: json["qty"],
        sum: json["sum"],
        cathegory: json["cathegory"],
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "tissue": tissue,
        "title": title,
        "price": price,
        "sale": sale,
        "qty": qty,
        "sum": sum,
        "cathegory": cathegory,
      };
}

SellingOrdersWithId sellingOrdersWithIdFromJson(String str) =>
    SellingOrdersWithId.fromJson(json.decode(str));

String sellingOrdersWithIdToJson(SellingOrdersWithId data) =>
    json.encode(data.toJson());

class SellingOrdersWithId {
  final String? id;
  final String? orderId;
  final String? model;
  final String? tissue;
  final String? title;
  final int? price;
  final double? sale;
  final int? qty;
  final int? sum;
  final String? cathegory;

  SellingOrdersWithId({
    this.id,
    this.orderId,
    this.model,
    this.tissue,
    this.title,
    this.price,
    this.sale,
    this.qty,
    this.sum,
    this.cathegory,
  });

  factory SellingOrdersWithId.fromJson(Map<String, dynamic> json) =>
      SellingOrdersWithId(
        id: json["id"],
        orderId: json["orderId"],
        model: json["model"],
        tissue: json["tissue"],
        title: json["title"],
        price: json["price"],
        sale: json["sale"],
        qty: json["qty"],
        sum: json["sum"],
        cathegory: json["cathegory"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderId": orderId,
        "model": model,
        "tissue": tissue,
        "title": title,
        "price": price,
        "sale": sale,
        "qty": qty,
        "sum": sum,
        "cathegory": cathegory,
      };
}

SellingFormData sellingFormDataFromJson(String str) =>
    SellingFormData.fromJson(json.decode(str));

String sellingFormDataToJson(SellingFormData data) =>
    json.encode(data.toJson());

class SellingFormData {
  final String? id;
  final String? clientName;
  final String? phone;
  final String? whereFrom;
  final String? status;
  final DateTime? deliveryDate;

  SellingFormData({
    this.id,
    this.clientName,
    this.phone,
    this.whereFrom,
    this.status,
    this.deliveryDate,
  });

  factory SellingFormData.fromJson(Map<String, dynamic> json) =>
      SellingFormData(
        id: json["id"],
        clientName: json["clientName"],
        phone: json["phone"],
        whereFrom: json["whereFrom"],
        status: json["status"],
        deliveryDate: json["deliveryDate"] == null
            ? null
            : DateTime.parse(json["deliveryDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clientName": clientName,
        "phone": phone,
        "whereFrom": whereFrom,
        "status": status,
        "deliveryDate": deliveryDate?.toIso8601String(),
      };
}

SellingPaymentData sellingPaymentDataFromJson(String str) =>
    SellingPaymentData.fromJson(json.decode(str));

String sellingPaymentDataToJson(SellingPaymentData data) =>
    json.encode(data.toJson());

class SellingPaymentData {
  final int? id;
  final String? paymentType;
  final int? paymentSum;
  final int? payment;
  final int? kurs;
  final int? amountByKurs;
  final int? change;
  final int? totalSum;

  final String? walletId;

  SellingPaymentData({
    this.id,
    this.paymentType,
    this.paymentSum,
    this.payment,
    this.kurs,
    this.amountByKurs,
    this.change,
    this.totalSum,
    this.walletId,
  });

  factory SellingPaymentData.fromJson(Map<String, dynamic> json) =>
      SellingPaymentData(
        id: json["id"],
        paymentType: json["payment_type"],
        paymentSum: json["payment_sum"],
        payment: json["payment_\u0024"],
        kurs: json["kurs"],
        amountByKurs: json["amount_by_kurs"],
        change: json["change"],
        totalSum: json["total_sum"],
        walletId: json["wallet_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "payment_type": paymentType,
        "payment_sum": paymentSum,
        "payment_\u0024": payment,
        "kurs": kurs,
        "amount_by_kurs": amountByKurs,
        "change": change,
        "total_sum": totalSum,
        "wallet_id": walletId,
      };
}
