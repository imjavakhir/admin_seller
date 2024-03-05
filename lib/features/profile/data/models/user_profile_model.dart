// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'package:admin_seller/app_const/app_exports.dart';


UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  final bool? isOnline;
  final bool? isPaused;
  final bool? isVerified;
  final UserProfile? user;

  UserProfileModel({
    this.isOnline,
    this.isPaused,
    this.isVerified,
    this.user,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        isOnline: json["is_online"],
        isPaused: json["is_paused"],
        isVerified: json["is_verified"],
        user: json["user"] == null ? null : UserProfile.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "is_online": isOnline,
        "is_paused": isPaused,
        "is_verified": isVerified,
        "user": user?.toJson(),
      };
}

class UserProfile {
  final String? fullname;
  final String? phoneNumber;
  final dynamic balance;
  final dynamic point;

  UserProfile({
    this.fullname,
    this.phoneNumber,
    this.balance,
    this.point,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        fullname: json["fullname"],
        phoneNumber: json["phone_number"],
        balance: json["balance"],
        point: json["point"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "phone_number": phoneNumber,
        "balance": balance,
        "point": point,
      };
}
