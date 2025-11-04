import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/util/url_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class BannerApiProvider {
  BannerApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.userRepository,
    required this.env,
  });

  final ApiProvider apiProvider;
  final UserRepository userRepository;
  final CoOperative env;
  final String baseUrl;

  fetchBannerImages({required String bannerImageType}) async {
    final url = "$baseUrl" "get/bannerimage/";
    return await apiProvider.get(
      UrlUtils.getUri(url: url),
      extraHeaders: {
        "client": env.clientCode,
        "type": bannerImageType,
      },
      token: userRepository.token,
      userId: -1,
    );
  }
}
