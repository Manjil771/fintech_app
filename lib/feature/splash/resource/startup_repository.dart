import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/util/device_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/splash/models/app_config_model.dart';
import 'package:ismart/feature/splash/resource/startup_api_provider.dart';
import 'package:ismart/feature/update/model/app_update.dart';
import 'package:ismart/feature/update/model/update.dart';

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
      env: env,
    );
  }

  List<String> banners = [];

  AppUpdate? appUpdate;

  Future<DataResponse<List<String>>> fetchBannerImages() async {
    banners.clear();
    try {
      final _res = await startupApiProvider.fetchBannerImages();
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

  Future<DataResponse<AppConfigDetails>> fetchAppConfig() async {
    try {
      final _res = await startupApiProvider.fetchAppConfig();
      if (_res['data']?['code'] == "M0000") {
        Map<String, dynamic> _configDetailsRaw =
            Map.from(_res['data']?['detail'] ?? {});
        if (_configDetailsRaw.isNotEmpty) {
          AppConfigDetails _appConfig =
              AppConfigDetails.fromJson(_configDetailsRaw);
          appUpdate = AppUpdate(
            android: Update(
              currentVersion: await DeviceUtils.getAppVersion,
              minimumVersionSupport: _appConfig.androidMinimumVersion,
              whatsNew: "Bug Fixes",
            ),
            ios: Update(
              currentVersion: await DeviceUtils.getAppVersion,
              minimumVersionSupport: _appConfig.iosMinimumVersion,
              whatsNew: "Bug Fixes",
            ),
          );
          print(appUpdate);
          return DataResponse.success(_appConfig);
        } else {
          return DataResponse.error("Error while fetching app config.");
        }
      } else {
        return DataResponse.error("Error fetching banners.");
      }
    } catch (e) {
      print(e);
      return DataResponse.error("Error fetching banners");
    }
  }
}
