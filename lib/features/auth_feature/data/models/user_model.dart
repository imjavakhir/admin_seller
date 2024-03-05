// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final Selling? selling;
  final String? token;
  final String? fullname;
  final String? type;
  final String? branch;
  final String? firebase;

  UserModel({
    this.selling,
    this.token,
    this.fullname,
    this.type,
    this.branch,
    this.firebase,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        selling:
            json["selling"] == null ? null : Selling.fromJson(json["selling"]),
        token: json["token"],
        fullname: json["fullname"],
        type: json["type"],
        branch: json["branch"],
        firebase: json["firebase"],
      );

  Map<String, dynamic> toJson() => {
        "selling": selling?.toJson(),
        "token": token,
        "fullname": fullname,
        "type": type,
        "branch": branch,
        "firebase": firebase,
      };
}

class Selling {
  final Token? token;

  Selling({
    this.token,
  });

  factory Selling.fromJson(Map<String, dynamic> json) => Selling(
        token: json["token"] == null ? null : Token.fromJson(json["token"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token?.toJson(),
      };
}

class Token {
  final String? token;
  final String? companyId;
  final String? role;
  final String? name;

  Token({
    this.token,
    this.companyId,
    this.role,
    this.name,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        token: json["token"],
        companyId: json["company_id"],
        role: json["role"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "company_id": companyId,
        "role": role,
        "name": name,
      };
}
