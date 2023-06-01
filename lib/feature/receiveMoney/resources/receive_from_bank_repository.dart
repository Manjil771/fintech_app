import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/receiveMoney/cubits/receive_from_bank_cubit.dart';
import 'package:ismart/feature/receiveMoney/resources/receive_from_bank_api_provider.dart';
import 'package:ismart/feature/sendMoney/models/bank.dart';
import 'package:ismart/feature/sendMoney/resources/send_to_bank_api_provider.dart';

class ReceiveFromBankRepository {
  final UserRepository userRepository;
  final CoOperative env;
  final ApiProvider apiProvider;
  late ReceiveFromBankAPIProvider receiveFromBankAPIProvider;

  ReceiveFromBankRepository({
    required this.userRepository,
    required this.env,
    required this.apiProvider,
  }) {
    receiveFromBankAPIProvider = ReceiveFromBankAPIProvider(
      apiProvider: apiProvider,
      baseUrl: env.baseUrl,
      userRepository: userRepository,
    );
  }

  Future<DataResponse<List<Bank>>> getBanksList() async {
    List<Bank> _banksList = [];
    try {
      final _res = await receiveFromBankAPIProvider.getBanksList();
      final _result = Map<String, dynamic>.from(_res);
      if (_result['data']['details'] != null) {
        List.from(_result['data']['details']).forEach((element) {
          Bank _bank = Bank.fromJson(element);
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

  // Future<DataResponse<String>> getBankCharges({
  //   required String amount,
  //   required String bankId,
  // }) async {
  //   List<Bank> _banksList = [];
  //   try {
  //     final _res = await receiveFromBankAPIProvider.getBankCharges(
  //       bankId: bankId,
  //       amount: amount,
  //     );
  //     final _result = Map<String, dynamic>.from(_res);
  //     if (_result['data']['details'] != null) {
  //       return DataResponse.success(
  //           (_result['data']['details'] ?? "").toString());
  //     } else {
  //       return DataResponse.error("Error fetching balance data.");
  //     }
  //   } on CustomException catch (e) {
  //     if (e is SessionExpireErrorException) {
  //       rethrow;
  //     }
  //     return DataResponse.error(e.message!, e.statusCode);
  //   } catch (e) {
  //     return DataResponse.error(e.toString());
  //   }
  // }

  Future<DataResponse<String>> receiveMoneyFromBank({
    // required String mpin,
    required String amount,
    required String remarks,
    required String accountNumber,
    required String bankInstrumentCode,
    // required String destinationBankAccountName,
    // required String destinationBankAccountNumber,
    // required String serviceCharge,
  }) async {
    Map<String, dynamic> receiveFromBankPayload = {
      // "account_number": "00100101000002886000001",
      // "account_number": "002001-001-102-0001010",
      "accountNo": accountNumber,
      "amount": amount,
      // "charge": serviceCharge,
      "bankCode": bankInstrumentCode,
      // "destination_bank_name": destinationBankName,
      // "destination_branch_id": "1",
      // "destination_branch_name": "",
      // "destination_name": destinationBankAccountName,
      // "destination_account_number": destinationBankAccountNumber,
      "scheme_id": "1",
      "remarks": remarks,
      // "mPin": mpin,
      // "skipValidation": true,
    };

    try {
      final _res = await receiveFromBankAPIProvider.receiveMoneyFromBank(
        payloadData: receiveFromBankPayload,
      );
      final _result = Map<String, dynamic>.from(_res);
      if (_result['data']?['details'] != null) {
        return DataResponse.success(_result['data']?['details']);
      } else {
        return DataResponse.error(
            "Error while sending money. Please try again.");
      }
    } on CustomException catch (e) {
      if (e is SessionExpireErrorException) {
        rethrow;
      }
      // if (e.statusCode == 400) {
      //   return DataResponse.error(
      //       "User validation error. Please recheck details.", e.statusCode);
      // }
      return DataResponse.error(e.message!, e.statusCode);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
