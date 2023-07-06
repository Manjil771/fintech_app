// To parse this JSON data, do
//
//     final servicesList = servicesListFromJson(jsonString);

import 'dart:convert';

List<CategoryList> servicesListFromJson(String str) => List<CategoryList>.from(
    json.decode(str).map((x) => CategoryList.fromJson(x)));

String servicesListToJson(List<CategoryList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryList {
  int id;
  String name;
  String imageUrl;
  String uniqueIdentifier;
  bool isNew;
  int appOrder;
  List<Service> services;

  CategoryList({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.uniqueIdentifier,
    required this.isNew,
    required this.appOrder,
    required this.services,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        uniqueIdentifier: json["uniqueIdentifier"],
        isNew: json["isNew"],
        appOrder: json["appOrder"],
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "uniqueIdentifier": uniqueIdentifier,
        "isNew": isNew,
        "appOrder": appOrder,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
      };
}

class Service {
  int id;
  Url url;
  String uniqueIdentifier;
  String service;
  Status status;
  String? labelName;
  String? labelSize;
  String? labelSample;
  String? labelPrefix;
  String instructions;
  bool fixedlabelSize;
  bool priceInput;
  String? notificationUrl;
  double? minValue;
  double? maxValue;
  String? icon;
  int categoryId;
  String serviceCategoryName;
  bool webView;
  bool isNew;
  int appOrder;
  bool isSmsMode;
  String? priceRange;
  String? labelMaxLength;
  String? labelMinLength;
  String? cashBackView;

  Service({
    required this.id,
    required this.url,
    required this.uniqueIdentifier,
    required this.service,
    required this.status,
    this.labelName,
    this.labelSize,
    this.labelSample,
    this.labelPrefix,
    required this.instructions,
    required this.fixedlabelSize,
    required this.priceInput,
    this.notificationUrl,
    this.minValue,
    this.maxValue,
    this.cashBackView,
    this.icon,
    required this.categoryId,
    required this.serviceCategoryName,
    required this.webView,
    required this.isNew,
    required this.appOrder,
    required this.isSmsMode,
    this.priceRange,
    this.labelMaxLength,
    this.labelMinLength,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        url: urlValues.map[json["url"]]!,
        uniqueIdentifier: json["uniqueIdentifier"],
        service: json["service"],
        status: statusValues.map[json["status"]]!,
        labelName: json["labelName"],
        labelSize: json["labelSize"],
        labelSample: json["labelSample"],
        labelPrefix: json["labelPrefix"],
        instructions: json["instructions"],
        fixedlabelSize: json["fixedlabelSize"],
        priceInput: json["priceInput"],
        notificationUrl: json["notificationUrl"],
        minValue: json["minValue"],
        maxValue: json["maxValue"]?.toDouble(),
        icon: json["icon"],
        categoryId: json["categoryId"],
        serviceCategoryName: json["serviceCategoryName"],
        webView: json["webView"],
        isNew: json["isNew"],
        appOrder: json["appOrder"],
        isSmsMode: json["isSmsMode"],
        priceRange: json["priceRange"],
        labelMaxLength: json["labelMaxLength"],
        labelMinLength: json["labelMinLength"],
        cashBackView: json["cashBackView"] ?? "0",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": urlValues.reverse[url],
        "uniqueIdentifier": uniqueIdentifier,
        "service": service,
        "status": statusValues.reverse[status],
        "labelName": labelName,
        "labelSize": labelSize,
        "labelSample": labelSample,
        "labelPrefix": labelPrefix,
        "instructions": instructions,
        "fixedlabelSize": fixedlabelSize,
        "priceInput": priceInput,
        "notificationUrl": notificationUrl,
        "minValue": minValue,
        "maxValue": maxValue,
        "icon": icon,
        "categoryId": categoryId,
        "serviceCategoryName": serviceCategoryName,
        "webView": webView,
        "isNew": isNew,
        "appOrder": appOrder,
        "isSmsMode": isSmsMode,
        "priceRange": priceRange,
        "labelMaxLength": labelMaxLength,
        "labelMinLength": labelMinLength,
        "cashBackView": cashBackView,
      };
}

enum Status { ACTIVE }

final statusValues = EnumValues({"Active": Status.ACTIVE});

enum Url { GENERAL_MERCHANT_PAYMENT, URL, URL_URL }

final urlValues = EnumValues({
  "generalMerchantPayment": Url.GENERAL_MERCHANT_PAYMENT,
  "url": Url.URL,
  "URL": Url.URL_URL
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
