// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

PhoneLoginModel phoneLoginModelFromJson(String str) {
  final jsonData = json.decode(str);
  return PhoneLoginModel.fromJson(jsonData);
}

String phoneLoginModelToJson(PhoneLoginModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class PhoneLoginModel {
  int? status;
  String? massege;
  String? data;

  PhoneLoginModel({
    this.status,
    this.massege,
    this.data,
  });

  factory PhoneLoginModel.fromJson(Map<String, dynamic> json) => new PhoneLoginModel(
    status: json["status"] == null ? null : json["status"],
    massege: json["massege"] == null ? null : json["massege"],
    data: json["data"] == null ? null : json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "massege": massege == null ? null : massege,
    "data": data == null ? null : data,
  };
}
