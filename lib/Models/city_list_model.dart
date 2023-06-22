// To parse this JSON data, do
//
//     final cItyListModel = cItyListModelFromJson(jsonString);

import 'dart:convert';

CItyListModel cItyListModelFromJson(String str) => CItyListModel.fromJson(json.decode(str));

String cItyListModelToJson(CItyListModel data) => json.encode(data.toJson());

class CItyListModel {
  bool? status;
  String? message;
  List<Datum>? data;

  CItyListModel({
    this.status,
    this.message,
    this.data,
  });

  factory CItyListModel.fromJson(Map<String, dynamic> json) => CItyListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? name;
  CountryCode? countryCode;
  StateCode? stateCode;
  String? latitude;
  String? longitude;

  Datum({
    this.name,
    this.countryCode,
    this.stateCode,
    this.latitude,
    this.longitude,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    countryCode: countryCodeValues.map[json["countryCode"]],
    stateCode: stateCodeValues.map[json["stateCode"]]!,
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "countryCode": countryCodeValues.reverse[countryCode],
    "stateCode": stateCodeValues.reverse[stateCode],
    "latitude": latitude,
    "longitude": longitude,
  };
}

enum CountryCode { IN }

final countryCodeValues = EnumValues({
  "IN": CountryCode.IN
});

enum StateCode { RJ, AS, TN, PB, GJ, MH, UP, AP, TG, KL, KA, MP, TR, WB, MZ, CT, JK, GA, DL, UT, AR, BR, HR, DH, OR, HP, JH, AN, MN, CH, ML, NL, SK, PY, LA, LD }

final stateCodeValues = EnumValues({
  "AN": StateCode.AN,
  "AP": StateCode.AP,
  "AR": StateCode.AR,
  "AS": StateCode.AS,
  "BR": StateCode.BR,
  "CH": StateCode.CH,
  "CT": StateCode.CT,
  "DH": StateCode.DH,
  "DL": StateCode.DL,
  "GA": StateCode.GA,
  "GJ": StateCode.GJ,
  "HP": StateCode.HP,
  "HR": StateCode.HR,
  "JH": StateCode.JH,
  "JK": StateCode.JK,
  "KA": StateCode.KA,
  "KL": StateCode.KL,
  "LA": StateCode.LA,
  "LD": StateCode.LD,
  "MH": StateCode.MH,
  "ML": StateCode.ML,
  "MN": StateCode.MN,
  "MP": StateCode.MP,
  "MZ": StateCode.MZ,
  "NL": StateCode.NL,
  "OR": StateCode.OR,
  "PB": StateCode.PB,
  "PY": StateCode.PY,
  "RJ": StateCode.RJ,
  "SK": StateCode.SK,
  "TG": StateCode.TG,
  "TN": StateCode.TN,
  "TR": StateCode.TR,
  "UP": StateCode.UP,
  "UT": StateCode.UT,
  "WB": StateCode.WB
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
