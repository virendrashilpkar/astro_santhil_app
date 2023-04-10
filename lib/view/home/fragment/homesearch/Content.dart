// To parse this JSON data, do
//
//     final content = contentFromJson(jsonString);

import 'dart:convert';

Content contentFromJson(String str) => Content.fromJson(json.decode(str));

String contentToJson(Content data) => json.encode(data.toJson());

class Content {
  Content({
    this.data,
  });

  List<Datum>? data;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.image,
    this.name,
    this.age,
    this.place,
    this.height,
    this.weight,
    this.region,
    this.status,
  });

  String? image;
  String? name;
  String? age;
  String? place;
  String? height;
  String? weight;
  String? region;
  String? status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    image: json["image"],
    name: json["name"],
    age: json["age"],
    place: json["place"],
    height: json["height"],
    weight: json["weight"],
    region: json["region"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "name": name,
    "age": age,
    "place": place,
    "height": height,
    "weight": weight,
    "region": region,
    "status": status,
  };
}
