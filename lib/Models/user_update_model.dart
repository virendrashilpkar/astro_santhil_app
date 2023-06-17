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
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  String? image;
  String? createdBy;
  bool? isSuspended;
  String? id;
  String? firstName;
  String? lastName;
  DateTime? birthDate;
  String? phone;
  int? otp;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? gender;
  String? city;
  String? height;
  String? weight;
  String? email;
  String? token;
  bool? isBlocked;
  String? about;
  String? zodiacSign;
  String? covidVaccine;
  String? pets;
  String? maritalStatus;
  String? country;
  bool? isLocation;
  Location? location;
  String? plan;
  String? caste;
  String? dietaryPreference;
  String? educationLevel;
  String? managedBy;
  String? sleepingHabits;
  String? socialMedia;
  String? workout;
  bool? isActive;
  String? countryCode;
  String? lookingFor;

  Data({
    this.image,
    this.createdBy,
    this.isSuspended,
    this.id,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.phone,
    this.otp,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.gender,
    this.city,
    this.height,
    this.weight,
    this.email,
    this.token,
    this.isBlocked,
    this.about,
    this.zodiacSign,
    this.covidVaccine,
    this.pets,
    this.maritalStatus,
    this.country,
    this.isLocation,
    this.location,
    this.plan,
    this.caste,
    this.dietaryPreference,
    this.educationLevel,
    this.managedBy,
    this.sleepingHabits,
    this.socialMedia,
    this.workout,
    this.isActive,
    this.countryCode,
    this.lookingFor,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    image: json["image"],
    createdBy: json["created_by"],
    isSuspended: json["is_suspended"],
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    birthDate: DateTime.parse(json["birth_date"]),
    phone: json["phone"],
    otp: json["otp"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    gender: json["gender"],
    city: json["city"],
    height: json["height"],
    weight: json["weight"],
    email: json["email"],
    token: json["token"],
    isBlocked: json["is_Blocked"],
    about: json["about"],
    zodiacSign: json["zodiac_sign"],
    covidVaccine: json["covid_vaccine"],
    pets: json["pets"],
    maritalStatus: json["marital_status"],
    country: json["country"],
    isLocation: json["is_location"],
    location: Location.fromJson(json["location"]),
    plan: json["plan"],
    caste: json["caste"],
    dietaryPreference: json["dietary_preference"],
    educationLevel: json["education_level"],
    managedBy: json["managedBy"],
    sleepingHabits: json["sleeping_habits"],
    socialMedia: json["social_media"],
    workout: json["workout"],
    isActive: json["is_active"],
    countryCode: json["country_code"],
    lookingFor: json["looking_for"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "created_by": createdBy,
    "is_suspended": isSuspended,
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
    "birth_date": "${birthDate?.year.toString().padLeft(4, '0')}-${birthDate?.month.toString().padLeft(2, '0')}-${birthDate?.day.toString().padLeft(2, '0')}",
    "phone": phone,
    "otp": otp,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "gender": gender,
    "city": city,
    "height": height,
    "weight": weight,
    "email": email,
    "token": token,
    "is_Blocked": isBlocked,
    "about": about,
    "zodiac_sign": zodiacSign,
    "covid_vaccine": covidVaccine,
    "pets": pets,
    "marital_status": maritalStatus,
    "country": country,
    "is_location": isLocation,
    "location": location!.toJson(),
    "plan": plan,
    "caste": caste,
    "dietary_preference": dietaryPreference,
    "education_level": educationLevel,
    "managedBy": managedBy,
    "sleeping_habits": sleepingHabits,
    "social_media": socialMedia,
    "workout": workout,
    "is_active": isActive,
    "country_code": countryCode,
    "looking_for": lookingFor,
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
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
  };
}
