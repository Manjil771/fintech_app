import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/util/url_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class RecentTransactionApiProvider {
  final ApiProvider apiProvider;
  final CoOperative coOperative;
  final String baseUrl;
  final UserRepository userRepository;

  RecentTransactionApiProvider(
      {required this.coOperative,
      required this.apiProvider,
      required this.userRepository,
      required this.baseUrl});

  Future<dynamic> fetchRecentTransaction() async {
    final _params = {"serviceOf": "SERVICE"};
    final _uri = UrlUtils.getUri(
        url: coOperative.baseUrl + "/api/recentTransaction", params: _params);
    return await apiProvider.get(Uri.parse(_uri.toString()),
        userId: 0, token: userRepository.token);
  }
}
