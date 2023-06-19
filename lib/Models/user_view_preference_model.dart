// To parse this JSON data, do
//
//     final userViewPreferenceModel = userViewPreferenceModelFromJson(jsonString);

import 'dart:convert';

UserViewPreferenceModel userViewPreferenceModelFromJson(String str) => UserViewPreferenceModel.fromJson(json.decode(str));

String userViewPreferenceModelToJson(UserViewPreferenceModel data) => json.encode(data.toJson());

class UserViewPreferenceModel {
  int? status;
  String? message;
  List<PrefsDatum>? data;

  UserViewPreferenceModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserViewPreferenceModel.fromJson(Map<String, dynamic> json) => UserViewPreferenceModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<PrefsDatum>.from(json["data"]!.map((x) => PrefsDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PrefsDatum {
  String? id;
  String? preference;

  PrefsDatum({
    this.id,
    this.preference,
  });

  factory PrefsDatum.fromJson(Map<String, dynamic> json) => PrefsDatum(
    id: json["_id"],
    preference: json["preference"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "preference": preference,
  };
}
