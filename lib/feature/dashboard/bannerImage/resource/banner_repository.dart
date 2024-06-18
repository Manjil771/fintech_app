import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/util/device_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/dashboard/bannerImage/resource/banner_api_provider.dart';
import 'package:ismart/feature/splash/models/app_config_model.dart';
import 'package:ismart/feature/splash/resource/startup_api_provider.dart';
import 'package:ismart/feature/update/model/app_update.dart';
import 'package:ismart/feature/update/model/update.dart';

class BannerRepository {
  ApiProvider apiProvider;
  late BannerApiProvider bannerApiProvider;
  UserRepository userRepository;
  CoOperative env;

  BannerRepository({
    required this.env,
    required this.userRepository,
    required this.apiProvider,
  }) {
    bannerApiProvider = BannerApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      userRepository: userRepository,
      env: env,
    );
  }

  List<String> banners = [];


  Future<DataResponse<List<String>>> fetchBannerImages(
    {required String bannerImageType}
  ) async {
    banners.clear();
    try {
      final _res = await bannerApiProvider.fetchBannerImages(bannerImageType: bannerImageType);
      if (_res['data']?['code'] == "M0000") {
        List<String> _rawBanners =
            List<String>.from(_res['data']?['details'] ?? []);
        _rawBanners.forEach((element) {
          element = env.baseUrl + element;
          banners.add(
              element.replaceAll("//", "/").replaceAll("https:/", "https://"));
        });
        banners.forEach((element1) {
          print(element1);
        });
        return DataResponse.success(banners);
      } else {
        return DataResponse.error("Error fetching banners.");
      }
    } catch (e) {
      return DataResponse.error("Error fetching banners");
    }
  }


}
