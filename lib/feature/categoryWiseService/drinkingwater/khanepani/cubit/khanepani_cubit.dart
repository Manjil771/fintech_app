import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/categoryWiseService/drinkingwater/khanepani/resources/khanepani_repository.dart';

class KhanePaniCubit extends Cubit<CommonState> {
  final KhanePaniRepository khanePaniRepository;
  KhanePaniCubit({required this.khanePaniRepository}) : super(CommonInitial());
  Future<dynamic> fetchKhanepaniCounter() async {
    emit(CommonLoading());
    try {
      final response = await khanePaniRepository.getKhanePaniCounterList();

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
