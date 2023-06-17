// To parse this JSON data, do
//
//     final userDetailModel = userDetailModelFromJson(jsonString);

import 'dart:convert';

UserDetailModel userDetailModelFromJson(String str) => UserDetailModel.fromJson(json.decode(str));

String userDetailModelToJson(UserDetailModel data) => json.encode(data.toJson());

class UserDetailModel {
  int? status;
  String? meesage;
  List<Datum>? data;

  UserDetailModel({
    this.status,
    this.meesage,
    this.data,
  });

  factory UserDetailModel.fromJson(Map<String, dynamic> json) => UserDetailModel(
    status: json["status"],
    meesage: json["meesage"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "meesage": meesage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? firstName;
  String? lastName;
  DateTime? birthDate;
  String? phone;
  String? gender;
  String? city;
  String? height;
  String? weight;
  String? email;
  String? about;
  String? maritalStatus;
  String? country;
  Location? location;
  String? plan;
  String? covidVaccine;
  String? pets;
  String? dietaryPreference;
  String? educationLevel;
  String? sleepingHabits;
  String? socialMedia;
  String? workout;

  Datum({
    this.id,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.phone,
    this.gender,
    this.city,
    this.height,
    this.weight,
    this.email,
    this.about,
    this.maritalStatus,
    this.country,
    this.location,
    this.plan,
    this.covidVaccine,
    this.pets,
    this.dietaryPreference,
    this.educationLevel,
    this.sleepingHabits,
    this.socialMedia,
    this.workout,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    birthDate: DateTime.parse(json["birth_date"]),
    phone: json["phone"],
    gender: json["gender"],
    city: json["city"],
    height: json["height"],
    weight: json["weight"],
    email: json["email"],
    about: json["about"],
    maritalStatus: json["marital_status"],
    country: json["country"],
    location: Location.fromJson(json["location"]),
    plan: json["plan"],
    covidVaccine: json["covid_vaccine"],
    pets: json["pets"],
    dietaryPreference: json["dietary_preference"],
    educationLevel: json["education_level"],
    sleepingHabits: json["sleeping_habits"],
    socialMedia: json["social_media"],
    workout: json["workout"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
    "birth_date": "${birthDate?.year.toString().padLeft(4, '0')}-${birthDate?.month.toString().padLeft(2, '0')}-${birthDate?.day.toString().padLeft(2, '0')}",
    "phone": phone,
    "gender": gender,
    "city": city,
    "height": height,
    "weight": weight,
    "email": email,
    "about": about,
    "marital_status": maritalStatus,
    "country": country,
    "location": location?.toJson(),
    "plan": plan,
    "covid_vaccine": covidVaccine,
    "pets": pets,
    "dietary_preference": dietaryPreference,
    "education_level": educationLevel,
    "sleeping_habits": sleepingHabits,
    "social_media": socialMedia,
    "workout": workout,
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
