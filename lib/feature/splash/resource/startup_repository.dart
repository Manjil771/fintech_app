import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/splash/resource/startup_api_provider.dart';

class StartUpRepository {
  ApiProvider apiProvider;
  late StartUpApiProvider startupApiProvider;
  UserRepository userRepository;
  CoOperative env;

  StartUpRepository({
    required this.env,
    required this.userRepository,
    required this.apiProvider,
  }) {
    startupApiProvider = StartUpApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      userRepository: userRepository,
    );
  }

  Future<DataResponse<List<String>>> fetchConfig() async {
    try {
      final _res = startupApiProvider.fetchBannerImages();
      if (_res['data']?['code'] == "M0000") {
        final List<String> _listOfImages =
            List<String>.from(_res['data']?['details'] ?? []);
        return DataResponse.success(_listOfImages);
      } else {
        return DataResponse.error("Error fetching banners.");
      }
    } catch (e) {
      return DataResponse.error("Error fetching banners");
    }
  }
}
