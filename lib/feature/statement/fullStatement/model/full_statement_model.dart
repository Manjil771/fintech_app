class FullStatementModel {
  double? openingBalance;
  double? closingBalance;
  String? fromDate;
  String? toDate;
  String? accountNumber;
  String? accountType;
  String? address;
  Null? pdfUrl;
  List<AccountStatementDtos>? accountStatementDtos;
  String? accountName;

  FullStatementModel(
      {this.openingBalance,
      this.closingBalance,
      this.fromDate,
      this.toDate,
      this.accountNumber,
      this.accountType,
      this.address,
      this.pdfUrl,
      this.accountStatementDtos,
      this.accountName});

  FullStatementModel.fromJson(Map<String, dynamic> json) {
    openingBalance = json['openingBalance'];
    closingBalance = json['closingBalance'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    accountNumber = json['accountNumber'];
    accountType = json['accountType'];
    address = json['address'];
    pdfUrl = json['pdfUrl'];
    if (json['accountStatementDtos'] != null) {
      accountStatementDtos = <AccountStatementDtos>[];
      json['accountStatementDtos'].forEach((v) {
        accountStatementDtos!.add(new AccountStatementDtos.fromJson(v));
      });
    }
    accountName = json['accountName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['openingBalance'] = this.openingBalance;
    data['closingBalance'] = this.closingBalance;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['accountNumber'] = this.accountNumber;
    data['accountType'] = this.accountType;
    data['address'] = this.address;
    data['pdfUrl'] = this.pdfUrl;
    if (this.accountStatementDtos != null) {
      data['accountStatementDtos'] =
          this.accountStatementDtos!.map((v) => v.toJson()).toList();
    }
    data['accountName'] = this.accountName;
    return data;
  }
}

class AccountStatementDtos {
  String? transactionDate;
  String? remarks;
  double? debit;
  double? credit;
  double? balance;

  AccountStatementDtos(
      {this.transactionDate,
      this.remarks,
      this.debit,
      this.credit,
      this.balance});

  AccountStatementDtos.fromJson(Map<String, dynamic> json) {
    transactionDate = json['transactionDate'];
    remarks = json['remarks'];
    debit = json['debit'];
    credit = json['credit'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionDate'] = this.transactionDate;
    data['remarks'] = this.remarks;
    data['debit'] = this.debit;
    data['credit'] = this.credit;
    data['balance'] = this.balance;
    return data;
  }
}
