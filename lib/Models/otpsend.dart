// To parse this JSON data, do
//
//     final otpSend = otpSendFromJson(jsonString);

import 'dart:convert';

OtpSend otpSendFromJson(String str) => OtpSend.fromJson(json.decode(str));

String otpSendToJson(OtpSend data) => json.encode(data.toJson());

class OtpSend {
  int? status;
  String? message;
  String? data;

  OtpSend({
    this.status,
    this.message,
    this.data,
  });

  factory OtpSend.fromJson(Map<String, dynamic> json) => OtpSend(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
