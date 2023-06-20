import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/util/url_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class StartUpApiProvider {
  StartUpApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.userRepository,
  });

  final ApiProvider apiProvider;
  final UserRepository userRepository;

  final String baseUrl;

  fetchBannerImages() async {
    final url = "$baseUrl" "get/bannerimage/";
    return await apiProvider.get(
      UrlUtils.getUri(url: url),
      token: userRepository.token,
      userId: -1,
    );
  }
}
