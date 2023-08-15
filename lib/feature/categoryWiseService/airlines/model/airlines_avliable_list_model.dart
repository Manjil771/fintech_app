
// To parse this JSON data, do
//
//     final availableFlightModel = availableFlightModelFromJson(jsonString);

import 'dart:convert';

AvailableFlightModel availableFlightModelFromJson(String str) =>
    AvailableFlightModel.fromJson(json.decode(str));

String availableFlightModelToJson(AvailableFlightModel data) =>
    json.encode(data.toJson());

class AvailableFlightModel {
  String responseStatus;
  String message;
  dynamic refresh;
  Detail detail;
  dynamic details;
  String status;

  AvailableFlightModel({
    required this.responseStatus,
    required this.message,
    this.refresh,
    required this.detail,
    this.details,
    required this.status,
  });

  factory AvailableFlightModel.fromJson(Map<String, dynamic> json) =>
      AvailableFlightModel(
        responseStatus: json["responseStatus"],
        message: json["message"],
        refresh: json["refresh"],
        detail: Detail.fromJson(json["detail"]),
        details: json["details"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "responseStatus": responseStatus,
        "message": message,
        "refresh": refresh,
        "detail": detail.toJson(),
        "details": details,
        "status": status,
      };
}

class Detail {
  FlightAvailability flightAvailability;

  Detail({
    required this.flightAvailability,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        flightAvailability:
            FlightAvailability.fromJson(json["flightAvailability"]),
      );

  Map<String, dynamic> toJson() => {
        "flightAvailability": flightAvailability.toJson(),
      };
}

class FlightAvailability {
  Bound outbound;
  Bound inbound;

  FlightAvailability({
    required this.outbound,
    required this.inbound,
  });

  factory FlightAvailability.fromJson(Map<String, dynamic> json) =>
      FlightAvailability(
        outbound: Bound.fromJson(json["outbound"]),
        inbound: Bound.fromJson(json["inbound"]),
      );

  Map<String, dynamic> toJson() => {
        "outbound": outbound.toJson(),
        "inbound": inbound.toJson(),
      };
}

class Bound {
  List<Availability> availability;

  Bound({
    required this.availability,
  });

  factory Bound.fromJson(Map<String, dynamic> json) => Bound(
        availability: List<Availability>.from(
            json["availability"].map((x) => Availability.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "availability": List<dynamic>.from(availability.map((x) => x.toJson())),
      };
}

class Availability {
  String airline;
  String airlineLogo;
  DateTime flightDate;
  String flightNo;
  String departure;
  String departureTime;
  String arrival;
  String arrivalTime;
  String aircraftType;
  String adult;
  String child;
  String infant;
  String flightId;
  String flightClassCode;
  String currency;
  String adultFare;
  String childFare;
  String infantFare;
  String resFare;
  String fuelSurcharge;
  String tax;
  String refundable;
  String freeBaggage;
  String agencyCommission;
  String childCommission;
  dynamic callingStationId;
  dynamic callingStation;
  String airlineImage;
  double totalFare;
  dynamic cashBack;

  Availability({
    required this.airline,
    required this.airlineLogo,
    required this.flightDate,
    required this.flightNo,
    required this.departure,
    required this.departureTime,
    required this.arrival,
    required this.arrivalTime,
    required this.aircraftType,
    required this.adult,
    required this.child,
    required this.infant,
    required this.flightId,
    required this.flightClassCode,
    required this.currency,
    required this.adultFare,
    required this.childFare,
    required this.infantFare,
    required this.resFare,
    required this.fuelSurcharge,
    required this.tax,
    required this.refundable,
    required this.freeBaggage,
    required this.agencyCommission,
    required this.childCommission,
    this.callingStationId,
    this.callingStation,
    required this.airlineImage,
    required this.totalFare,
    this.cashBack,
  });

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        airline: json["airline"]!,
        airlineLogo: json["airlineLogo"],
        flightDate: DateTime.parse(json["flightDate"]),
        flightNo: json["flightNo"],
        departure: json["departure"],
        departureTime: json["departureTime"],
        arrival: json["arrival"],
        arrivalTime: json["arrivalTime"],
        aircraftType: json["aircraftType"],
        adult: json["adult"],
        child: json["child"],
        infant: json["infant"],
        flightId: json["flightId"],
        flightClassCode: json["flightClassCode"],
        currency: json["currency"],
        adultFare: json["adultFare"],
        childFare: json["childFare"],
        infantFare: json["infantFare"],
        resFare: json["resFare"],
        fuelSurcharge: json["fuelSurcharge"],
        tax: json["tax"],
        refundable: json["refundable"],
        freeBaggage: json["freeBaggage"],
        agencyCommission: json["agencyCommission"],
        childCommission: json["childCommission"],
        callingStationId: json["callingStationId"],
        callingStation: json["callingStation"],
        airlineImage: json["airlineImage"],
        totalFare: json["totalFare"],
        cashBack: json["cashBack"],
      );

  Map<String, dynamic> toJson() => {
        "airline": airline,
        "airlineLogo": airlineLogo,
        "flightDate":
            "${flightDate.year.toString().padLeft(4, '0')}-${flightDate.month.toString().padLeft(2, '0')}-${flightDate.day.toString().padLeft(2, '0')}",
        "flightNo": flightNo,
        "departure": departure,
        "departureTime": departureTime,
        "arrival": arrival,
        "arrivalTime": arrivalTime,
        "aircraftType": aircraftType,
        "adult": adult,
        "child": child,
        "infant": infant,
        "flightId": flightId,
        "flightClassCode": flightClassCode,
        "currency": currency,
        "adultFare": adultFare,
        "childFare": childFare,
        "infantFare": infantFare,
        "resFare": resFare,
        "fuelSurcharge": fuelSurcharge,
        "tax": tax,
        "refundable": refundable,
        "freeBaggage": freeBaggage,
        "agencyCommission": agencyCommission,
        "childCommission": childCommission,
        "callingStationId": callingStationId,
        "callingStation": callingStation,
        "airlineImage": airlineImage,
        "totalFare": totalFare,
        "cashBack": cashBack,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
