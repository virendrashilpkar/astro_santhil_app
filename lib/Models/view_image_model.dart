// To parse this JSON data, do
//
//     final viewImageModel = viewImageModelFromJson(jsonString);

import 'dart:convert';

ViewImageModel viewImageModelFromJson(String str) => ViewImageModel.fromJson(json.decode(str));

String viewImageModelToJson(ViewImageModel data) => json.encode(data.toJson());

class ViewImageModel {
  int? status;
  String? message;
  List<Datum>? data;

  ViewImageModel({
    this.status,
    this.message,
    this.data,
  });

  factory ViewImageModel.fromJson(Map<String, dynamic> json) => ViewImageModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? userId;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.id,
    this.userId,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    userId: json["userId"],
    image: json["image"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "image": image,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
