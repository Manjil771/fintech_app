import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/util/url_utils.dart';

class AuthApiProvider {
  final ApiProvider apiProvider;
  final CoOperative coOperative;
  final String baseUrl;

  const AuthApiProvider({
    required this.apiProvider,
    required this.baseUrl,
    required this.coOperative,
  });

  // Future<dynamic> fetchProfile({required String token}) async {
  //   return await apiProvider.get('$baseUrl/user/profile', token: token);
  // }

  Future<dynamic> sendNotificationToken(
      {required String notificationToken, required String token}) async {
    final param = {"token": notificationToken};
    return await apiProvider.post(
      '$baseUrl/auth/firebase',
      param,
      token: token,
    );
  }

  Future<dynamic> loginUser({
    required String username,
    required String password,
    String? otpCode,
  }) async {
    final _body = {
      "client_id": coOperative.clientCode,
      "client_secret": coOperative.clientSecret,
      "password": "$password",
      "grant_type": "password",
      "username": coOperative.clientCode + username,
      "deviceUniqueIdentifier": "newaDeavice"
    };
    if (otpCode != null) {
      _body['otp'] = otpCode;
    }

    final _uri = UrlUtils.getUri(
        url: coOperative.baseUrl + "oauth/token", params: _body);
    return await apiProvider.post(
      _uri.toString(),
      {},
    );
  }
}
