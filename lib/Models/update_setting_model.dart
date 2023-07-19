// To parse this JSON data, do
//
//     final updateSettingModel = updateSettingModelFromJson(jsonString);

import 'dart:convert';

UpdateSettingModel updateSettingModelFromJson(String str) => UpdateSettingModel.fromJson(json.decode(str));

String updateSettingModelToJson(UpdateSettingModel data) => json.encode(data.toJson());

class UpdateSettingModel {
  int? status;
  String? message;
  Data? data;

  UpdateSettingModel({
    this.status,
    this.message,
    this.data,
  });

  factory UpdateSettingModel.fromJson(Map<String, dynamic> json) => UpdateSettingModel(
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
  int? maxAge;
  int? maxHeight;
  int? minAge;
  int? minHeight;
  String? state;
  bool? isVerified;
  String? username;
  bool? isEmail;
  bool? isPush;

  Data({
    this.countryCode,
    this.image,
    this.managedBy,
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
    this.maxAge,
    this.maxHeight,
    this.minAge,
    this.minHeight,
    this.state,
    this.isVerified,
    this.username,
    this.isEmail,
    this.isPush,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    countryCode: json["country_code"],
    image: json["image"],
    managedBy: json["managedBy"],
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
    maxAge: json["maxAge"],
    maxHeight: json["maxHeight"],
    minAge: json["minAge"],
    minHeight: json["minHeight"],
    state: json["state"],
    isVerified: json["is_verified"],
    username: json["username"],
    isEmail: json["is_email"],
    isPush: json["is_push"],
  );

  Map<String, dynamic> toJson() => {
    "country_code": countryCode,
    "image": image,
    "managedBy": managedBy,
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
    "maxAge": maxAge,
    "maxHeight": maxHeight,
    "minAge": minAge,
    "minHeight": minHeight,
    "state": state,
    "is_verified": isVerified,
    "username": username,
    "is_email": isEmail,
    "is_push": isPush,
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
