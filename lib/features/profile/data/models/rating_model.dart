// To parse this JSON data, do
//
//     final ratingModel = ratingModelFromJson(jsonString);

import 'dart:convert';

RatingModel ratingModelFromJson(String str) =>
    RatingModel.fromJson(json.decode(str));

String ratingModelToJson(RatingModel data) => json.encode(data.toJson());

class RatingModel {
  final String? id;
  final dynamic rating;

  RatingModel({
    this.id,
    this.rating,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        id: json["id"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rating": rating,
      };
}
