// To parse this JSON data, do
//
//     final preferenceListModel = preferenceListModelFromJson(jsonString);

import 'dart:convert';

PreferenceListModel preferenceListModelFromJson(String str) => PreferenceListModel.fromJson(json.decode(str));

String preferenceListModelToJson(PreferenceListModel data) => json.encode(data.toJson());

class PreferenceListModel {
  int? status;
  String? message;
  List<Datum>? data;

  PreferenceListModel({
    this.status,
    this.message,
    this.data,
  });

  factory PreferenceListModel.fromJson(Map<String, dynamic> json) => PreferenceListModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? title;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? icon;
  bool? isActive;

  Datum({
    this.id,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.icon,
    this.isActive,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    title: json["title"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    icon: json["icon"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "icon": icon,
    "is_active": isActive,
  };
}
