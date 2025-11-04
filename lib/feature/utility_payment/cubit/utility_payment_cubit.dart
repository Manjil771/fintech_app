import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/feature/categoryWiseService/busBooking/resource/bus_detail_model.dart';
import 'package:ismart/feature/notification/resources/notification_model.dart';
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
      emit(CommonStateSuccess<UtilityResponseData>(data: _res.data!));
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
    Map<String, dynamic>? extraHeaders,
    bool shouldIncludeMPIN = false,
  }) async {
    emit(CommonLoading());
    if (shouldIncludeMPIN) {
      final mPin = await SecureStorageService.appPassword;
      accountDetails['mPin'] = mPin;
    }
    final _res = await utilityPaymentRepository.fetchDetails(
      extraHeaders: extraHeaders,
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

/* for Fecth details using post method */
  fetchDetailsPost({
    required String serviceIdentifier,
    required Map<String, dynamic> accountDetails,
    required String apiEndpoint,
    Map<String, dynamic>? extraHeaders,
    bool shouldIncludeMPIN = false,
  }) async {
    emit(CommonLoading());
    if (shouldIncludeMPIN) {
      final mPin = await SecureStorageService.appPassword;
      accountDetails['mPin'] = mPin;
    }
    final _res = await utilityPaymentRepository.fetchDetailsPost(
      extraHeaders: extraHeaders,
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

  fetchBusDetails({
    required String serviceIdentifier,
    required Map<String, dynamic> accountDetails,
    required String apiEndpoint,
  }) async {
    emit(CommonLoading());

    final _res = await utilityPaymentRepository.fetchBusDetails(
      serviceIdentifier: serviceIdentifier,
      accountDetails: accountDetails,
      apiEndpoint: apiEndpoint,
    );
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonStateSuccess<BusDetailModel?>(data: _res.data));
    } else {
      emit(
        CommonError(
          message: _res.message ?? LocaleKeys.error.tr(),
        ),
      );
    }
  }

  fetchNotification() async {
    emit(CommonLoading());

    final _res = await utilityPaymentRepository.fetchNotification();
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonStateSuccess<NotificationModel>(data: _res.data!));
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
    print("--------------this is body $body");
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

  deleteReq({
    required String serviceIdentifier,
    required Map<String, dynamic> accountDetails,
    required String apiEndpoint,
    required mPin,
  }) async {
    emit(CommonLoading());

    final _res = await utilityPaymentRepository.deleteReq(
      mPin: mPin,
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

  getCharges({
    required Map<String, dynamic> accountDetails,
    required String apiEndpoint,
  }) async {
    emit(CommonLoading());

    final res = await utilityPaymentRepository.getCharges(
        accountDetails: accountDetails, apiEndpoint: apiEndpoint);
    if (res.status == Status.Success && res.data != null) {
      emit(CommonStateSuccess(data: res.data!));
    } else {
      emit(CommonError(
        message: res.message ?? "Error fetching Data.",
      ));
    }
  }
}
