// To parse this JSON data, do
//
//     final preferenceListModel = preferenceListModelFromJson(jsonString);

import 'dart:convert';

PreferenceListModel preferenceListModelFromJson(String str) => PreferenceListModel.fromJson(json.decode(str));

String preferenceListModelToJson(PreferenceListModel data) => json.encode(data.toJson());

class PreferenceListModel {
  int? status;
  String? message;
  List<prefsDatum>? data;

  PreferenceListModel({
    this.status,
    this.message,
    this.data,
  });

  factory PreferenceListModel.fromJson(Map<String, dynamic> json) => PreferenceListModel(
    status: json["status"],
    message: json["message"],
    data: List<prefsDatum>.from(json["data"].map((x) => prefsDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class prefsDatum {
  String? id;
  String? title;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? icon;
  bool? isActive;
  bool? is_select;

  prefsDatum({
    this.id,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.icon,
    this.isActive,
    this.is_select,
  });

  factory prefsDatum.fromJson(Map<String, dynamic> json) => prefsDatum(
    id: json["_id"],
    title: json["title"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    icon: json["icon"],
    isActive: json["is_active"],
    is_select: json["is_select"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "icon": icon,
    "is_active": isActive,
    "is_select": is_select,
  };
}
