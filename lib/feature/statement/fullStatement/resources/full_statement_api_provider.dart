import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/util/url_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class FullStatementAPIProvider {
  final ApiProvider apiProvider;
  final CoOperative coOperative;
  final String baseUrl;

  final UserRepository userRepository;

  const FullStatementAPIProvider({
    required this.apiProvider,
    required this.baseUrl,
    required this.coOperative,
    required this.userRepository,
  });
  Future<dynamic> fetchFullStatement({
    required String accountNumber,
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    final _body = {
      "accountNumber": accountNumber,
      "fromDate": "2020-01-01",
      "toDate": "2023-05-01",
    };
    print("loading");
    final _uri = UrlUtils.getUri(
        url: coOperative.baseUrl + "/api/accountStatement", params: _body);

    return await apiProvider.get(
      Uri.parse(_uri.toString()),
      token: userRepository.token,
      userId: 0,
    );
  }
}
