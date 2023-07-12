// To parse this JSON data, do
//
//     final newMatchesModel = newMatchesModelFromJson(jsonString);

import 'dart:convert';

NewMatchesModel newMatchesModelFromJson(String str) => NewMatchesModel.fromJson(json.decode(str));

String newMatchesModelToJson(NewMatchesModel data) => json.encode(data.toJson());

class NewMatchesModel {
  int? status;
  String? message;
  List<MatchDatum>? data;

  NewMatchesModel({
    this.status,
    this.message,
    this.data,
  });

  factory NewMatchesModel.fromJson(Map<String, dynamic> json) => NewMatchesModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<MatchDatum>.from(json["data"]!.map((x) => MatchDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MatchDatum {
  String? type;
  DateTime? createdAt;
  String? id;
  String? firstName;
  int? age;
  String? plan;
  String? image;

  MatchDatum({
    this.type,
    this.createdAt,
    this.id,
    this.firstName,
    this.age,
    this.plan,
    this.image,
  });

  factory MatchDatum.fromJson(Map<String, dynamic> json) => MatchDatum(
    type: json["type"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    id: json["_id"],
    firstName: json["first_name"],
    age: json["age"],
    plan: json["plan"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "createdAt": createdAt?.toIso8601String(),
    "_id": id,
    "first_name": firstName,
    "age": age,
    "plan": plan,
    "image": image,
  };
}
