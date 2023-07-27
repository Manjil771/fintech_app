import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_api_provider.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/resources/category_api_provider.dart';
import 'package:ismart/feature/history/models/recent_transaction_model.dart';
import 'package:ismart/feature/history/resources/recent_tranasction_api_provider.dart';
import 'package:ismart/feature/statement/miniStatement/models/mini_statement_model.dart';
import 'package:ismart/feature/statement/miniStatement/resources/mini_statement_api_provider.dart';

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
  Future<DataResponse<List<CategoryList>>> getCategoryList() async {
    List<CategoryList> _recentTxnList = [];
    try {
      final _res = await categoryApiProvider.fetchServices();

      if (_res['data']['details'] != null) {
        // Parse Data from API

        final List _userMap = List.from(_res["data"]['details'] ?? []);

        if (_userMap.isEmpty) {
          return DataResponse.error("Error fetching data.");
        }

        _userMap.forEach((element) {
          CategoryList _txn = CategoryList.fromJson(element);
          List<ServiceList> _dummyList = [];
          Set<String> _uniqueID = {};
          _txn.services.forEach((element) {
            _uniqueID.add(element.uniqueIdentifier);
          });

          _uniqueID.forEach((uniqEelement) {
            print("Unique Values are :");
            print(uniqEelement);
            ServiceList _singleValue = _txn.services.firstWhere(
                (elementService) =>
                    uniqEelement == elementService.uniqueIdentifier);
            _dummyList.add(_singleValue);
          });
          _txn = _txn.copyWith(_dummyList);
          _recentTxnList.add(_txn);
        });

        return DataResponse.success(_recentTxnList);
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
