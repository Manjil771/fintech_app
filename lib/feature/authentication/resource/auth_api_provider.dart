import 'package:ismart/common/http/api_provider.dart';

class AuthApiProvider {
  final ApiProvider apiProvider;
  final String baseUrl;

  const AuthApiProvider({
    required this.apiProvider,
    required this.baseUrl,
  });

  Future<dynamic> fetchProfile({required String token}) async {
    return await apiProvider.get('$baseUrl/user/profile', token: token);
  }

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
      "mobile_no": "$username",
      "password": "$password",
      "fcm_token": "fcm"
    };
    if (password.length == 4) {
      _body.remove("password");
      _body['pin'] = password;
    }

    if (otpCode != null) {
      _body['otp'] = otpCode;
    }
    final url = '$baseUrl/login/';
    return await apiProvider.post(
      url,
      _body,
    );
  }
}
