import 'dart:convert';

List<SearchedCustomers?> searchedCustomersFromJson(List str) =>
    List<SearchedCustomers>.from(str.map((x) => SearchedCustomers.fromJson(x)));

String searchedCustomersToJson(List<SearchedCustomers?> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x!.toJson())));

class SearchedCustomers {
  final String? id;
  final bool? isEmpty;
  final String? details;
  final Customer? customer;
  final String? seller;
  final String? branch;
  final bool? isSold;
  final int? sellingPrice;
  final String? dataStatus;
  final String? whereComeFrom;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  SearchedCustomers({
    this.id,
    this.isEmpty,
    this.details,
    this.customer,
    this.seller,
    this.branch,
    this.isSold,
    this.sellingPrice,
    this.dataStatus,
    this.whereComeFrom,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SearchedCustomers.fromJson(Map<String, dynamic> json) =>
      SearchedCustomers(
        id: json["_id"],
        isEmpty: json["is_empty"],
        details: json["details"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        seller: json["seller"],
        branch: json["branch"],
        isSold: json["is_sold"],
        sellingPrice: json["selling_price"],
        dataStatus: json["data_status"],
        whereComeFrom: json["where_come_from"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "is_empty": isEmpty,
        "details": details,
        "customer": customer?.toJson(),
        "seller": seller,
        "branch": branch,
        "is_sold": isSold,
        "selling_price": sellingPrice,
        "data_status": dataStatus,
        "where_come_from": whereComeFrom,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Customer {
  final String? id;
  final String? fullname;
  final String? phoneNumber;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Customer({
    this.id,
    this.fullname,
    this.phoneNumber,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["_id"],
        fullname: json["fullname"],
        phoneNumber: json["phone_number"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullname": fullname,
        "phone_number": phoneNumber,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
