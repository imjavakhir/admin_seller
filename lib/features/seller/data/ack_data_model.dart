// To parse this JSON data, do
//
//     final ackDataModel = ackDataModelFromJson(jsonString);

import 'dart:convert';

AckDataModel ackDataModelFromJson(String str) => AckDataModel.fromJson(json.decode(str));

String ackDataModelToJson(AckDataModel data) => json.encode(data.toJson());

class AckDataModel {
    final String? id;
    final bool? isAccepted;
    final bool? isCanceled;

    AckDataModel({
        this.id,
        this.isAccepted,
        this.isCanceled,
    });

    factory AckDataModel.fromJson(Map<String, dynamic> json) => AckDataModel(
        id: json["_id"],
        isAccepted: json["is_accepted"],
        isCanceled: json["is_canceled"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "is_accepted": isAccepted,
        "is_canceled": isCanceled,
    };
}
