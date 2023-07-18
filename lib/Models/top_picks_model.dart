// To parse this JSON data, do
//
//     final topPicksModel = topPicksModelFromJson(jsonString);

import 'dart:convert';

TopPicksModel topPicksModelFromJson(String str) => TopPicksModel.fromJson(json.decode(str));

String topPicksModelToJson(TopPicksModel data) => json.encode(data.toJson());

class TopPicksModel {
  int? status;
  String? meesage;
  List<Datum>? data;

  TopPicksModel({
    this.status,
    this.meesage,
    this.data,
  });

  factory TopPicksModel.fromJson(Map<String, dynamic> json) => TopPicksModel(
    status: json["status"],
    meesage: json["meesage"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "meesage": meesage,
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

  Datum({
    this.id,
    this.createdAt,
    this.age,
    this.image,
    this.name,
    this.type,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    age: json["age"],
    image: json["image"],
    name: json["name"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "age": age,
    "image": image,
    "name": name,
    "type": type,
  };
}
