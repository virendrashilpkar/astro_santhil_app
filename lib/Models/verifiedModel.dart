// To parse this JSON data, do
//
//     final verifiedModel = verifiedModelFromJson(jsonString);

import 'dart:convert';

VerifiedModel verifiedModelFromJson(String str) => VerifiedModel.fromJson(json.decode(str));

String verifiedModelToJson(VerifiedModel data) => json.encode(data.toJson());

class VerifiedModel {
  int? status;
  String? message;
  Data? data;

  VerifiedModel({
    this.status,
    this.message,
    this.data,
  });

  factory VerifiedModel.fromJson(Map<String, dynamic> json) => VerifiedModel(
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
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  DateTime? birthDate;
  String? countryCode;
  String? phone;
  String? height;
  String? gender;
  String? image;
  String? weight;
  String? city;
  String? state;
  String? country;
  String? about;
  String? managedBy;
  String? createdBy;
  String? token;
  dynamic otp;
  String? religion;
  String? caste;
  String? jobTitle;
  String? company;
  String? education;
  bool? isBlocked;
  bool? isSuspended;
  String? socialId;
  String? socialPlatform;
  bool? isLocation;
  String? plan;
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
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? lookingFor;
  String? maritalStatus;
  String? covidVaccine;
  String? dietaryPreference;
  String? drinking;
  String? educationLevel;
  String? health;
  String? marriagePlan;
  String? motherTongue;
  String? personalityType;
  String? pets;
  String? sleepingHabits;
  String? smoking;
  String? socialMedia;
  String? workout;
  String? zodiacSign;
  int? isVerified;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.birthDate,
    this.countryCode,
    this.phone,
    this.height,
    this.gender,
    this.image,
    this.weight,
    this.city,
    this.state,
    this.country,
    this.about,
    this.managedBy,
    this.createdBy,
    this.token,
    this.otp,
    this.religion,
    this.caste,
    this.jobTitle,
    this.company,
    this.education,
    this.isBlocked,
    this.isSuspended,
    this.socialId,
    this.socialPlatform,
    this.isLocation,
    this.plan,
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
    this.createdAt,
    this.updatedAt,
    this.v,
    this.lookingFor,
    this.maritalStatus,
    this.covidVaccine,
    this.dietaryPreference,
    this.drinking,
    this.educationLevel,
    this.health,
    this.marriagePlan,
    this.motherTongue,
    this.personalityType,
    this.pets,
    this.sleepingHabits,
    this.smoking,
    this.socialMedia,
    this.workout,
    this.zodiacSign,
    this.isVerified,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
    countryCode: json["country_code"],
    phone: json["phone"],
    height: json["height"],
    gender: json["gender"],
    image: json["image"],
    weight: json["weight"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    about: json["about"],
    managedBy: json["managedBy"],
    createdBy: json["created_by"],
    token: json["token"],
    otp: json["otp"],
    religion: json["religion"],
    caste: json["caste"],
    jobTitle: json["job_title"],
    company: json["company"],
    education: json["education"],
    isBlocked: json["is_Blocked"],
    isSuspended: json["is_suspended"],
    socialId: json["social_id"],
    socialPlatform: json["social_platform"],
    isLocation: json["is_location"],
    plan: json["plan"],
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
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    lookingFor: json["looking_for"],
    maritalStatus: json["marital_status"],
    covidVaccine: json["covid_vaccine"],
    dietaryPreference: json["dietary_preference"],
    drinking: json["drinking"],
    educationLevel: json["education_level"],
    health: json["health"],
    marriagePlan: json["marriage_plan"],
    motherTongue: json["mother_tongue"],
    personalityType: json["personality_type"],
    pets: json["pets"],
    sleepingHabits: json["sleeping_habits"],
    smoking: json["smoking"],
    socialMedia: json["social_media"],
    workout: json["workout"],
    zodiacSign: json["zodiac_sign"],
    isVerified: json["is_verified"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "birth_date": birthDate?.toIso8601String(),
    "country_code": countryCode,
    "phone": phone,
    "height": height,
    "gender": gender,
    "image": image,
    "weight": weight,
    "city": city,
    "state": state,
    "country": country,
    "about": about,
    "managedBy": managedBy,
    "created_by": createdBy,
    "token": token,
    "otp": otp,
    "religion": religion,
    "caste": caste,
    "job_title": jobTitle,
    "company": company,
    "education": education,
    "is_Blocked": isBlocked,
    "is_suspended": isSuspended,
    "social_id": socialId,
    "social_platform": socialPlatform,
    "is_location": isLocation,
    "plan": plan,
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
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "looking_for": lookingFor,
    "marital_status": maritalStatus,
    "covid_vaccine": covidVaccine,
    "dietary_preference": dietaryPreference,
    "drinking": drinking,
    "education_level": educationLevel,
    "health": health,
    "marriage_plan": marriagePlan,
    "mother_tongue": motherTongue,
    "personality_type": personalityType,
    "pets": pets,
    "sleeping_habits": sleepingHabits,
    "smoking": smoking,
    "social_media": socialMedia,
    "workout": workout,
    "zodiac_sign": zodiacSign,
    "is_verified": isVerified,
  };
}
