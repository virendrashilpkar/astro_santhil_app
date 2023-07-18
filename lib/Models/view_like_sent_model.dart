// To parse this JSON data, do
//
//     final viewLikeSentModel = viewLikeSentModelFromJson(jsonString);

import 'dart:convert';

ViewLikeSentModel viewLikeSentModelFromJson(String str) => ViewLikeSentModel.fromJson(json.decode(str));

String viewLikeSentModelToJson(ViewLikeSentModel data) => json.encode(data.toJson());

class ViewLikeSentModel {
  int? status;
  String? message;
  List<Datum>? data;

  ViewLikeSentModel({
    this.status,
    this.message,
    this.data,
  });

  factory ViewLikeSentModel.fromJson(Map<String, dynamic> json) => ViewLikeSentModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  DateTime? createdAt;
  int? age;
  String? image;
  String? name;
  String? type;
  String? userId;

  Datum({
    this.id,
    this.createdAt,
    this.age,
    this.image,
    this.name,
    this.type,
    this.userId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    age: json["age"],
    image: json["image"],
    name: json["name"],
    type: json["type"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "age": age,
    "image": image,
    "name": name,
    "type": type,
    "userId": userId,
  };
}
