class AirlinesSectorList {
  String? sectorCode;
  String? sectorName;

  AirlinesSectorList({this.sectorCode, this.sectorName});

  AirlinesSectorList.fromJson(Map<String, dynamic> json) {
    sectorCode = json['sectorCode'];
    sectorName = json['sectorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sectorCode'] = this.sectorCode;
    data['sectorName'] = this.sectorName;
    return data;
  }
}
