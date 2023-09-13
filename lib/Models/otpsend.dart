// To parse this JSON data, do
//
//     final otpSend = otpSendFromJson(jsonString);

import 'dart:convert';

OtpSend otpSendFromJson(String str) => OtpSend.fromJson(json.decode(str));

String otpSendToJson(OtpSend data) => json.encode(data.toJson());

class OtpSend {
  int? status;
  String? message;
  String? massege;
  String? data;

  OtpSend({
    this.status,
    this.message,
    this.massege,
    this.data,
  });

  factory OtpSend.fromJson(Map<String, dynamic> json) => OtpSend(
    status: json["status"],
    message: json["message"],
    massege: json["massege"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "massege": massege,
    "data": data,
  };
}
