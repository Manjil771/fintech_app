import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/statement/fullStatement/model/full_statement_model.dart';
import 'package:ismart/feature/statement/fullStatement/resources/full_statement_repository.dart';
import 'package:ismart/feature/statement/miniStatement/models/mini_statement_model.dart';
import 'package:ismart/feature/statement/miniStatement/resources/mini_statement_repository.dart';

class FullStatementCubit extends Cubit<CommonState> {
  final FullStatementRepository fullStatementRepository;
  FullStatementCubit({required this.fullStatementRepository})
      : super(CommonInitial());
  Future<dynamic> fetchFullStatement({
    required String accountNumber,
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    emit(CommonLoading());
    try {
      final response = await fullStatementRepository.getFullStatement(
          accountNumber: accountNumber, fromDate: fromDate, toDate: toDate);

      if (response.status == Status.Success && response.data != null) {
        emit(CommonStateSuccess<FullStatementModel>(data: response.data!));
      } else {
        emit(CommonError(
            message: response.message ?? "Error fetching customer detail."));
      }
    } catch (e) {
      emit(CommonError(message: e.toString()));
    }
  }
}
