// To parse this JSON data, do
//
//     final matchList = matchListFromJson(jsonString);

import 'dart:convert';

MatchList matchListFromJson(String str) => MatchList.fromJson(json.decode(str));

String matchListToJson(MatchList data) => json.encode(data.toJson());

class MatchList {
  int? status;
  String? message;
  List<Datum>? data;

  MatchList({
    this.status,
    this.message,
    this.data,
  });

  factory MatchList.fromJson(Map<String, dynamic> json) => MatchList(
    status: json["status"],
    message: json["message"],
    data: json["data"] == [] ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == [] ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  DateTime? createdAt;
  String? image;
  String? firstName;
  String? lastName;
  int? age;
  String? phone;
  String? gender;
  String? height;
  String? weight;
  String? city;

  Datum({
    this.id,
    this.createdAt,
    this.image,
    this.firstName,
    this.lastName,
    this.age,
    this.phone,
    this.gender,
    this.height,
    this.weight,
    this.city,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    image: json["image"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    age: json["age"],
    phone: json["phone"],
    gender: json["gender"],
    height: json["height"],
    weight: json["weight"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "image": image,
    "first_name": firstName,
    "last_name": lastName,
    "age": age,
    "phone": phone,
    "gender": gender,
    "height": height,
    "weight": weight,
    "city": city,
  };
}
