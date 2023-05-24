import 'package:ismart/common/models/key_value.dart';
import 'package:ismart/common/util/parse_utils.dart';

class UtilityResponseData {
  final String status;
  final String code;
  final String message;
  final List<KeyValue> details;

  UtilityResponseData({
    required this.status,
    required this.code,
    required this.message,
    required this.details,
  });

  factory UtilityResponseData.fromJson(Map<String, dynamic> json) =>
      UtilityResponseData(
        status: json["status"] ?? "",
        code: json["code"] ?? "",
        message: json["message"] ?? "",
        details: ParseUtils.parseKeyValue(json['details']),
      );

  T? findValue<T>({required String primaryKey, String? secondaryKey}) {
    final _index = details.indexWhere(
        (e) => e.title == primaryKey && (T is dynamic ? true : e.value is T));
    if (_index == -1) {
      return null;
    } else {
      if (secondaryKey != null) {
        return details[_index].value[secondaryKey] ?? "";
      }
      return details[_index].value;
    }
  }

  String findValueString(String primaryKey, {String emptyString = "-"}) {
    final _index = details.indexWhere((e) => e.title == primaryKey);
    if (_index == -1) {
      return emptyString;
    } else {
      return details[_index].value.toString();
    }
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "details": details,
      };
}
