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
  String? state;
  String? height;
  String? weight;
  String? religion;
  String? country;
  String? maritalStatus;
  String? image;
  int? age;
  DateTime? dob;
  bool? isOnline;

  UserDatum({
    this.id,
    this.firstName,
    this.lastName,
    this.city,
    this.state,
    this.height,
    this.weight,
    this.religion,
    this.country,
    this.maritalStatus,
    this.image,
    this.age,
    this.dob,
    this.isOnline,
  });

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    city: json["city"],
    state: json["state"],
    height: json["height"].toString(),
    weight: json["weight"].toString(),
    religion: json["religion"].toString(),
    country: json["country"],
    maritalStatus: json["marital_status"],
    image: json["image"],
    age: json["Age"],
    dob: DateTime.parse(json["dob"]),
    isOnline: json["show_me_online"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
    "city": city,
    "state": state,
    "height": height,
    "weight": weight,
    "religion": religion,
    "country": country,
    "marital_status": maritalStatus,
    "image": image,
    "Age": age,
    "dob": dob?.toIso8601String(),
    "show_me_online": isOnline,
  };
}
