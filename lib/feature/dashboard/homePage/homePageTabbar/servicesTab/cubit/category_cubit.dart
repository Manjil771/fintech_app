import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';

import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/resources/category_repository.dart';

class CategoryCubit extends Cubit<CommonState> {
  final CategoryRepository servicesRepository;
  CategoryCubit({required this.servicesRepository}) : super(CommonInitial());
  Future<dynamic> fetchCategory() async {
    emit(CommonLoading());
    try {
      final response = await servicesRepository.getCategoryList();

      if (response.status == Status.Success && response.data != null) {
        emit(CommonStateSuccess(data: response.data!));
      } else {
        emit(CommonError(
            message: response.message ?? "Error fetching customer detail."));
      }
    } catch (e) {
      emit(CommonError(message: e.toString()));
    }
  }
}
