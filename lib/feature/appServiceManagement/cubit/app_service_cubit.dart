import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/util/hive_utils.dart';
import 'package:ismart/feature/appServiceManagement/model/app_service_management_model.dart';
import 'package:ismart/feature/appServiceManagement/resource/app_service_repository.dart';

class AppServiceCubit extends Cubit<CommonState> {
  final AppServiceRepository appServiceRepository;
  AppServiceCubit({required this.appServiceRepository})
      : super(CommonInitial());
  Future<dynamic> fetchAppService() async {
    emit(CommonDummyLoading());
    final _utilities =
        await ServiceHiveUtils.getAppService(slug: "app_service");

    if (_utilities.isNotEmpty) {
      emit(CommonDataFetchSuccess(data: _utilities));
    }

    try {
      final response = await appServiceRepository.getAppService();

      if (response.status == Status.Success && response.data != null) {
        emit(CommonDataFetchSuccess<AppServiceManagementModel>(
            data: response.data!));
      } else {
        emit(CommonError(
            message: response.message ?? "Error fetching the data."));
      }
    } catch (e) {
      emit(CommonError(message: e.toString()));
    }
  }
}
