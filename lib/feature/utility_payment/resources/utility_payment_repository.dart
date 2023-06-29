import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_api_provider.dart';

class UtilityPaymentRepository {
  ApiProvider apiProvider;
  late UtilityPaymentAPIProvider utilityPaymentAPIProvider;
  UserRepository userRepository;
  CustomerDetailRepository customerDetailRepository;
  CoOperative env;

  UtilityPaymentRepository({
    required this.env,
    required this.userRepository,
    required this.apiProvider,
    required this.customerDetailRepository,
  }) {
    utilityPaymentAPIProvider = UtilityPaymentAPIProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      userRepository: userRepository,
    );
  }

  final String _myQrCode = "";

  String get myQrCode => _myQrCode;

  Future<DataResponse<String>> getTopup({
    required String serviceIdentifier,
    required String phoneNumber,
    required String amount,
    required String mpin,
  }) async {
    try {
      final _res = await utilityPaymentAPIProvider.getTopup(
        serviceIdentifier: serviceIdentifier,
        accountNumber:
            customerDetailRepository.selectedAccount.value?.accountNumber ?? "",
        phoneNumber: phoneNumber,
        amount: amount,
        mpin: mpin,
      );
      print(_res);
      return DataResponse.success(_res['data']?['message'] ?? "");
    } on CustomException catch (e) {
      if (e is SessionExpireErrorException) {
        rethrow;
      }
      return DataResponse.error(e.message, e.statusCode);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<UtilityResponseData>> fetchDetails(
      {required String serviceIdentifier,
      required Map<String, dynamic> accountDetails,
      required String apiEndpoint}) async {
    try {
      final _res = await utilityPaymentAPIProvider.fetchDetails(
        serviceIdentifier: serviceIdentifier,
        accountDetails: accountDetails,
        apiEndpoint: apiEndpoint,
      );

      UtilityResponseData _responseData =
          UtilityResponseData.fromJson(_res['data'] ?? {});
      print(_responseData);
      return DataResponse.success(_responseData);
    } on CustomException catch (e) {
      if (e is SessionExpireErrorException) {
        rethrow;
      }
      return DataResponse.error(e.message, e.statusCode);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<UtilityResponseData>> fetchInsuranceDetail(
      {required String serviceIdentifier,
      required String username,
      required String dateOfBirth,
      required String apiEndpoint}) async {
    try {
      final _res = await utilityPaymentAPIProvider.fetchInsuranceBill(
        username: username,
        dateOfBirth: dateOfBirth,
        serviceIdentifier: serviceIdentifier,
        apiEndpoint: apiEndpoint,
      );
      UtilityResponseData _responseData =
          UtilityResponseData.fromJson(_res['data'] ?? {});
      print(_responseData);
      return DataResponse.success(_responseData);
    } on CustomException catch (e) {
      if (e is SessionExpireErrorException) {
        rethrow;
      }
      return DataResponse.error(e.message, e.statusCode);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<String>> payInsurance({
    required String serviceIdentifier,
    required String amount,
    required String accountNumber,
    required String mpin,
    required String dob,
  }) async {
    try {
      final _res = await utilityPaymentAPIProvider.payInsuranceBill(
        dob: dob,
        serviceIdentifier: serviceIdentifier,
        accountNumber: accountNumber,
        amount: amount,
        mpin: mpin,
      );
      print(_res);
      return DataResponse.success(_res['data']?['message'] ?? "");
    } on CustomException catch (e) {
      if (e is SessionExpireErrorException) {
        rethrow;
      }
      return DataResponse.error(e.message, e.statusCode);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<String>> buyDatapack({
    required String serviceIdentifier,
    required String phoneNumber,
    required String amount,
    required String mpin,
    required String code,
  }) async {
    try {
      final _res = await utilityPaymentAPIProvider.buyDatapack(
        serviceIdentifier: serviceIdentifier,
        accountNumber:
            customerDetailRepository.selectedAccount.value?.accountNumber ?? "",
        phoneNumber: phoneNumber,
        amount: amount,
        mpin: mpin,
        code: code,
      );

      return DataResponse.success(_res['data']?['message'] ?? "");
    } on CustomException catch (e) {
      if (e is SessionExpireErrorException) {
        rethrow;
      }
      return DataResponse.error(e.message, e.statusCode);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
