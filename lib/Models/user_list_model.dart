// To parse this JSON data, do
//
//     final userListModel = userListModelFromJson(jsonString);

import 'dart:convert';

UserListModel userListModelFromJson(String str) => UserListModel.fromJson(json.decode(str));

String userListModelToJson(UserListModel data) => json.encode(data.toJson());

class UserListModel {
  int? status;
  String? meesage;
  List<UserDatum>? data;

  UserListModel({
    this.status,
    this.meesage,
    this.data,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
    status: json["status"],
    meesage: json["meesage"],
    data: List<UserDatum>.from(json["data"].map((x) => UserDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "meesage": meesage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class UserDatum {
  String? id;
  String? firstName;
  String? lastName;
  String? city;
  String? height;
  String? weight;
  String? country;
  String? maritalStatus;
  String? image;
  int? age;
  DateTime? dob;

  UserDatum({
    this.id,
    this.firstName,
    this.lastName,
    this.city,
    this.height,
    this.weight,
    this.country,
    this.maritalStatus,
    this.image,
    this.age,
    this.dob,
  });

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    city: json["city"],
    height: json["height"].toString(),
    weight: json["weight"].toString(),
    country: json["country"],
    maritalStatus: json["marital_status"],
    image: json["image"],
    age: json["Age"],
    dob: DateTime.parse(json["dob"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
    "city": city,
    "height": height,
    "weight": weight,
    "country": country,
    "marital_status": maritalStatus,
    "image": image,
    "Age": age,
    "dob": dob?.toIso8601String(),
  };
}
