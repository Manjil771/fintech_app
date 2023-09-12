import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/authentication/ui/resetPin/resources/reset_pin_api_provider.dart';
import 'package:ismart/feature/customerDetail/cubit/customer_detail_cubit.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_api_provider.dart';

class ResetPinRepository {
  ApiProvider apiProvider;
  late ResetPinApiProvider resetPinApiProvider;
  UserRepository userRepository;
  CoOperative env;

  ResetPinRepository({
    required this.env,
    required this.userRepository,
    required this.apiProvider,
  }) {
    resetPinApiProvider = ResetPinApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      userRepository: userRepository,
    );
  }

  Future<DataResponse<UtilityResponseData>> makePayment({
    required String serviceIdentifier,
    required Map<String, dynamic> accountDetails,
    required Map<String, dynamic> body,
    required String apiEndpoint,
    required mPin,
  }) async {
    try {
      final _res = await resetPinApiProvider.makePayment(
        mPin: mPin,
        accountDetails: accountDetails,
        apiEndpoint: apiEndpoint,
        body: body,
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

  // Future<DataResponse> makePayment({
  //   required String serviceIdentifier,
  //   required Map<String, dynamic> accountDetails,
  //   required Map<String, dynamic> body,
  //   required String apiEndpoint,
  //   required mPin,
  // }) async {
  //   try {
  //     final _res = await resetPinApiProvider.makePayment(
  //       mPin: mPin,
  //       accountDetails: accountDetails,
  //       apiEndpoint: apiEndpoint,
  //       body: body,
  //     );

  //     final _responseData = _res['data'] ?? {};
  //     UtilityResponseData _response =
  //         UtilityResponseData.fromJson(_responseData);

  //     return DataResponse.success(_response);
  //   } on CustomException catch (e) {
  //     if (e is SessionExpireErrorException) {
  //       rethrow;
  //     }
  //     return DataResponse.error(e.message, e.statusCode);
  //   } catch (e) {
  //     return DataResponse.error(e.toString());
  //   }
  // }
}
