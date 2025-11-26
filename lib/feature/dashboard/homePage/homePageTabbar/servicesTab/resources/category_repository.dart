import 'package:flutter/material.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/util/hive_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/resources/category_api_provider.dart';

class CategoryRepository {
  final ApiProvider apiProvider;
  final CoOperative coOperative;
  final UserRepository userRepository;

  late CategoryApiProvider categoryApiProvider;

  CategoryRepository({
    required this.apiProvider,
    required this.coOperative,
    required this.userRepository,
  }) {
    categoryApiProvider = CategoryApiProvider(
        apiProvider: apiProvider,
        baseUrl: coOperative.baseUrl,
        coOperative: coOperative,
        userRepository: userRepository);
  }
  final ValueNotifier<bool> isRemitEnabled = ValueNotifier<bool>(false);
  ValueNotifier<CategoryList?> remitCategory = ValueNotifier(null);

  Future<DataResponse<List<CategoryList>>> getCategoryList() async {
    List<CategoryList> _allServices = [];
    
    try {
      final _res = await categoryApiProvider.fetchServices();

      if (_res['data']['details'] != null) {
        final List _userMap = List.from(_res["data"]['details'] ?? []);

        if (_userMap.isEmpty) {
          return DataResponse.error("Error fetching data.");
        }

        _userMap.forEach((element) {
          CategoryList _serviceList = CategoryList.fromJson(element);
          final List<ServiceList> _dummyList = [];
          final Set<String> _uniqueID = {};
          _serviceList.services.forEach((element) {
            _uniqueID.add(element.uniqueIdentifier);
          });

          _uniqueID.forEach((uniqEelement) {
            final ServiceList _singleValue = _serviceList.services.firstWhere(
                (elementService) =>
                    uniqEelement == elementService.uniqueIdentifier);
            _dummyList.add(_singleValue);
          });
          _serviceList = _serviceList.copyWith(_dummyList);
          _allServices.add(_serviceList);
        });

        final _ = await ServiceHiveUtils.setUtilitiesServices(
            item: _allServices, slug: "wallet_service");
        if (_allServices.any((category) => category.name == "Remittance")) {
          remitCategory.value = _allServices
              .firstWhere((category) => category.name == 'Remittance');
          isRemitEnabled.value = true;
        }
        print("📌 CATEGORY NAMES FROM API:");
for (var category in _allServices) {
  print("name of service ${category.name}");
}
        return DataResponse.success(_allServices);
      } else {
        return DataResponse.error("error message");
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
