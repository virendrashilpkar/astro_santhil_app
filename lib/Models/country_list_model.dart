// To parse this JSON data, do
//
//     final countryListModel = countryListModelFromJson(jsonString);

import 'dart:convert';

CountryListModel countryListModelFromJson(String str) => CountryListModel.fromJson(json.decode(str));

String countryListModelToJson(CountryListModel data) => json.encode(data.toJson());

class CountryListModel {
  bool? status;
  String? message;
  List<CountryData>? data;

  CountryListModel({
    this.status,
    this.message,
    this.data,
  });

  factory CountryListModel.fromJson(Map<String, dynamic> json) => CountryListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<CountryData>.from(json["data"]!.map((x) => CountryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CountryData {
  String? id;
  String? name;
  String? countryCode;
  String? phoneCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CountryData({
    this.id,
    this.name,
    this.countryCode,
    this.phoneCode,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
    id: json["_id"],
    name: json["name"],
    countryCode: json["countryCode"],
    phoneCode: json["phoneCode"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "countryCode": countryCode,
    "phoneCode": phoneCode,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
