import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/util/hive_utils.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/resources/category_repository.dart';

class CategoryCubit extends Cubit<CommonState> {
  final CategoryRepository servicesRepository;
  CategoryCubit({required this.servicesRepository}) : super(CommonInitial());
  Future<dynamic> fetchCategory() async {
    // emit(CommonLoading());
    emit(CommonDummyLoading());
    final _utilities =
        await ServiceHiveUtils.getUtilitiesServices(slug: "wallet_service");

    if (_utilities.isNotEmpty) {
      emit(CommonDataFetchSuccess(data: _utilities));
    }
    try {
      final response = await servicesRepository.getCategoryList();
      emit(CommonDummyLoading());
      if (response.status == Status.Success && response.data != null) {
        emit(CommonDataFetchSuccess(data: response.data!));
      } else {
        emit(CommonError(
            message: response.message ?? "Error fetching customer detail."));
      }
    } catch (e) {
      emit(CommonError(message: e.toString()));
    }
  }
}
