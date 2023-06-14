// To parse this JSON data, do
//
//     final userOnlineModel = userOnlineModelFromJson(jsonString);

import 'dart:convert';

UserOnlineModel userOnlineModelFromJson(String str) =>
    UserOnlineModel.fromJson(json.decode(str));

String userOnlineModelToJson(UserOnlineModel data) =>
    json.encode(data.toJson());

class UserOnlineModel {
  final String id;
  final bool isOnline;
  final bool isPaused;
  final bool isVerified;

  UserOnlineModel({
    required this.id,
    required this.isOnline,
    required this.isPaused,
    required this.isVerified,
  });

  factory UserOnlineModel.fromJson(Map<String, dynamic> json) =>
      UserOnlineModel(
        id: json["id"],
        isOnline: json["is_online"],
        isPaused: json["is_paused"],
        isVerified: json["is_verified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_online": isOnline,
        "is_paused": isPaused,
        "is_verified": isVerified,
      };
}
