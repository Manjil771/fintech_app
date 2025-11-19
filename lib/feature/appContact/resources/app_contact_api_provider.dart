import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/util/url_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class AppContactAPIProvider {
  AppContactAPIProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.userRepository,
    required this.coOperative,
  });

  final ApiProvider apiProvider;
  final UserRepository userRepository;
  final String baseUrl;
  final CoOperative coOperative;

  fetchAppContact() async {
    final url = UrlUtils.getUri(
        url: baseUrl + "appcontactdetail/get/${coOperative.clientCode}");

    return await apiProvider.get(
      url,
      userId: 0,
    );
  }
}
