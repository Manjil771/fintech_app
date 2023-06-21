class AppServiceManagementModel {
  String name;
  String uniqueIdentifier;
  Type type;
  String status;
  String? imageUrl;
  int appOrder;
  bool detailNew;

  AppServiceManagementModel({
    required this.name,
    required this.uniqueIdentifier,
    required this.type,
    required this.status,
    this.imageUrl,
    required this.appOrder,
    required this.detailNew,
  });

  factory AppServiceManagementModel.fromJson(Map<String, dynamic> json) =>
      AppServiceManagementModel(
        name: json["name"],
        uniqueIdentifier: json["uniqueIdentifier"],
        type: typeValues.map[json["type"]]!,
        status: json["status"]!,
        imageUrl: json["imageUrl"],
        appOrder: json["appOrder"],
        detailNew: json["new"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "uniqueIdentifier": uniqueIdentifier,
        "type": typeValues.reverse[type],
        "status": status,
        "imageUrl": imageUrl,
        "appOrder": appOrder,
        "new": detailNew,
      };
}

enum Type { BANKING, DASHBOARD, QR_ICON, FEATURE }

final typeValues = EnumValues({
  "banking": Type.BANKING,
  "dashboard": Type.DASHBOARD,
  "feature": Type.FEATURE,
  "qrIcon": Type.QR_ICON
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
