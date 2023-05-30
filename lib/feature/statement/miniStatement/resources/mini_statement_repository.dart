import 'package:flutter/foundation.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_api_provider.dart';
import 'package:ismart/feature/statement/miniStatement/models/mini_statement_model.dart';
import 'package:ismart/feature/statement/miniStatement/resources/mini_statement_api_provider.dart';

class MiniStatementRepository {
  final ApiProvider apiProvider;
  late MiniStatementAPIProvider miniStatementAPIProvider;
  final CoOperative coOperative;
  final UserRepository userRepository;

  MiniStatementRepository({
    required this.apiProvider,
    required this.coOperative,
    required this.userRepository,
  }) {
    miniStatementAPIProvider = MiniStatementAPIProvider(
      apiProvider: apiProvider,
      baseUrl: coOperative.baseUrl,
      coOperative: coOperative,
      userRepository: userRepository,
    );
  }

  Future<DataResponse<MiniStatementModel>> getMiniStatement(
      accountNumbner, mPin) async {
    try {
      final _res = await miniStatementAPIProvider.fetchMiniStatement(
          accountNumbner, mPin);
      print(_res.toString());

      if (_res['data']['details'] != null) {
        // Parse Data from API

        final Map<String, dynamic> _userMap =
            Map<String, dynamic>.from(_res['data']?['details'] ?? {});

        if (_userMap.isEmpty) {
          return DataResponse.error("Error fetching data.");
        }
        MiniStatementModel _miniStatement =
            MiniStatementModel.fromJson(_userMap);

        return DataResponse.success(_miniStatement);
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
