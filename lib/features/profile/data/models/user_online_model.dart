// To parse this JSON data, do
//
//     final userOnlineModel = userOnlineModelFromJson(jsonString);

import 'package:admin_seller/app_const/app_exports.dart';

UserOnlineModel userOnlineModelFromJson(String str) =>
    UserOnlineModel.fromJson(json.decode(str));

String userOnlineModelToJson(UserOnlineModel data) =>
    json.encode(data.toJson());

class UserOnlineModel {
  final String? user;
  final bool? isOnline;
  final bool? isPaused;
  final bool? isVerified;
  final bool? is_free;

  UserOnlineModel({
    required this.is_free,
    required this.user,
    required this.isOnline,
    required this.isPaused,
    required this.isVerified,
  });

  factory UserOnlineModel.fromJson(Map<String, dynamic> json) =>
      UserOnlineModel(
        user: json["user"],
        is_free: json["is_free"],
        isOnline: json["is_online"],
        isPaused: json["is_paused"],
        isVerified: json["is_verified"],
      );

  Map<String, dynamic> toJson() => {
        "is_free": is_free,
        "user": user,
        "is_online": isOnline,
        "is_paused": isPaused,
        "is_verified": isVerified,
      };
}
