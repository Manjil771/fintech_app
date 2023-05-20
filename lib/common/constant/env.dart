import 'package:ismart/common/enum/environment.dart';

class Env {
  Env({
    required this.baseUrl,
    required this.imageUrl,
    required this.appEnvironment,
  });

  final String baseUrl;
  final String imageUrl;
  final AppEnvironment appEnvironment;
}

class EnvValue {
  static final Env development = Env(
    baseUrl: 'https://newsapi.ayaanshtech.com.np/api',
    imageUrl: 'https://newsapi.ayaanshtech.com.np/api',
    appEnvironment: AppEnvironment.Development,
  );

  static final Env staging = Env(
    baseUrl: 'https://newsapi.ayaanshtech.com.np/api',
    imageUrl: 'https://newsapi.ayaanshtech.com.np/api',
    appEnvironment: AppEnvironment.Stage,
  );
  static final Env production = Env(
    baseUrl: 'https://newsapi.ayaanshtech.com.np/api',
    imageUrl: 'https://newsapi.ayaanshtech.com.np/api',
    appEnvironment: AppEnvironment.Production,
  );
}
