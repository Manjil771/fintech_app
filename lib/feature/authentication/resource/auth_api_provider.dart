import 'package:ismart/common/http/api_provider.dart';

class AuthApiProvider {
  final ApiProvider apiProvider;
  final String baseUrl;

  const AuthApiProvider({
    required this.apiProvider,
    required this.baseUrl,
  });

  Future<dynamic> googleSignIn({required String accessToken}) async {
    final Map<String, dynamic> body = {'access_token': accessToken};
    return await apiProvider.post('$baseUrl/auth/google/token', body);
  }

  Future<dynamic> facebookSignIn({required String accessToken}) async {
    final Map<String, dynamic> body = {'access_token': accessToken};
    return await apiProvider.post('$baseUrl/auth/facebook/token', body);
  }

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
}
