// To parse this JSON data, do
//
//     final stateListModel = stateListModelFromJson(jsonString);

import 'dart:convert';

StateListModel stateListModelFromJson(String str) => StateListModel.fromJson(json.decode(str));

String stateListModelToJson(StateListModel data) => json.encode(data.toJson());

class StateListModel {
  bool? status;
  String? message;
  List<Statedata>? data;

  StateListModel({
    this.status,
    this.message,
    this.data,
  });

  factory StateListModel.fromJson(Map<String, dynamic> json) => StateListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Statedata>.from(json["data"]!.map((x) => Statedata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Statedata {
  String? name;
  String? isoCode;
  String? countryCode;
  String? latitude;
  String? longitude;

  Statedata({
    this.name,
    this.isoCode,
    this.countryCode,
    this.latitude,
    this.longitude,
  });

  factory Statedata.fromJson(Map<String, dynamic> json) => Statedata(
    name: json["name"],
    isoCode: json["isoCode"],
    countryCode: json["countryCode"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "isoCode": isoCode,
    "countryCode": countryCode,
    "latitude": latitude,
    "longitude": longitude,
  };
}
