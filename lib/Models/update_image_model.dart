// To parse this JSON data, do
//
//     final updateImageModel = updateImageModelFromJson(jsonString);

import 'dart:convert';

UpdateImageModel updateImageModelFromJson(String str) => UpdateImageModel.fromJson(json.decode(str));

String updateImageModelToJson(UpdateImageModel data) => json.encode(data.toJson());

class UpdateImageModel {
  int? status;
  String? message;
  Data? data;

  UpdateImageModel({
    this.status,
    this.message,
    this.data,
  });

  factory UpdateImageModel.fromJson(Map<String, dynamic> json) => UpdateImageModel(
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
  String? userId;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.id,
    this.userId,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    userId: json["userId"],
    image: json["image"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
