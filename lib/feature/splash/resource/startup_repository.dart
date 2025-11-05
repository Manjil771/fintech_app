import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';
import 'package:ismart/common/util/device_utils.dart';
import 'package:ismart/common/util/hive_utils.dart';
import 'package:ismart/feature/appServiceManagement/model/app_service_management_model.dart';
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
  List<String> defaultbanners = [];

  AppUpdate? appUpdate;

  List<AppServiceManagementModel> allServices = [];

  Future<DataResponse<List<String>>> fetchBannerImages() async {
    banners.clear();
    try {
      final _res = await startupApiProvider.fetchBannerImages();
      if (_res['data']?['code'] == "M0000") {
        final List<String> _rawBanners =
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

  Future<DataResponse<List<String>>> fetchdefaultBannerImages() async {
    defaultbanners.clear();
    try {
      final _res = await startupApiProvider.fetchdefaultBannerImages();
      if (_res['data']?['code'] == "M0000") {
        final List<String> _rawBanners =
            List<String>.from(_res['data']?['details'] ?? []);
        _rawBanners.forEach((element) {
          element = env.baseUrl + element;
          defaultbanners.add(
              element.replaceAll("//", "/").replaceAll("https:/", "https://"));
        });
        defaultbanners.forEach((element1) {
          print(element1);
        });
        return DataResponse.success(defaultbanners);
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
        final Map<String, dynamic> _configDetailsRaw =
            Map.from(_res['data']?['detail'] ?? {});
        if (_configDetailsRaw.isNotEmpty) {
          final AppConfigDetails _appConfig =
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
          print(
              'This is current/minimum ios version: ${appUpdate?.ios.currentVersion}/ ${appUpdate?.ios.minimumVersionSupport} and This is current/minimumsupport Android version:${appUpdate?.android.currentVersion}/ ${appUpdate?.android.minimumVersionSupport} ');
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

  Future<DataResponse<List<AppServiceManagementModel>>> getAppService() async {
    final List<AppServiceManagementModel> _appServiceList = [];
    try {
      final _res = await startupApiProvider.fetchAppService();

      if (_res['data']['details'] != null) {
        // Parse Data from API

        final List _userMap = List.from(_res["data"]['details'] ?? []);

        if (_userMap.isEmpty) {
          return DataResponse.error("Error fetching dat.");
        }

        _userMap.forEach(
          (element) {
            final AppServiceManagementModel _txn =
                AppServiceManagementModel.fromJson(element);

            _appServiceList.add(_txn);
          },
        );
        final _ = await ServiceHiveUtils.setAppService(
            item: _appServiceList, slug: "app_service");
        allServices = _appServiceList;
        SharedPref.setChatBotVisibility(allServices.any((service) =>
            service.uniqueIdentifier == 'ai_chat' &&
            service.status == 'Active'));
        SharedPref.setVoiceChatVisibility(allServices.any((service) =>
            service.uniqueIdentifier == 'ai_voice' &&
            service.status == 'Active'));
        return DataResponse.success(_appServiceList);
      } else {
        return DataResponse.error("No Transaction");
      }
    } on CustomException catch (e) {
      if (e is SessionExpireErrorException) {
        rethrow;
      }
      return DataResponse.error(e.message!, e.statusCode);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
