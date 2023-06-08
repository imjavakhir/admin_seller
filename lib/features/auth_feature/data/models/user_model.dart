// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String token;
  final String fullname;
  final String type;
  final String branch;
  final String? firebase;

  UserModel({
    required this.token,
    required this.fullname,
    required this.type,
    required this.branch,
    required this.firebase,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["token"],
        fullname: json["fullname"],
        type: json["type"],
        branch: json["branch"],
        firebase: json["firebase"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "fullname": fullname,
        "type": type,
        "branch": branch,
        "firebase": firebase,
      };
}
