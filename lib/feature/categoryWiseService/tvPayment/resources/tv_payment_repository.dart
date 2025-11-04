import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/categoryWiseService/tvPayment/resources/tv_detail_model.dart';
import 'package:ismart/feature/customerDetail/cubit/customer_detail_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

import 'tv_payment_api_provider.dart';

class TvPaymentRepository {
  ApiProvider apiProvider;
  late TvPaymentAPIProvider tvPaymentAPIProvider;
  UserRepository userRepository;
  CoOperative env;

  TvPaymentRepository({
    required this.env,
    required this.userRepository,
    required this.apiProvider,
  }) {
    tvPaymentAPIProvider = TvPaymentAPIProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      userRepository: userRepository,
    );
  }

  Future<DataResponse<TvDetailModel>> fetchDetails(
      {required String serviceIdentifier,
      required Map<String, dynamic> accountDetails,
      required String apiEndpoint}) async {
    try {
      final _res = await tvPaymentAPIProvider.fetchDetails(
        serviceIdentifier: serviceIdentifier,
        accountDetails: accountDetails,
        apiEndpoint: apiEndpoint,
      );

      TvDetailModel _responseData = TvDetailModel.fromJson(_res['data'] ?? {});
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

  Future<DataResponse<UtilityResponseData>> makePayment({
    required String serviceIdentifier,
    required Map<String, dynamic> accountDetails,
    required Map<String, dynamic> body,
    required String apiEndpoint,
    required mPin,
  }) async {
    try {
      final _res = await tvPaymentAPIProvider.makePayment(
        mPin: mPin,
        serviceIdentifier: serviceIdentifier,
        accountDetails: accountDetails,
        apiEndpoint: apiEndpoint,
        body: body,
      );

      UtilityResponseData _responseData =
          UtilityResponseData.fromJson(_res['data'] ?? {});
      print(_responseData);
      NavigationService.context
          .read<CustomerDetailCubit>()
          .fetchCustomerDetail();
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
}
