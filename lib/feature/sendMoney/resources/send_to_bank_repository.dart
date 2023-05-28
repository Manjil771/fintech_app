import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/sendMoney/models/bank.dart';
import 'package:ismart/feature/sendMoney/resources/send_to_bank_api_provider.dart';

class SendToBankRepository {
  final UserRepository userRepository;
  final CoOperative env;
  final ApiProvider apiProvider;
  late SendToBankAPIProvider sendToBankAPIProvider;

  SendToBankRepository({
    required this.userRepository,
    required this.env,
    required this.apiProvider,
  }) {
    sendToBankAPIProvider = SendToBankAPIProvider(
      apiProvider: apiProvider,
      baseUrl: env.baseUrl,
      userRepository: userRepository,
    );
  }

  Future<DataResponse<List<Bank>>> getBanksList() async {
    List<Bank> _banksList = [];
    try {
      final _res = await sendToBankAPIProvider.getBanksList();
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

  Future<DataResponse<String>> getBankCharges({
    required String amount,
    required String bankId,
  }) async {
    List<Bank> _banksList = [];
    try {
      final _res = await sendToBankAPIProvider.getBankCharges(
        bankId: bankId,
        amount: amount,
      );
      final _result = Map<String, dynamic>.from(_res);
      if (_result['data']['details'] != null) {
        return DataResponse.success(
            (_result['data']['details'] ?? "").toString());
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

  // Future<DataResponse<WalletBalance>> getWalletBalance({
  //   required String userLoginID,
  //   required String type,
  // }) async {
  //   final payload = {
  //     // "user_login_id": userLoginID,
  //     "created_platform": "android"
  //   };
  //   final String payloadData =
  //       CoreWalletUtils.encodeWalletPayload(payload: payload);
  //   try {
  //     final _res = await coreWalletAPIProvider.getWalletBalance(
  //       payloadData: payloadData,
  //     );
  //     final _result = Map<String, dynamic>.from(_res);
  //     if (_result['data']['data'] != null) {
  //       final WalletBalance walletBalance =
  //           WalletBalance.fromJson(_result['data']['data']['balance']);
  //       return DataResponse.success(walletBalance);
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

  // Future<DataResponse<LoadFundReceipt>> getBankLoadReceipt({
  //   required String txnId,
  // }) async {
  //   final payload = {
  //     // "user_login_id": userRepository.user.value!.phone,
  //     "MerchantTxnId": txnId,
  //   };
  //   final String payloadData =
  //       CoreWalletUtils.encodeWalletPayload(payload: payload);
  //   try {
  //     final _res = await coreWalletAPIProvider.loadFundReceipt(
  //       payloadData: payloadData,
  //     );
  //     final _result = Map<String, dynamic>.from(_res);
  //     if (_result['data']['data'] != null) {
  //       final LoadFundReceipt walletBalance =
  //           LoadFundReceipt.fromJson(_result['data']['data']);
  //       return DataResponse.success(walletBalance);
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

  // Future<DataResponse<LoadFundData>> loadFund({
  //   required String userLoginID,
  //   required String mpin,
  //   required String amount,
  //   required String remarks,
  //   required String instrumentationCode,
  // }) async {
  //   final String encodedPIN = CoreWalletUtils.encodeMPIN(payload: mpin);
  //   final payload = {
  //     "mpin": "$encodedPIN",
  //     "amount": "$amount",
  //     "remarks": "$remarks",
  //     "InstrumentCode": "$instrumentationCode",
  //     // "user_login_id": "$userLoginID"
  //   };
  //   final String payloadData =
  //       CoreWalletUtils.encodeWalletPayload(payload: payload);
  //   try {
  //     final _res = await coreWalletAPIProvider.loadFund(
  //       payloadData: payloadData,
  //     );
  //     final _result = Map<String, dynamic>.from(_res);
  //     if (_result['data']['data'] != null) {
  //       final LoadFundData loadFundData =
  //           LoadFundData.fromJson(_result['data']['data']);
  //       return DataResponse.success(loadFundData);
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

  // Future<DataResponse<BalanceTransfer>> balanceTransfer({
  //   required String mobileNumber,
  //   required String mpin,
  //   required String amount,
  //   required String remarks,
  //   required String purpose,
  //   required SendMoneyPaymentTypes sendMoneyPaymentType,
  // }) async {
  //   final String encodedPIN = CoreWalletUtils.encodeMPIN(payload: mpin);
  //   final payload = {
  //     "subscription_no": mobileNumber,
  //     "amount": amount,
  //     "description": remarks,
  //     "purpose": purpose,
  //     "mpin": encodedPIN,
  //   };

  //   try {
  //     final _res = await coreWalletAPIProvider.balanceTransfer(
  //       payloadData: {
  //         "mobile": "$mobileNumber",
  //         "amount": "$amount",
  //       },
  //       sendMoneyPaymentType: sendMoneyPaymentType,
  //     );
  //     final _result = Map<String, dynamic>.from(_res);
  //     if (_result['data']['data'] != null) {
  //       final BalanceTransfer balanceTransfer =
  //           BalanceTransfer.fromJson(_result['data']['data']);
  //       return DataResponse.success(balanceTransfer);
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

  // Future<DataResponse<BankTransferResponse>> sendMoneyToBank({
  //   required String userLoginID,
  //   required String mpin,
  //   required String amount,
  //   required String remarks,
  //   required String purpose,
  //   required String destinationBankName,
  //   required String destinationBankInstrumentCode,
  //   required String destinationBankAccountName,
  //   required String destinationBankAccountNumber,
  //   required String serviceCharge,
  //   required String totalAmount,
  //   required String gatewayCharge,
  //   required String adminCommission,
  //   required bool isMobile,
  // }) async {
  //   final payloadNchl = {
  //     "bank_id": destinationBankInstrumentCode,
  //     "bank_name": "$destinationBankName",
  //     "account_name": "$destinationBankAccountName",
  //     "account_number": "$destinationBankAccountName",
  //     "amount": amount,
  //     "remark": "$remarks",
  //     "pin": mpin,
  //   };

  //   try {
  //     final _res = await coreWalletAPIProvider.sendMoneyToBank(
  //       payloadData: payloadNchl,
  //     );
  //     final _result = Map<String, dynamic>.from(_res);
  //     if (_result['data'] != null) {
  //       final BankTransferResponse loadFundData =
  //           BankTransferResponse.fromJson(_result['data']);
  //       return DataResponse.success(loadFundData);
  //     } else {
  //       return DataResponse.error(
  //           "Error while sending money. Please try again.");
  //     }
  //   } on CustomException catch (e) {
  //     if (e is SessionExpireErrorException) {
  //       rethrow;
  //     }
  //     // if (e.statusCode == 400) {
  //     //   return DataResponse.error(
  //     //       "User validation error. Please recheck details.", e.statusCode);
  //     // }
  //     return DataResponse.error(e.message!, e.statusCode);
  //   } catch (e) {
  //     return DataResponse.error(e.toString());
  //   }
  // }
}
