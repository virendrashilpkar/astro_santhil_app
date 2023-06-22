// To parse this JSON data, do
//
//     final myMatchesModel = myMatchesModelFromJson(jsonString);

import 'dart:convert';

MyMatchesModel myMatchesModelFromJson(String str) => MyMatchesModel.fromJson(json.decode(str));

String myMatchesModelToJson(MyMatchesModel data) => json.encode(data.toJson());

class MyMatchesModel {
  int? status;
  String? message;
  List<Datum>? data;

  MyMatchesModel({
    this.status,
    this.message,
    this.data,
  });

  factory MyMatchesModel.fromJson(Map<String, dynamic> json) => MyMatchesModel(
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
  String? firstName;
  String? lastName;
  int? age;
  String? phone;
  String? gender;
  String? height;
  String? weight;
  String? city;
  String? image;

  Datum({
    this.id,
    this.createdAt,
    this.firstName,
    this.lastName,
    this.age,
    this.phone,
    this.gender,
    this.height,
    this.weight,
    this.city,
    this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    firstName: json["first_name"],
    lastName: json["last_name"],
    age: json["age"],
    phone: json["phone"],
    gender: json["gender"],
    height: json["height"],
    weight: json["weight"],
    city: json["city"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "first_name": firstName,
    "last_name": lastName,
    "age": age,
    "phone": phone,
    "gender": gender,
    "height": height,
    "weight": weight,
    "city": city,
    "image": image,
  };
}
