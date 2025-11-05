import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/util/url_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class KhanePaniApiProvider {
  final ApiProvider apiProvider;
  final CoOperative coOperative;

  final UserRepository userRepository;

  KhanePaniApiProvider(
      {required this.apiProvider,
      required this.coOperative,
      required this.userRepository});

  Future<dynamic> fetchKhanePaniCounter() async {
    final _uri =
        UrlUtils.getUri(url: coOperative.baseUrl + "/get/khanepanicounters");
    return await apiProvider.get(Uri.parse(_uri.toString()), userId: 0);
  }
}
