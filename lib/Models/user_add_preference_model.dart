// To parse this JSON data, do
//
//     final addPreferenceModel = addPreferenceModelFromJson(jsonString);

import 'dart:convert';

AddPreferenceModel addPreferenceModelFromJson(String str) => AddPreferenceModel.fromJson(json.decode(str));

String addPreferenceModelToJson(AddPreferenceModel data) => json.encode(data.toJson());

class AddPreferenceModel {
  int? status;
  String? message;
  // Data? data;

  AddPreferenceModel({
    this.status,
    this.message,
    // this.data,
  });

  factory AddPreferenceModel.fromJson(Map<String, dynamic> json) => AddPreferenceModel(
    status: json["status"],
    message: json["message"],
    // data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    // "data": data!.toJson(),
  };
}

// class Data {
//   String? userId;
//   String? preferenceId;
//   String? id;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;
//
//   Data({
//     this.userId,
//     this.preferenceId,
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     userId: json["userId"],
//     preferenceId: json["preferenceId"],
//     id: json["_id"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     updatedAt: DateTime.parse(json["updatedAt"]),
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "userId": userId,
//     "preferenceId": preferenceId,
//     "_id": id,
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//     "__v": v,
//   };
// }
