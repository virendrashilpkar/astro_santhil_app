// To parse this JSON data, do
//
//     final religionModel = religionModelFromJson(jsonString);

import 'dart:convert';

ReligionModel religionModelFromJson(String str) => ReligionModel.fromJson(json.decode(str));

String religionModelToJson(ReligionModel data) => json.encode(data.toJson());

class ReligionModel {
  bool? status;
  String? message;
  List<ReligionDatum>? data;

  ReligionModel({
    this.status,
    this.message,
    this.data,
  });

  factory ReligionModel.fromJson(Map<String, dynamic> json) => ReligionModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ReligionDatum>.from(json["data"]!.map((x) => ReligionDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ReligionDatum {
  String? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ReligionDatum({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ReligionDatum.fromJson(Map<String, dynamic> json) => ReligionDatum(
    id: json["_id"],
    name: json["name"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
