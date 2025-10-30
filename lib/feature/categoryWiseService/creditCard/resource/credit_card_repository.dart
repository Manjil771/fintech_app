import 'package:dio/dio.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/resource/credit_card_api_provider.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/resource/credit_card_bank_model.dart';

class CreditCardRepository {
  final UserRepository userRepository;
  final CoOperative env;
  final ApiProvider apiProvider;
  late CreditCardAPIProvider creditCardAPIProvider;

  CreditCardRepository({
    required this.userRepository,
    required this.env,
    required this.apiProvider,
  }) {
    creditCardAPIProvider = CreditCardAPIProvider(
      apiProvider: apiProvider,
      baseUrl: env.baseUrl,
      userRepository: userRepository,
    );
  }

  Future<DataResponse<List<CreditCardBankList>>> getBanksList(
      {required String apiEndpoint}) async {
    final List<CreditCardBankList> _banksList = [];
    try {
      final _res =
          await creditCardAPIProvider.getBanksList(apiEndpoint: apiEndpoint);
      final _result = Map<String, dynamic>.from(_res);
      if (_result['data']['details'] != null) {
        List.from(_result['data']['details']).forEach((element) {
          final CreditCardBankList _bank = CreditCardBankList.fromJson(element);
          _banksList.add(_bank);
        });
        return DataResponse.success(_banksList);
      } else {
        return DataResponse.error("Error fetching balance data.");
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

  Future<DataResponse<String>> getBankCharges({
    required String amount,
    required String bankId,
  }) async {
    try {
      final _res = await creditCardAPIProvider.getBankCharges(
        bankId: bankId,
        amount: amount,
      );
      if (_res['data']?['code'] == "M0000") {
        final _result = Map<String, dynamic>.from(_res);
        if (_result['data']['details'] != null) {
          return DataResponse.success(
              (_result['data']['details'] ?? "").toString());
        } else {
          return DataResponse.error("Error fetching balance data.");
        }
      } else {
        return DataResponse.error(
            "CreditCardBankList account validation failed.");
      }
    } on CustomException catch (e) {
      print(e);
      // if (e is SessionExpireErrorException) {
      //   rethrow;
      // }
      return DataResponse.error(e.message!, e.statusCode);
    } on DioError catch (dio) {
      print(dio);
      return DataResponse.error("message");
    } catch (e) {
      print(e);
      return DataResponse.error(e.toString());
    }
  }
}
