import 'package:ismart/feature/update/model/update.dart';

class AppUpdate {
  Update android;
  Update ios;

  AppUpdate({
    required this.android,
    required this.ios,
  });

  factory AppUpdate.fromJson(Map<String, dynamic> json) {
    return AppUpdate(
      android: Update.fromJson(json["android"] ?? {}),
      ios: Update.fromJson(json["ios"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ios'] = ios.toJson();
    data['android'] = android.toJson();
    return data;
  }
}
