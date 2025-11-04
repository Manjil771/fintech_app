import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/resources/datapack_repository.dart';

class DatapackCubit extends Cubit<CommonState> {
  final DatapackRepository datapackRepository;
  DatapackCubit({required this.datapackRepository}) : super(CommonInitial());
  Future<dynamic> fetchDatapack(serviceIdentifier) async {
    emit(CommonLoading());
    try {
      final response =
          await datapackRepository.getDatapackList(serviceIdentifier);

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
