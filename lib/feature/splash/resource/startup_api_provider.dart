import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/util/url_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class StartUpApiProvider {
  StartUpApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.userRepository,
    required this.env,
  });

  final ApiProvider apiProvider;
  final UserRepository userRepository;
  final CoOperative env;
  final String baseUrl;

  fetchBannerImages() async {
    final url = "$baseUrl" "get/bannerimage/";
    return await apiProvider.get(
      UrlUtils.getUri(url: url),
      extraHeaders: {
        "client": env.clientCode,
        "type": "LoginScreenImage",
      },
      token: userRepository.token,
      userId: -1,
    );
  }
}
