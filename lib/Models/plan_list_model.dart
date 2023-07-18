// To parse this JSON data, do
//
//     final planListModel = planListModelFromJson(jsonString);

import 'dart:convert';

PlanListModel planListModelFromJson(String str) => PlanListModel.fromJson(json.decode(str));

String planListModelToJson(PlanListModel data) => json.encode(data.toJson());

class PlanListModel {
  int? status;
  String? message;
  List<planDatum>? data;

  PlanListModel({
    this.status,
    this.message,
    this.data,
  });

  factory PlanListModel.fromJson(Map<String, dynamic> json) => PlanListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<planDatum>.from(json["data"]!.map((x) => planDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class planDatum {
  Id? id;
  String? name;
  int? price;
  String? validity;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? discountedPrice;
  int? discountePercent;
  bool? isActive;
  String? icon;
  List<Feauture>? feauture;
  String? features;

  planDatum({
    this.id,
    this.name,
    this.price,
    this.validity,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.discountedPrice,
    this.discountePercent,
    this.isActive,
    this.icon,
    this.feauture,
    this.features,
  });

  factory planDatum.fromJson(Map<String, dynamic> json) => planDatum(
    id: idValues.map[json["_id"]]!,
    name: json["name"],
    price: json["price"],
    validity: json["validity"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    discountedPrice: json["discounted_price"],
    discountePercent: json["discountPercentage"],
    isActive: json["is_active"],
    icon: json["icon"],
    feauture: json["feauture"] == null ? [] : List<Feauture>.from(json["feauture"]!.map((x) => Feauture.fromJson(x))),
    features: json["features"],
  );

  Map<String, dynamic> toJson() => {
    "_id": idValues.reverse[id],
    "name": name,
    "price": price,
    "validity": validity,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "discounted_price": discountedPrice,
    "discountPercentage": discountePercent,
    "is_active": isActive,
    "icon": icon,
    "feauture": feauture == null ? [] : List<dynamic>.from(feauture!.map((x) => x.toJson())),
    "features": features,
  };
}

class Feauture {
  String? id;
  String? feature;
  Id? planId;

  Feauture({
    this.id,
    this.feature,
    this.planId,
  });

  factory Feauture.fromJson(Map<String, dynamic> json) => Feauture(
    id: json["_id"],
    feature: json["feature"],
    planId: idValues.map[json["planId"]]!,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "feature": feature,
    "planId": idValues.reverse[planId],
  };
}

enum Id { THE_641_AF90_D6_EDD96_E78793_D26_C, THE_641_C5_A0_DFD268_F15411458_ED, THE_64535_C74_ECCFAC6_D23444_E1_C }

final idValues = EnumValues({
  "641af90d6edd96e78793d26c": Id.THE_641_AF90_D6_EDD96_E78793_D26_C,
  "641c5a0dfd268f15411458ed": Id.THE_641_C5_A0_DFD268_F15411458_ED,
  "64535c74eccfac6d23444e1c": Id.THE_64535_C74_ECCFAC6_D23444_E1_C
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
