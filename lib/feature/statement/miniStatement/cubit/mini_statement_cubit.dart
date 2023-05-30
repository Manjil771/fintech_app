import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/statement/miniStatement/resources/mini_statement_repository.dart';

class MiniStatementCubit extends Cubit<CommonState> {
  final MiniStatementRepository miniStatementRepository;
  MiniStatementCubit({required this.miniStatementRepository})
      : super(CommonInitial());
  Future<dynamic> fetchMiniStatement(accountNumbner, mPin) async {
    emit(CommonLoading());
    try {
      final response =
          await miniStatementRepository.getMiniStatement(accountNumbner, mPin);

      if (response.status == Status.Success && response.data != null) {
        emit(CommonStateSuccess<dynamic>(data: response.data!));
      } else {
        emit(CommonError(
            message: response.message ?? "Error fetching customer detail."));
      }
    } catch (e) {
      emit(CommonError(message: e.toString()));
    }
  }
}
