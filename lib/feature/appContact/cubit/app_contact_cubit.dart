import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/appContact/resources/app_contact_repository.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class AppContactCubit extends Cubit<CommonState> {
  AppContactCubit({required this.appContactRepository})
      : super(CommonInitial());

  AppContactRepository appContactRepository;

  fetchAppContact() async {
    emit(CommonLoading());

    final _res = await appContactRepository.fetchAppContact();
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
