import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/util/url_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class ResetOtpRegisterApiProvider {
  ResetOtpRegisterApiProvider({
    required this.apiProvider,
    required this.baseUrl,
    required this.userRepository,
  });

  final UserRepository userRepository;
  final String baseUrl;
  final ApiProvider apiProvider;

  resetOtp({
    required Map<String, dynamic> accountDetails,
    required Map<String, dynamic> body,
    required String apiEndpoint,
    required mPin,
  }) async {
    final _params = {
      ...accountDetails,
    };

    final url = UrlUtils.getUri(
      url: baseUrl + "$apiEndpoint",
      params: _params,
    );

    return await apiProvider.post(url.toString(), body);
  }

  // fetchDetails(
  //     {required String serviceIdentifier,
  //     required Map<String, dynamic> accountDetails,
  //     required String apiEndpoint}) async {
  //   final _params = {
  //     ...accountDetails,
  //   };
  //   if (serviceIdentifier.isNotEmpty) {
  //     _params["service_identifier"] = "$serviceIdentifier";
  //   }

  //   final url = UrlUtils.getUri(
  //     url: baseUrl + "$apiEndpoint",
  //     params: _params,
  //   );

  //   return await apiProvider.get(
  //     url,
  //     token: userRepository.token,
  //     userId: 0,
  //   );
  // }
}
