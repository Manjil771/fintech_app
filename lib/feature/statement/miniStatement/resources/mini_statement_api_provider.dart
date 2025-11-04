import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/util/url_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class MiniStatementAPIProvider {
  final ApiProvider apiProvider;
  final CoOperative coOperative;
  final String baseUrl;

  final UserRepository userRepository;

  const MiniStatementAPIProvider({
    required this.apiProvider,
    required this.baseUrl,
    required this.coOperative,
    required this.userRepository,
  });
  Future<dynamic> fetchMiniStatement(accountNumber, mPin) async {
    final _body = {
      "account_number": accountNumber,
      "mPin": mPin,
    };
    print("loading");
    final _uri = UrlUtils.getUri(
        url: coOperative.baseUrl + "/api/ministatement", params: _body);

    return await apiProvider.get(
      Uri.parse(_uri.toString()),
      token: userRepository.token,
      userId: 0,
    );
  }
}
