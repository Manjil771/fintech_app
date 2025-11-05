class RemittanceDetail {
  int id;
  String pinNo;
  dynamic user;
  String payTokenId;
  int remittanceId;
  String agentSessionId;
  int amount;
  String senderName;
  dynamic agentName;
  String senderCountry;
  DateTime date;
  String status;
  String payType;
  String receiverName;
  String receiverAddress;
  String receiverMobileNumber;

  RemittanceDetail({
    required this.id,
    required this.pinNo,
    required this.user,
    required this.payTokenId,
    required this.remittanceId,
    required this.agentSessionId,
    required this.amount,
    required this.senderName,
    required this.agentName,
    required this.senderCountry,
    required this.date,
    required this.status,
    required this.payType,
    required this.receiverName,
    required this.receiverAddress,
    required this.receiverMobileNumber,
  });

  factory RemittanceDetail.fromJson(Map<String, dynamic> json) =>
      RemittanceDetail(
        id: json["id"],
        pinNo: json["pinNo"] ?? '',
        user: json["user"] ?? '',
        payTokenId: json["payTokenId"] ?? '',
        remittanceId: json["remittanceId"] ?? '',
        agentSessionId: json["agentSessionId"] ?? '',
        amount: json["amount"] ?? '',
        senderName: json["senderName"] ?? '',
        agentName: json["agentName"] ?? '',
        senderCountry: json["senderCountry"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        payType: json["payType"],
        receiverName: json["receiverName"],
        receiverAddress: json["receiverAddress"],
        receiverMobileNumber: json["receiverMobileNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pinNo": pinNo,
        "user": user,
        "payTokenId": payTokenId,
        "remittanceId": remittanceId,
        "agentSessionId": agentSessionId,
        "amount": amount,
        "senderName": senderName,
        "agentName": agentName,
        "senderCountry": senderCountry,
        "date": date.toIso8601String(),
        "status": status,
        "payType": payType,
        "receiverName": receiverName,
        "receiverAddress": receiverAddress,
        "receiverMobileNumber": receiverMobileNumber,
      };
}
