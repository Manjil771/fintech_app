import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/util/url_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class DatapackApiProvider {
  final ApiProvider apiProvider;
  final CoOperative coOperative;
  final String baseUrl;
  final UserRepository userRepository;

  DatapackApiProvider(
      {required this.apiProvider,
      required this.coOperative,
      required this.baseUrl,
      required this.userRepository});

  Future<dynamic> fetchDatapack(serviceIdentifier) async {
    final _params = {"service_identifier": serviceIdentifier};
    final _uri = UrlUtils.getUri(
        url: coOperative.baseUrl + "/api/data_pack/packages", params: _params);
    return await apiProvider.get(Uri.parse(_uri.toString()),
        userId: 0, token: userRepository.token);
  }
}
