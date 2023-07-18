// To parse this JSON data, do
//
//     final casteModel = casteModelFromJson(jsonString);

import 'dart:convert';

CasteModel casteModelFromJson(String str) => CasteModel.fromJson(json.decode(str));

String casteModelToJson(CasteModel data) => json.encode(data.toJson());

class CasteModel {
  bool? status;
  String? message;
  List<CasteDatum>? data;

  CasteModel({
    this.status,
    this.message,
    this.data,
  });

  factory CasteModel.fromJson(Map<String, dynamic> json) => CasteModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<CasteDatum>.from(json["data"]!.map((x) => CasteDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CasteDatum {
  String? caste;

  CasteDatum({
    this.caste,
  });

  factory CasteDatum.fromJson(Map<String, dynamic> json) => CasteDatum(
    caste: json["caste"],
  );

  Map<String, dynamic> toJson() => {
    "caste": caste,
  };
}
