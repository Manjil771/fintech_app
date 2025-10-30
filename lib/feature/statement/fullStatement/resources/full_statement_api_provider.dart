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
    required bool pdfDownload,
  }) async {
    final _body = {
      "accountNumber": accountNumber,
      "fromDate": "${fromDate.year}-${fromDate.month}-${fromDate.day}",
      "toDate": "${toDate.year}-${toDate.month}-${toDate.day}",
      "pdf": pdfDownload
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
