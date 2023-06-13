// To parse this JSON data, do
//

class ServicesModel {
  ServicesModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.uniqueIdentifier,
    required this.isNew,
    required this.appOrder,
  });
  late final int id;
  late final String name;
  late final String imageUrl;
  late final String uniqueIdentifier;
  late final bool isNew;
  late final int appOrder;

  ServicesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'] ?? "";
    uniqueIdentifier = json['uniqueIdentifier'] ?? "";
    isNew = json['isNew'];
    appOrder = json['appOrder'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['imageUrl'] = imageUrl;
    _data['uniqueIdentifier'] = uniqueIdentifier;
    _data['isNew'] = isNew;
    _data['appOrder'] = appOrder;
    return _data;
  }
}





//     final serviceModel = serviceModelFromJson(jsonString);
// class ServiceModel {
//   String? status;
//   String? code;
//   String? message;
//   List<Details>? details;
//   Null? detail;

//   ServiceModel(
//       {this.status, this.code, this.message, this.details, this.detail});

//   ServiceModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     code = json['code'];
//     message = json['message'];
//     if (json['details'] != null) {
//       details = <Details>[];
//       json['details'].forEach((v) {
//         details!.add(new Details.fromJson(v));
//       });
//     }
//     detail = json['detail'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['status'] = status;
//     data['code'] = code;
//     data['message'] = message;
//     if (details != null) {
//       data['details'] = details!.map((v) => v.toJson()).toList();
//     }
//     data['detail'] = detail;
//     return data;
//   }
// }

// class Details {
//   int? id;
//   String? name;
//   String? imageUrl;
//   String? uniqueIdentifier;
//   bool? isNew;
//   int? appOrder;
//   List<Services>? services;

//   Details(
//       {this.id,
//       this.name,
//       this.imageUrl,
//       this.uniqueIdentifier,
//       this.isNew,
//       this.appOrder,
//       this.services});

//   Details.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     imageUrl = json['imageUrl'];
//     uniqueIdentifier = json['uniqueIdentifier'];
//     isNew = json['isNew'];
//     appOrder = json['appOrder'];
//     if (json['services'] != null) {
//       services = <Services>[];
//       json['services'].forEach((v) {
//         services!.add(new Services.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['imageUrl'] = this.imageUrl;
//     data['uniqueIdentifier'] = this.uniqueIdentifier;
//     data['isNew'] = this.isNew;
//     data['appOrder'] = this.appOrder;
//     if (this.services != null) {
//       data['services'] = this.services!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Services {
//   int? id;
//   String? url;
//   String? uniqueIdentifier;
//   String? service;
//   String? status;
//   String? labelName;
//   String? labelMaxLength;
//   String? labelMinLength;
//   String? labelSample;
//   String? labelPrefix;
//   String? instructions;
//   bool? fixedlabelSize;
//   bool? priceInput;
//   String? notificationUrl;
//   int? minValue;
//   double? maxValue;
//   String? icon;
//   int? categoryId;
//   String? serviceCategoryName;
//   bool? webView;
//   bool? isNew;
//   int? appOrder;
//   bool? isSmsMode;
//   String? cashBackView;
//   String? labelSize;
//   String? priceRange;

//   Services(
//       {this.id,
//       this.url,
//       this.uniqueIdentifier,
//       this.service,
//       this.status,
//       this.labelName,
//       this.labelMaxLength,
//       this.labelMinLength,
//       this.labelSample,
//       this.labelPrefix,
//       this.instructions,
//       this.fixedlabelSize,
//       this.priceInput,
//       this.notificationUrl,
//       this.minValue,
//       this.maxValue,
//       this.icon,
//       this.categoryId,
//       this.serviceCategoryName,
//       this.webView,
//       this.isNew,
//       this.appOrder,
//       this.isSmsMode,
//       this.cashBackView,
//       this.labelSize,
//       this.priceRange});

