// To parse this JSON data, do
//
//     final creditCardBankList = creditCardBankListFromJson(jsonString);

import 'dart:convert';

List<CreditCardBankList> creditCardBankListFromJson(String str) =>
    List<CreditCardBankList>.from(
        json.decode(str).map((x) => CreditCardBankList.fromJson(x)));

String creditCardBankListToJson(List<CreditCardBankList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CreditCardBankList {
  String bankCode;
  String bankName;
  dynamic bankLogo;

  CreditCardBankList({
    required this.bankCode,
    required this.bankName,
    this.bankLogo,
  });

  factory CreditCardBankList.fromJson(Map<String, dynamic> json) =>
      CreditCardBankList(
        bankCode: json["bankCode"],
        bankName: json["bankName"],
        bankLogo: json["bankLogo"],
      );

  Map<String, dynamic> toJson() => {
        "bankCode": bankCode,
        "bankName": bankName,
        "bankLogo": bankLogo,
      };
}
