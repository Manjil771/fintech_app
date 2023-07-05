import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class UtilityPaymentCubit extends Cubit<CommonState> {
  UtilityPaymentCubit({required this.utilityPaymentRepository})
      : super(CommonInitial());

  UtilityPaymentRepository utilityPaymentRepository;

  getTopUp({
    required String serviceIdentifier,
    required String phoneNumber,
    required String amount,
    required String mpin,
  }) async {
    emit(CommonLoading());

    final _res = await utilityPaymentRepository.getTopup(
      serviceIdentifier: serviceIdentifier,
      phoneNumber: phoneNumber,
      amount: amount,
      mpin: mpin,
    );
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonStateSuccess<String>(data: _res.data!));
    } else {
      emit(
        CommonError(
          message: _res.message ?? LocaleKeys.error.tr(),
        ),
      );
    }
  }

  fetchDetails({
    required String serviceIdentifier,
    required Map<String, dynamic> accountDetails,
    required String apiEndpoint,
  }) async {
    emit(CommonLoading());

    final _res = await utilityPaymentRepository.fetchDetails(
      serviceIdentifier: serviceIdentifier,
      accountDetails: accountDetails,
      apiEndpoint: apiEndpoint,
    );
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonStateSuccess<UtilityResponseData>(data: _res.data!));
    } else {
      emit(
        CommonError(
          message: _res.message ?? LocaleKeys.error.tr(),
        ),
      );
    }
  }

  makePayment({
    required String serviceIdentifier,
    required Map<String, dynamic> accountDetails,
    required Map<String, dynamic> body,
    required String apiEndpoint,
    required mPin,
  }) async {
    emit(CommonLoading());

    final _res = await utilityPaymentRepository.makePayment(
      mPin: mPin,
      serviceIdentifier: serviceIdentifier,
      accountDetails: accountDetails,
      apiEndpoint: apiEndpoint,
      body: body,
    );
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonStateSuccess<UtilityResponseData>(data: _res.data!));
    } else {
      emit(
        CommonError(
          message: _res.message ?? LocaleKeys.error.tr(),
        ),
      );
    }
  }
}
