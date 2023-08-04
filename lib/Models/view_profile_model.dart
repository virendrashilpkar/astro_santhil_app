// To parse this JSON data, do
//
//     final viewProfileModel = viewProfileModelFromJson(jsonString);

import 'dart:convert';

ViewProfileModel viewProfileModelFromJson(String str) => ViewProfileModel.fromJson(json.decode(str));

String viewProfileModelToJson(ViewProfileModel data) => json.encode(data.toJson());

class ViewProfileModel {
  int? status;
  String? message;
  List<Datum>? data;

  ViewProfileModel({
    this.status,
    this.message,
    this.data,
  });

  factory ViewProfileModel.fromJson(Map<String, dynamic> json) => ViewProfileModel(
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
  String? firstName;
  String? lastName;
  String? city;
  String? country;
  String? state;
  int? isVerified;
  String? image;
  String? imageId;

  Datum({
    this.id,
    this.firstName,
    this.lastName,
    this.city,
    this.country,
    this.state,
    this.isVerified,
    this.image,
    this.imageId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    city: json["city"],
    country: json["country"],
    state: json["state"],
    isVerified: json["is_verified"],
    image: json["image"],
    imageId: json["imageId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
    "city": city,
    "country": country,
    "state": state,
    "is_verified": isVerified,
    "image": image,
    "imageId": imageId,
  };
}
