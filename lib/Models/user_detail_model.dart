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
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "meesage": meesage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
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
  String? caste;
  String? managedBy;
  String? religion;
  String? lookingFor;
  int? minAge;
  int? maxAge;
  int? minHeight;
  int? maxHeight;
  bool? isOnline;
  bool? isShowOnCard;
  bool? goGlobel;
  String? company;
  String? education;
  String? jobTitle;
  String? state;
  String? marriagePlan;
  String? motherTongue;
  bool? goIncognito;
  bool? showPeopleInRange;
  String? username;
  bool? isAge;
  bool? isDiet;
  bool? isVerified;
  bool? isDrink;
  bool? isHeight;
  bool? isSmoke;
  bool? isWeight;
  String? image;
  int? age;
  String? zodiacSign;
  String? covidVaccine;
  String? pets;
  String? dietaryPreference;
  String? educationLevel;
  String? sleepingHabits;
  String? socialMedia;
  String? workout;
  String? personalityType;
  String? health;
  String? smoking;
  String? drinking;
  List<String>? preference;

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
    this.caste,
    this.managedBy,
    this.religion,
    this.lookingFor,
    this.isOnline,
    this.isShowOnCard,
    this.minAge,
    this.maxAge,
    this.minHeight,
    this.maxHeight,
    this.goGlobel,
    this.company,
    this.education,
    this.jobTitle,
    this.state,
    this.marriagePlan,
    this.motherTongue,
    this.goIncognito,
    this.showPeopleInRange,
    this.username,
    this.isAge,
    this.isDiet,
    this.isVerified,
    this.isDrink,
    this.isHeight,
    this.isSmoke,
    this.isWeight,
    this.image,
    this.age,
    this.zodiacSign,
    this.covidVaccine,
    this.pets,
    this.dietaryPreference,
    this.educationLevel,
    this.sleepingHabits,
    this.socialMedia,
    this.workout,
    this.personalityType,
    this.health,
    this.smoking,
    this.drinking,
    this.preference,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
    phone: json["phone"],
    gender: json["gender"],
    city: json["city"],
    height: json["height"],
    weight: json["weight"],
    email: json["email"],
    about: json["about"],
    maritalStatus: json["marital_status"],
    country: json["country"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    plan: json["plan"],
    caste: json["caste"],
    managedBy: json["managedBy"],
    religion: json["religion"],
    lookingFor: json["looking_for"],
    isOnline: json["is_online"],
    isShowOnCard: json["is_showOnCard"],
    goGlobel: json["goGlobel"],
    minAge: json["minAge"],
    maxAge: json["maxAge"],
    minHeight: json["minHeight"],
    maxHeight: json["maxHeight"],
    company: json["company"],
    education: json["education"],
    jobTitle: json["job_title"],
    state: json["state"],
    marriagePlan: json["marriage_plan"],
    motherTongue: json["mother_tongue"],
    goIncognito: json["go_incognito"],
    showPeopleInRange: json["show_people_in_range"],
    username: json["username"],
    isAge: json["is_age"],
    isDiet: json["is_diet"],
    isVerified: json["is_verified"],
    isDrink: json["is_drink"],
    isHeight: json["is_height"],
    isSmoke: json["is_smoke"],
    isWeight: json["is_weight"],
    image: json["image"],
    age: json["age"],
    zodiacSign: json["zodiac_sign"],
    covidVaccine: json["covid_vaccine"],
    pets: json["pets"],
    dietaryPreference: json["dietary_preference"],
    educationLevel: json["education_level"],
    sleepingHabits: json["sleeping_habits"],
    socialMedia: json["social_media"],
    workout: json["workout"],
    personalityType: json["personality_type"],
    health: json["health"],
    smoking: json["smoking"],
    drinking: json["drinking"],
    preference: json["preference"] == null ? [] : List<String>.from(json["preference"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
    "birth_date": "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
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
    "caste": caste,
    "managedBy": managedBy,
    "religion": religion,
    "looking_for": lookingFor,
    "is_online": isOnline,
    "is_showOnCard": isShowOnCard,
    "goGlobel": goGlobel,
    "minAge": minAge,
    "maxAge": maxAge,
    "minHeight": minHeight,
    "maxHeight": maxHeight,
    "company": company,
    "education": education,
    "job_title": jobTitle,
    "state": state,
    "marriage_plan": marriagePlan,
    "mother_tongue": motherTongue,
    "go_incognito": goIncognito,
    "show_people_in_range": showPeopleInRange,
    "username": username,
    "is_age": isAge,
    "is_diet": isDiet,
    "is_verified": isVerified,
    "is_drink": isDrink,
    "is_height": isHeight,
    "is_smoke": isSmoke,
    "is_weight": isWeight,
    "image": image,
    "age": age,
    "zodiac_sign": zodiacSign,
    "covid_vaccine": covidVaccine,
    "pets": pets,
    "dietary_preference": dietaryPreference,
    "education_level": educationLevel,
    "sleeping_habits": sleepingHabits,
    "social_media": socialMedia,
    "workout": workout,
    "personality_type": personalityType,
    "health": health,
    "smoking": smoking,
    "drinking": drinking,
    "preference": preference == null ? [] : List<dynamic>.from(preference!.map((x) => x)),
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
