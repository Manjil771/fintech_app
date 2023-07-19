import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_sector_model.dart';
import 'package:ismart/feature/categoryWiseService/airlines/resources/airlines_repository.dart';
import 'package:ismart/feature/statement/fullStatement/model/full_statement_model.dart';
import 'package:ismart/feature/statement/fullStatement/resources/full_statement_repository.dart';

class AirlinesCubit extends Cubit<CommonState> {
  final AirlinesRepository airlinesRepository;
  AirlinesCubit({required this.airlinesRepository}) : super(CommonInitial());
  Future<dynamic> fetchAirlinesList() async {
    emit(CommonLoading());
    try {
      final response = await airlinesRepository.getAirlinesLocation();

      if (response.status == Status.Success && response.data != null) {
        emit(CommonDataFetchSuccess<AirlinesSectorList>(
            data: response.data ?? []));
      } else {
        emit(CommonError(
            message: response.message ?? "Error fetching customer detail."));
      }
    } catch (e) {
      emit(CommonError(message: e.toString()));
    }
  }
}
