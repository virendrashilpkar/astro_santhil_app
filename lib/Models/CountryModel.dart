// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

CountryModel countryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  CountryModel({
    this.country,
  });

  final List<Country>? country;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    country: json["country"] == null ? [] : List<Country>.from(json["country"]!.map((x) => Country.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "country": country == null ? [] : List<dynamic>.from(country!.map((x) => x.toJson())),
  };
}

class Country {
  Country({
    this.name,
    this.dialCode,
    this.code,
  });

  final String? name;
  final String? dialCode;
  final String? code;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    name: json["name"],
    dialCode: json["dial_code"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "dial_code": dialCode,
    "code": code,
  };
}
