import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/receiveMoney/resources/receive_money_api_provider.dart';
import 'package:ismart/feature/sendMoney/models/bank.dart';

class ReceiveMoneyRepository {
  final ApiProvider apiProvider;
  late ReceiveMoneyAPIProvider receiveMoneyAPIProvider;
  final CoOperative coOperative;
  final UserRepository userRepository;

  ReceiveMoneyRepository({
    required this.apiProvider,
    required this.coOperative,
    required this.userRepository,
  }) {
    receiveMoneyAPIProvider = ReceiveMoneyAPIProvider(
      apiProvider: apiProvider,
      baseUrl: coOperative.baseUrl,
      coOperative: coOperative,
      userRepository: userRepository,
    );
  }
  Future<DataResponse<List<Bank>>> fetchBanksList(
      {required String type}) async {
    try {
      final _res = await receiveMoneyAPIProvider.fetchBanksList(type: type);

      if (_res['data']['details'] != null) {
        final List<Bank> _walletList = [];
        final List _rawList = List.from(_res['data']?['details'] ?? []);

        _rawList.forEach((element) {
          final Bank _wallet = Bank.fromJson(element);
          _walletList.add(_wallet);
        });
        return DataResponse.success(_walletList);
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

  Future<DataResponse<String>> loadFromBank({
    required String bankCode,
    required String amount,
    required String remarks,
    required String accountNumber,
  }) async {
    try {
      final _res = await receiveMoneyAPIProvider.loadBankRequest(
        bankCode: bankCode,
        accountNumber: accountNumber,
        amount: amount,
        remarks: remarks,
      );

      if (_res['data'] != null) {
        final Map<String, dynamic> _rawResponse =
            Map<String, dynamic>.from(_res['data'] ?? {});
        if (_rawResponse.isEmpty) {
          return DataResponse.error("Error while loading wallet.");
        }

        return DataResponse.success("Validated");
      } else {
        return DataResponse.error("Error while loading wallet.");
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

  Future<DataResponse<String>> loadFromKhalti({
    required String amount,
    required String remarks,
    required String accountNumber,
  }) async {
    try {
      final _res = await receiveMoneyAPIProvider.loadFromKhalti(
        accountNumber: accountNumber,
        amount: amount,
        remarks: remarks,
      );

      if (_res['data'] != null) {
        final Map<String, dynamic> _rawResponse =
            Map<String, dynamic>.from(_res['data']?['details'] ?? {});
        if (_rawResponse.isEmpty) {
          return DataResponse.error(
              _res['data']["message"] ?? "Error while loading wallet.");
        }
        final String _response =
            "${_rawResponse['pidx']}-${_rawResponse['publicKey']}-${_rawResponse['productName']}-${_rawResponse['productIdentity']}";

        return DataResponse.success(_response);
      } else {
        return DataResponse.error("Error while loading wallet.");
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

  Future<DataResponse<String>> completeKhaltiTxn({
    required String amount,
    required String status,
    required String transaction_id,
    required String pidx,
  }) async {
    try {
      final _res = await receiveMoneyAPIProvider.completeKhaltiTxn(
        status: status,
        amount: amount,
        pidx: pidx,
        transaction_id: transaction_id,
      );

      if (_res['data'] != null) {
        final Map<String, dynamic> _rawResponse =
            Map<String, dynamic>.from(_res['data']?['details'] ?? {});
        if (_rawResponse.isEmpty) {
          return DataResponse.error("Error while loading wallet.");
        }
        final String _response =
            "${_rawResponse['productIdentity']}-${_rawResponse['publicKey']}-${_rawResponse['productName']}";

        return DataResponse.success(_response);
      } else {
        return DataResponse.error("Error while loading wallet.");
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
