// To parse this JSON data, do
//
//     final userUnverified = userUnverifiedFromJson(jsonString);

import 'dart:convert';

List<UserUnverified?> userUnverifiedFromJson(List str) =>
    List<UserUnverified?>.from(str.map((x) => UserUnverified.fromJson(x)));

String userUnverifiedToJson(List<UserUnverified> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserUnverified {
  final String? id;
  final String? fullname;
  final String? phoneNumber;
  final bool? isOnline;
  final bool? isPaused;
  final bool? isVerified;

  UserUnverified({
    this.id,
    this.fullname,
    this.phoneNumber,
    this.isOnline,
    this.isPaused,
    this.isVerified,
  });

  factory UserUnverified.fromJson(Map<String, dynamic> json) => UserUnverified(
        id: json["id"],
        fullname: json["fullname"],
        phoneNumber: json["phone_number"],
        isOnline: json["is_online"],
        isPaused: json["is_paused"],
        isVerified: json["is_verified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "phone_number": phoneNumber,
        "is_online": isOnline,
        "is_paused": isPaused,
        "is_verified": isVerified,
      };
}
