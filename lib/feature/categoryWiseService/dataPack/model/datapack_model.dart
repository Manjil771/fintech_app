// To parse this JSON data, do
//
//     final datapackModel = datapackModelFromJson(jsonString);

class Package {
  String code;
  String name;
  String description;
  String validity;
  double amount;
  String category;
  dynamic subscriberType;
  String imagePath;

  Package({
    required this.code,
    required this.name,
    required this.description,
    required this.validity,
    required this.amount,
    required this.category,
    this.subscriberType,
    required this.imagePath,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        code: json["code"],
        name: json["name"],
        description: json["description"],
        validity: json["validity"] ?? '',
        amount: json["amount"]?.toDouble(),
        category: json["category"] ?? '',
        subscriberType: json["subscriberType"] ?? '',
        imagePath: json["imagePath"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "description": description,
        "validity": validity,
        "amount": amount,
        "category": category,
        "subscriberType": subscriberType,
        "imagePath": imagePath,
      };
}
