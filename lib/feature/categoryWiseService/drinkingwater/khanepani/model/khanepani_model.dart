// To parse this JSON data, do
//
//     final khanePaniModel = khanePaniModelFromJson(jsonString);

import 'dart:convert';

KhanePaniModel khanePaniModelFromJson(String str) =>
    KhanePaniModel.fromJson(json.decode(str));

String khanePaniModelToJson(KhanePaniModel data) => json.encode(data.toJson());

class KhanePaniModel {
  String status;
  String code;
  String message;
  List<Detail> details;
  dynamic detail;

  KhanePaniModel({
    required this.status,
    required this.code,
    required this.message,
    required this.details,
    this.detail,
  });

  factory KhanePaniModel.fromJson(Map<String, dynamic> json) => KhanePaniModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
        "detail": detail,
      };
}

class Detail {
  String name;
  String value;

  Detail({
    required this.name,
    required this.value,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
