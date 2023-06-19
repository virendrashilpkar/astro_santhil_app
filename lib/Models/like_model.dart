// To parse this JSON data, do
//
//     final likeModel = likeModelFromJson(jsonString);

import 'dart:convert';

LikeModel likeModelFromJson(String str) => LikeModel.fromJson(json.decode(str));

String likeModelToJson(LikeModel data) => json.encode(data.toJson());

class LikeModel {
  int? status;
  String? message;
  Data? data;

  LikeModel({
    this.status,
    this.message,
    this.data,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) => LikeModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? id;
  String? type;
  String? sender;
  String? receiver;
  bool? matched;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.id,
    this.type,
    this.sender,
    this.receiver,
    this.matched,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    type: json["type"],
    sender: json["sender"],
    receiver: json["receiver"],
    matched: json["matched"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "type": type,
    "sender": sender,
    "receiver": receiver,
    "matched": matched,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