//   Services.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     url = json['url'];
//     uniqueIdentifier = json['uniqueIdentifier'];
//     service = json['service'];
//     status = json['status'];
//     labelName = json['labelName'];
//     labelMaxLength = json['labelMaxLength'];
//     labelMinLength = json['labelMinLength'];
//     labelSample = json['labelSample'];
//     labelPrefix = json['labelPrefix'];
//     instructions = json['instructions'];
//     fixedlabelSize = json['fixedlabelSize'];
//     priceInput = json['priceInput'];
//     notificationUrl = json['notificationUrl'];
//     minValue = json['minValue'];
//     maxValue = json['maxValue'];
//     icon = json['icon'];
//     categoryId = json['categoryId'];
//     serviceCategoryName = json['serviceCategoryName'];
//     webView = json['webView'];
//     isNew = json['isNew'];
//     appOrder = json['appOrder'];
//     isSmsMode = json['isSmsMode'];
//     cashBackView = json['cashBackView'];
//     labelSize = json['labelSize'];
//     priceRange = json['priceRange'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['url'] = this.url;
//     data['uniqueIdentifier'] = this.uniqueIdentifier;
//     data['service'] = this.service;
//     data['status'] = this.status;
//     data['labelName'] = this.labelName;
//     data['labelMaxLength'] = this.labelMaxLength;
//     data['labelMinLength'] = this.labelMinLength;
//     data['labelSample'] = this.labelSample;
//     data['labelPrefix'] = this.labelPrefix;
//     data['instructions'] = this.instructions;
//     data['fixedlabelSize'] = this.fixedlabelSize;
//     data['priceInput'] = this.priceInput;
//     data['notificationUrl'] = this.notificationUrl;
//     data['minValue'] = this.minValue;
//     data['maxValue'] = this.maxValue;
//     data['icon'] = this.icon;
//     data['categoryId'] = this.categoryId;
//     data['serviceCategoryName'] = this.serviceCategoryName;
//     data['webView'] = this.webView;
//     data['isNew'] = this.isNew;
//     data['appOrder'] = this.appOrder;
//     data['isSmsMode'] = this.isSmsMode;
//     data['cashBackView'] = this.cashBackView;
//     data['labelSize'] = this.labelSize;
//     data['priceRange'] = this.priceRange;
//     return data;
//   }
// }

/////new model
// import 'dart:convert';

// ServiceModel serviceModelFromJson(String str) =>
//     ServiceModel.fromJson(json.decode(str));

// String serviceModelToJson(ServiceModel data) => json.encode(data.toJson());

// class ServiceModel {
//   String status;
//   String code;
//   String message;
//   List<Detail> details;
//   dynamic detail;

//   ServiceModel({
//     required this.status,
//     required this.code,
//     required this.message,
//     required this.details,
//     this.detail,
//   });

//   factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
//         status: json["status"] ?? "",
//         code: json["code"] ?? "",
//         message: json["message"] ?? "",
//         details: List.from(json['services'] ?? [])
//             .map((e) => Detail.fromJson(e))
//             .toList(),
//         // List.from(json["services"] ?? []).map((x) => Detail.fromJson(x))),
//         detail: json["detail"],
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "code": code,
//         "message": message,
//         "details": List<dynamic>.from(details.map((x) => x.toJson())),
//         "detail": detail,
//       };
// }

// class Detail {
//   int id;
//   String name;
//   String imageUrl;
//   String uniqueIdentifier;
//   bool isNew;
//   int appOrder;
//   List<Service> services;

//   Detail({
//     required this.id,
//     required this.name,
//     required this.imageUrl,
//     required this.uniqueIdentifier,
//     required this.isNew,
//     required this.appOrder,
//     required this.services,
//   });

//   factory Detail.fromJson(Map<String, dynamic> json) => Detail(
//         id: json["id"],
//         name: json["name"] ?? "",
//         imageUrl: json["imageUrl"] ?? "",
//         uniqueIdentifier: json["uniqueIdentifier"],
//         isNew: json["isNew"],
//         appOrder: json["appOrder"],
//         services: List.from(json["services"] ?? [])
//             .map((x) => Service.fromJson(x))
//             .toList(),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "imageUrl": imageUrl,
//         "uniqueIdentifier": uniqueIdentifier,
//         "isNew": isNew,
//         "appOrder": appOrder,
//         "services": List<dynamic>.from(services.map((x) => x.toJson())),
//       };
// }

