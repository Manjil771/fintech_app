class WalletTransferModel {
  final String status;
  final String code;
  final String message;
  // final Details details;
  final dynamic detail;

  WalletTransferModel({
    required this.status,
    required this.code,
    required this.message,
    // required this.details,
    required this.detail,
  });

  factory WalletTransferModel.fromJson(Map<String, dynamic> json) =>
      WalletTransferModel(
        status: json["status"] ?? "",
        code: json["code"] ?? "",
        message: json["message"] ?? "",
        // details: Details.fromJson(json["details"]),
        detail: json["detail"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        // "details": details.toJson(),
        "detail": detail,
      };
}
