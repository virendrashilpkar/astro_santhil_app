// To parse this JSON data, do
//
//     final packages = packagesFromJson(jsonString);

import 'dart:convert';

List<Packages> packagesFromJson(String str) => List<Packages>.from(json.decode(str).map((x) => Packages.fromJson(x)));

String packagesToJson(List<Packages> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Packages {
  Packages({
    this.color,
    this.tittle,
    this.discount,
  });

  String? color;
  String? tittle;
  String? discount;

  factory Packages.fromJson(Map<String, dynamic> json) => Packages(
    color: json["color"],
    tittle: json["tittle"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "color": color,
    "tittle": tittle,
    "discount": discount,
  };
}
