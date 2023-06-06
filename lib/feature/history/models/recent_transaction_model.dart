// To parse this JSON data, do
//
//     final recentTransactionModel = recentTransactionModelFromJson(jsonString);

import 'dart:convert';

List<RecentTransactionModel> recentTransactionModelFromJson(String str) =>
    List<RecentTransactionModel>.from(
        json.decode(str).map((x) => RecentTransactionModel.fromJson(x)));

String recentTransactionModelToJson(List<RecentTransactionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecentTransactionModel {
  int amount;
  String service;
  String serviceTo;
  String accountNumber;
  String transactionIdentifier;
  DateTime date;
  String status;
  dynamic airlinesPdfUrl;
  dynamic sessionId;
  int id;
  DateTime createdDate;
  String destination;
  int charge;
  int totalAmount;
  RequestDetail requestDetail;
  ResponseDetail responseDetail;
  String iconUrl;

  RecentTransactionModel({
    required this.amount,
    required this.service,
    required this.serviceTo,
    required this.accountNumber,
    required this.transactionIdentifier,
    required this.date,
    required this.status,
    this.airlinesPdfUrl,
    this.sessionId,
    required this.id,
    required this.createdDate,
    required this.destination,
    required this.charge,
    required this.totalAmount,
    required this.requestDetail,
    required this.responseDetail,
    required this.iconUrl,
  });

  factory RecentTransactionModel.fromJson(Map<String, dynamic> json) =>
      RecentTransactionModel(
        amount: json["amount"],
        service: json["service"],
        serviceTo: json["serviceTo"],
        accountNumber: json["accountNumber"],
        transactionIdentifier: json["transactionIdentifier"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        airlinesPdfUrl: json["airlinesPdfUrl"],
        sessionId: json["sessionId"],
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        destination: json["destination"],
        charge: json["charge"],
        totalAmount: json["totalAmount"],
        requestDetail: RequestDetail.fromJson(json["requestDetail"]),
        responseDetail: ResponseDetail.fromJson(json["responseDetail"]),
        iconUrl: json["iconUrl"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "service": service,
        "serviceTo": serviceTo,
        "accountNumber": accountNumber,
        "transactionIdentifier": transactionIdentifier,
        "date": date.toIso8601String(),
        "status": status,
        "airlinesPdfUrl": airlinesPdfUrl,
        "sessionId": sessionId,
        "id": id,
        "createdDate": createdDate.toIso8601String(),
        "destination": destination,
        "charge": charge,
        "totalAmount": totalAmount,
        "requestDetail": requestDetail.toJson(),
        "responseDetail": responseDetail.toJson(),
        "iconUrl": iconUrl,
      };
}

class RequestDetail {
  String? destinationBankId;
  String? destinationBranchName;
  String? destinationAccountNumber;
  String? destinationBankName;
  String? destinationAccountName;
  String? customerAddress;
  String? amount;
  String? mobileNumber;
  String? serviceId;
  String? serviceTo;

  RequestDetail({
    this.destinationBankId,
    this.destinationBranchName,
    this.destinationAccountNumber,
    this.destinationBankName,
    this.destinationAccountName,
    this.customerAddress,
    this.amount,
    this.mobileNumber,
    this.serviceId,
    this.serviceTo,
  });

  factory RequestDetail.fromJson(Map<String, dynamic> json) => RequestDetail(
        destinationBankId: json["destinationBankId"],
        destinationBranchName: json["destinationBranchName"],
        destinationAccountNumber: json["destinationAccountNumber"],
        destinationBankName: json["destinationBankName"],
        destinationAccountName: json["destinationAccountName"],
        customerAddress: json["customer_address"],
        amount: json["amount"],
        mobileNumber: json["mobile_number"],
        serviceId: json["serviceId"],
        serviceTo: json["serviceTo"],
      );

  Map<String, dynamic> toJson() => {
        "destinationBankId": destinationBankId,
        "destinationBranchName": destinationBranchName,
        "destinationAccountNumber": destinationAccountNumber,
        "destinationBankName": destinationBankName,
        "destinationAccountName": destinationAccountName,
        "customer_address": customerAddress,
        "amount": amount,
        "mobile_number": mobileNumber,
        "serviceId": serviceId,
        "serviceTo": serviceTo,
      };
}

class ResponseDetail {
  String? code;
  String status;
  String? resultMessage;
  String? serviceTo;
  String? isoCode;
  String? transactionIdentifier;

  ResponseDetail({
    this.code,
    required this.status,
    this.resultMessage,
    this.serviceTo,
    this.isoCode,
    this.transactionIdentifier,
  });

  factory ResponseDetail.fromJson(Map<String, dynamic> json) => ResponseDetail(
        code: json["code"],
        status: json["status"],
        resultMessage: json["Result Message"],
        serviceTo: json["serviceTo"],
        isoCode: json["isoCode"],
        transactionIdentifier: json["transactionIdentifier"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "Result Message": resultMessage,
        "serviceTo": serviceTo,
        "isoCode": isoCode,
        "transactionIdentifier": transactionIdentifier,
      };
}
