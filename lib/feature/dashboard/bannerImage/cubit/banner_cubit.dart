import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/categoryWiseService/busBooking/resource/bus_detail_model.dart';
import 'package:ismart/feature/dashboard/bannerImage/resource/banner_repository.dart';
import 'package:ismart/feature/notification/resources/notification_model.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class BannerCubit extends Cubit<CommonState> {
  BannerCubit({required this.bannerRepository})
      : super(CommonInitial());

  BannerRepository bannerRepository;

 

  fetchDetails({
    required String bannerImagetype,
  }) async {
    emit(CommonLoading());

    final _res = await bannerRepository.fetchBannerImages(
bannerImageType: bannerImagetype 
    );
    if (_res.status == Status.Success && _res.data != null) {
      emit(CommonStateSuccess(data: _res.data!));
    } else {
      emit(
        CommonError(
          message: _res.message ?? LocaleKeys.error.tr(),
        ),
      );
    }
  }

  
}
