import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/util/url_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class ServicesApiProvider {
  final ApiProvider apiProvider;
  final CoOperative coOperative;
  final String baseUrl;
  final UserRepository userRepository;

  ServicesApiProvider(
      {required this.apiProvider,
      required this.coOperative,
      required this.baseUrl,
      required this.userRepository});

  Future<dynamic> fetchServices() async {
    final _params = {"withService": "true"};
    final _uri = UrlUtils.getUri(
        url: coOperative.baseUrl + "/api/category", params: _params);
    return await apiProvider.get(Uri.parse(_uri.toString()),
        userId: 0, token: userRepository.token);
  }
}
