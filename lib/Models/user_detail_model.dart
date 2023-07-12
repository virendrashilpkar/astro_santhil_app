// To parse this JSON data, do
//
//     final userDetailModel = userDetailModelFromJson(jsonString);

import 'dart:convert';

UserDetailModel userDetailModelFromJson(String str) => UserDetailModel.fromJson(json.decode(str));

String userDetailModelToJson(UserDetailModel data) => json.encode(data.toJson());

class UserDetailModel {
  int? status;
  String? meesage;
  List<detailDatum>? data;

  UserDetailModel({
    this.status,
    this.meesage,
    this.data,
  });

  factory UserDetailModel.fromJson(Map<String, dynamic> json) => UserDetailModel(
    status: json["status"],
    meesage: json["meesage"],
    data: json["data"] == null ? [] : List<detailDatum>.from(json["data"]!.map((x) => detailDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "meesage": meesage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class detailDatum {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  DateTime? birthDate;
  int? age;
  String? phone;
  String? plan;
  String? city;
  String? state;
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
  int? maxAge;
  int? maxHeight;
  int? minAge;
  int? minHeight;

  detailDatum({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.birthDate,
    this.age,
    this.phone,
    this.plan,
    this.city,
    this.state,
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
    this.maxHeight,
    this.maxAge,
    this.minHeight,
    this.minAge
  });

  factory detailDatum.fromJson(Map<String, dynamic> json) => detailDatum(
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    birthDate: json["birth_date"] == "" ? null : DateTime.parse(json["birth_date"]),
    age: json["age"],
    phone: json["phone"],
    plan: json["plan"],
    city: json["city"],
    state: json["state"],
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
    maxAge: json["maxAge"],
    maxHeight: json["maxHeight"],
    minAge: json["minAge"],
    minHeight: json["minHeight"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "birth_date": "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
    "age":age,
    "phone": phone,
    "plan": plan,
    "city": city,
    "state": state,
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
    "maxAge": maxAge,
    "maxHeight": maxHeight,
    "minAge": minAge,
    "minHeight": minHeight,
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
