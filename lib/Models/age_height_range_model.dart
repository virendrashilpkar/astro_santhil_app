// To parse this JSON data, do
//
//     final ageHeightRangeModel = ageHeightRangeModelFromJson(jsonString);

import 'dart:convert';

AgeHeightRangeModel ageHeightRangeModelFromJson(String str) => AgeHeightRangeModel.fromJson(json.decode(str));

String ageHeightRangeModelToJson(AgeHeightRangeModel data) => json.encode(data.toJson());

class AgeHeightRangeModel {
  int? status;
  String? message;
  Data? data;

  AgeHeightRangeModel({
    this.status,
    this.message,
    this.data,
  });

  factory AgeHeightRangeModel.fromJson(Map<String, dynamic> json) => AgeHeightRangeModel(
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
  String? managedBy;
  int? heightRange;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  DateTime? birthDate;
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
  String? caste;
  String? about;
  String? company;
  String? education;
  String? jobTitle;
  int? ageRange;

  Data({
    this.countryCode,
    this.image,
    this.managedBy,
    this.heightRange,
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
    this.caste,
    this.about,
    this.company,
    this.education,
    this.jobTitle,
    this.ageRange,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    countryCode: json["country_code"],
    image: json["image"],
    managedBy: json["managedBy"],
    heightRange: json["heightRange"],
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
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
    caste: json["caste"],
    about: json["about"],
    company: json["company"],
    education: json["education"],
    jobTitle: json["job_title"],
    ageRange: json["ageRange"],
  );

  Map<String, dynamic> toJson() => {
    "country_code": countryCode,
    "image": image,
    "managedBy": managedBy,
    "heightRange": heightRange,
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "birth_date": birthDate?.toIso8601String(),
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
    "caste": caste,
    "about": about,
    "company": company,
    "education": education,
    "job_title": jobTitle,
    "ageRange": ageRange,
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
