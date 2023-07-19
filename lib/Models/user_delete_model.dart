// To parse this JSON data, do
//
//     final userDeleteModel = userDeleteModelFromJson(jsonString);

import 'dart:convert';

UserDeleteModel userDeleteModelFromJson(String str) => UserDeleteModel.fromJson(json.decode(str));

String userDeleteModelToJson(UserDeleteModel data) => json.encode(data.toJson());

class UserDeleteModel {
  int? status;
  String? message;
  Data? data;

  UserDeleteModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserDeleteModel.fromJson(Map<String, dynamic> json) => UserDeleteModel(
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
  String? image;
  String? about;
  String? managedBy;
  String? createdBy;
  String? religion;
  String? caste;
  String? jobTitle;
  String? company;
  String? education;
  bool? isSuspended;
  int? minAge;
  int? maxAge;
  int? minHeight;
  int? maxHeight;
  bool? isOnline;
  bool? isShowOnCard;
  bool? goGlobel;
  bool? goIncognito;
  bool? showPeopleInRange;
  bool? isAge;
  bool? isHeight;
  bool? isWeight;
  bool? isSmoke;
  bool? isDrink;
  bool? isDiet;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  DateTime? birthDate;
  String? phone;
  String? token;
  int? otp;
  String? location;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? city;
  String? gender;
  String? height;
  String? martialStatus;
  String? weight;
  bool? isBlocked;
  String? country;
  bool? isLocation;
  String? maritalStatus;
  bool? isActive;
  String? countryCode;
  String? lookingFor;
  String? plan;
  String? state;
  bool? isVerified;

  Data({
    this.image,
    this.about,
    this.managedBy,
    this.createdBy,
    this.religion,
    this.caste,
    this.jobTitle,
    this.company,
    this.education,
    this.isSuspended,
    this.minAge,
    this.maxAge,
    this.minHeight,
    this.maxHeight,
    this.isOnline,
    this.isShowOnCard,
    this.goGlobel,
    this.goIncognito,
    this.showPeopleInRange,
    this.isAge,
    this.isHeight,
    this.isWeight,
    this.isSmoke,
    this.isDrink,
    this.isDiet,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.birthDate,
    this.phone,
    this.token,
    this.otp,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.city,
    this.gender,
    this.height,
    this.martialStatus,
    this.weight,
    this.isBlocked,
    this.country,
    this.isLocation,
    this.maritalStatus,
    this.isActive,
    this.countryCode,
    this.lookingFor,
    this.plan,
    this.state,
    this.isVerified,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    image: json["image"],
    about: json["about"],
    managedBy: json["managedBy"],
    createdBy: json["created_by"],
    religion: json["religion"],
    caste: json["caste"],
    jobTitle: json["job_title"],
    company: json["company"],
    education: json["education"],
    isSuspended: json["is_suspended"],
    minAge: json["minAge"],
    maxAge: json["maxAge"],
    minHeight: json["minHeight"],
    maxHeight: json["maxHeight"],
    isOnline: json["is_online"],
    isShowOnCard: json["is_showOnCard"],
    goGlobel: json["goGlobel"],
    goIncognito: json["go_incognito"],
    showPeopleInRange: json["show_people_in_range"],
    isAge: json["is_age"],
    isHeight: json["is_height"],
    isWeight: json["is_weight"],
    isSmoke: json["is_smoke"],
    isDrink: json["is_drink"],
    isDiet: json["is_diet"],
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
    phone: json["phone"],
    token: json["token"],
    otp: json["otp"],
    location: json["location"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    city: json["city"],
    gender: json["gender"],
    height: json["height"],
    martialStatus: json["martial_status"],
    weight: json["weight"],
    isBlocked: json["is_Blocked"],
    country: json["country"],
    isLocation: json["is_location"],
    maritalStatus: json["marital_status"],
    isActive: json["is_active"],
    countryCode: json["country_code"],
    lookingFor: json["looking_for"],
    plan: json["plan"],
    state: json["state"],
    isVerified: json["is_verified"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "about": about,
    "managedBy": managedBy,
    "created_by": createdBy,
    "religion": religion,
    "caste": caste,
    "job_title": jobTitle,
    "company": company,
    "education": education,
    "is_suspended": isSuspended,
    "minAge": minAge,
    "maxAge": maxAge,
    "minHeight": minHeight,
    "maxHeight": maxHeight,
    "is_online": isOnline,
    "is_showOnCard": isShowOnCard,
    "goGlobel": goGlobel,
    "go_incognito": goIncognito,
    "show_people_in_range": showPeopleInRange,
    "is_age": isAge,
    "is_height": isHeight,
    "is_weight": isWeight,
    "is_smoke": isSmoke,
    "is_drink": isDrink,
    "is_diet": isDiet,
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "birth_date": "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
    "phone": phone,
    "token": token,
    "otp": otp,
    "location": location,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "city": city,
    "gender": gender,
    "height": height,
    "martial_status": martialStatus,
    "weight": weight,
    "is_Blocked": isBlocked,
    "country": country,
    "is_location": isLocation,
    "marital_status": maritalStatus,
    "is_active": isActive,
    "country_code": countryCode,
    "looking_for": lookingFor,
    "plan": plan,
    "state": state,
    "is_verified": isVerified,
  };
}
