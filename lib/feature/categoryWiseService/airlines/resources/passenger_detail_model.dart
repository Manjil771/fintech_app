// To parse this JSON data, do
//
//     final passengerDetailModel = passengerDetailModelFromJson(jsonString);

import 'dart:convert';

List<PassengerDetailModel> passengerDetailModelFromJson(String str) =>
    List<PassengerDetailModel>.from(
        json.decode(str).map((x) => PassengerDetailModel.fromJson(x)));

String passengerDetailModelToJson(List<PassengerDetailModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PassengerDetailModel {
  String firstname;
  String lastname;
  PassengerType type;
  String title;
  String gender;
  String remarks;
  String nationality;
  PassengerDetailModel({
    required this.firstname,
    required this.lastname,
    required this.type,
    required this.title,
    required this.gender,
    required this.remarks,
    required this.nationality,
  });

  factory PassengerDetailModel.fromJson(Map<String, dynamic> json) =>
      PassengerDetailModel(
        firstname: json["firstname"],
        lastname: json["lastname"],
        type: json["paxType"],
        title: json["title"],
        gender: json["gender"],
        remarks: json["paxRemarks"],
        nationality: json["nationality"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "type": type,
        "title": title,
        "gender": gender,
        "nationality": nationality,
        "paxRemarks": remarks,
      };
}

enum PassengerType {
  adult,
  child,
  infant,
}
