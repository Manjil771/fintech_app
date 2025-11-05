import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/util/url_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class QrApiProvider {
  final ApiProvider apiProvider;
  final CoOperative coOperative;
  final String baseUrl;
  final UserRepository userRepository;

  QrApiProvider(
      {required this.coOperative,
      required this.apiProvider,
      required this.userRepository,
      required this.baseUrl});

  Future<dynamic> generateQrCode(
      {required String customerName, required String customerId}) async {
    final _params = {
      "customerName": customerName,
      "customerBankAccountId": customerId
    };
    final _uri = UrlUtils.getUri(
        // url: coOperative.baseUrl + "/api/generateAndQRCode", params: _params);
        url: coOperative.baseUrl + "/api/generateAndQRCodeNew",
        params: _params);

    return await apiProvider.get(Uri.parse(_uri.toString()),
        userId: 0, token: userRepository.token);
  }
}