// class Service {
//   int id;
//   Url url;
//   String uniqueIdentifier;
//   String service;
//   Status status;
//   String? labelName;
//   String? labelMaxLength;
//   String? labelMinLength;
//   String? labelSample;
//   String? labelPrefix;
//   String instructions;
//   bool fixedlabelSize;
//   bool priceInput;
//   String? notificationUrl;
//   int? minValue;
//   double? maxValue;
//   String? icon;
//   int categoryId;
//   String serviceCategoryName;
//   bool webView;
//   bool isNew;
//   int appOrder;
//   bool isSmsMode;
//   String? cashBackView;
//   String? labelSize;
//   String? priceRange;

//   Service({
//     required this.id,
//     required this.url,
//     required this.uniqueIdentifier,
//     required this.service,
//     required this.status,
//     this.labelName,
//     this.labelMaxLength,
//     this.labelMinLength,
//     this.labelSample,
//     this.labelPrefix,
//     required this.instructions,
//     required this.fixedlabelSize,
//     required this.priceInput,
//     this.notificationUrl,
//     this.minValue,
//     this.maxValue,
//     this.icon,
//     required this.categoryId,
//     required this.serviceCategoryName,
//     required this.webView,
//     required this.isNew,
//     required this.appOrder,
//     required this.isSmsMode,
//     this.cashBackView,
//     this.labelSize,
//     this.priceRange,
//   });

//   factory Service.fromJson(Map<String, dynamic> json) => Service(
//         id: json["id"],
//         url: urlValues.map[json["url"]]!,
//         uniqueIdentifier: json["uniqueIdentifier"],
//         service: json["service"],
//         status: statusValues.map[json["status"]]!,
//         labelName: json["labelName"],
//         labelMaxLength: json["labelMaxLength"],
//         labelMinLength: json["labelMinLength"],
//         labelSample: json["labelSample"],
//         labelPrefix: json["labelPrefix"],
//         instructions: json["instructions"],
//         fixedlabelSize: json["fixedlabelSize"],
//         priceInput: json["priceInput"],
//         notificationUrl: json["notificationUrl"],
//         minValue: json["minValue"],
//         maxValue: json["maxValue"]?.toDouble(),
//         icon: json["icon"],
//         categoryId: json["categoryId"],
//         serviceCategoryName: json["serviceCategoryName"],
//         webView: json["webView"],
//         isNew: json["isNew"],
//         appOrder: json["appOrder"],
//         isSmsMode: json["isSmsMode"],
//         cashBackView: json["cashBackView"],
//         labelSize: json["labelSize"],
//         priceRange: json["priceRange"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "url": urlValues.reverse[url],
//         "uniqueIdentifier": uniqueIdentifier,
//         "service": service,
//         "status": statusValues.reverse[status],
//         "labelName": labelName,
//         "labelMaxLength": labelMaxLength,
//         "labelMinLength": labelMinLength,
//         "labelSample": labelSample,
//         "labelPrefix": labelPrefix,
//         "instructions": instructions,
//         "fixedlabelSize": fixedlabelSize,
//         "priceInput": priceInput,
//         "notificationUrl": notificationUrl,
//         "minValue": minValue,
//         "maxValue": maxValue,
//         "icon": icon,
//         "categoryId": categoryId,
//         "serviceCategoryName": serviceCategoryName,
//         "webView": webView,
//         "isNew": isNew,
//         "appOrder": appOrder,
//         "isSmsMode": isSmsMode,
//         "cashBackView": cashBackView,
//         "labelSize": labelSize,
//         "priceRange": priceRange,
//       };
// }

// enum Status { ACTIVE, Success }

// final statusValues = EnumValues({"Active": Status.ACTIVE});

// enum Url { GENERAL_MERCHANT_PAYMENT, URL, URL_URL }

// final urlValues = EnumValues({
//   "generalMerchantPayment": Url.GENERAL_MERCHANT_PAYMENT,
//   "url": Url.URL,
//   "URL": Url.URL_URL
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
