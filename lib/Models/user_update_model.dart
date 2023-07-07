// To parse this JSON data, do
//
//     final updateUserModel = updateUserModelFromJson(jsonString);

import 'dart:convert';

UpdateUserModel updateUserModelFromJson(String str) => UpdateUserModel.fromJson(json.decode(str));

String updateUserModelToJson(UpdateUserModel data) => json.encode(data.toJson());

class UpdateUserModel {
  int? status;
  String? message;
  Data? data;

  UpdateUserModel({
    this.status,
    this.message,
    this.data,
  });

  factory UpdateUserModel.fromJson(Map<String, dynamic> json) => UpdateUserModel(
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
  String? countryCode;
  String? image;
  String? about;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? birthDate;
  String? phone;
  String? createdBy;
  String? token;
  int? otp;
  bool? isBlocked;
  bool? isSuspended;
  bool? isLocation;
  String? plan;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? city;
  String? country;
  String? gender;
  String? height;
  String? maritalStatus;
  String? weight;
  Location? location;
  String? lookingFor;
  String? religion;

  Data({
    this.countryCode,
    this.image,
    this.about,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.birthDate,
    this.phone,
    this.createdBy,
    this.token,
    this.otp,
    this.isBlocked,
    this.isSuspended,
    this.isLocation,
    this.plan,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.city,
    this.country,
    this.gender,
    this.height,
    this.maritalStatus,
    this.weight,
    this.location,
    this.lookingFor,
    this.religion,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    countryCode: json["country_code"],
    image: json["image"],
    about: json["about"],
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    birthDate: json["birth_date"],
    phone: json["phone"],
    createdBy: json["created_by"],
    token: json["token"],
    otp: json["otp"],
    isBlocked: json["is_Blocked"],
    isSuspended: json["is_suspended"],
    isLocation: json["is_location"],
    plan: json["plan"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    city: json["city"],
    country: json["country"],
    gender: json["gender"],
    height: json["height"],
    maritalStatus: json["marital_status"],
    weight: json["weight"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    lookingFor: json["looking_for"],
    religion: json["religion"],
  );

  Map<String, dynamic> toJson() => {
    "country_code": countryCode,
    "image": image,
    "about": about,
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "birth_date": birthDate,
    "phone": phone,
    "created_by": createdBy,
    "token": token,
    "otp": otp,
    "is_Blocked": isBlocked,
    "is_suspended": isSuspended,
    "is_location": isLocation,
    "plan": plan,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "city": city,
    "country": country,
    "gender": gender,
    "height": height,
    "marital_status": maritalStatus,
    "weight": weight,
    "location": location?.toJson(),
    "looking_for": lookingFor,
    "religion": religion,
  };
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}
