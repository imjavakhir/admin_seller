// To parse this JSON data, do
//
//     final userUnverified = userUnverifiedFromJson(jsonString);

import 'dart:convert';

List<UserUnverified?> userUnverifiedFromJson(List str) =>
    List<UserUnverified>.from(str.map((x) => UserUnverified.fromJson(x)));

String userUnverifiedToJson(List<UserUnverified> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserUnverified {
  final UserVerify? user;
  final bool? isOnline;
  final bool? isPaused;
  final bool? isVerified;
  final bool? isFree;

  UserUnverified({
    this.user,
    this.isOnline,
    this.isPaused,
    this.isVerified,
    this.isFree,
  });

  factory UserUnverified.fromJson(Map<String, dynamic> json) => UserUnverified(
        user: json["user"] == null ? null : UserVerify.fromJson(json["user"]),
        isOnline: json["is_online"],
        isPaused: json["is_paused"],
        isVerified: json["is_verified"],
        isFree: json["is_free"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "is_online": isOnline,
        "is_paused": isPaused,
        "is_verified": isVerified,
        "is_free": isFree,
      };
}

class UserVerify {
  final String? id;
  final String? fullname;
  final String? phoneNumber;

  UserVerify({
    this.id,
    this.fullname,
    this.phoneNumber,
  });

  factory UserVerify.fromJson(Map<String, dynamic> json) => UserVerify(
        id: json["_id"],
        fullname: json["fullname"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullname": fullname,
        "phone_number": phoneNumber,
      };
}
