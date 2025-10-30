import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/feature/statement/miniStatement/models/mini_statement_model.dart';
import 'package:ismart/feature/statement/miniStatement/resources/mini_statement_repository.dart';

class MiniStatementCubit extends Cubit<CommonState> {
  final MiniStatementRepository miniStatementRepository;
  MiniStatementCubit({required this.miniStatementRepository})
      : super(CommonInitial());
  Future<dynamic> fetchMiniStatement({required String accountNumbner}) async {
    emit(CommonLoading());
    try {
      final String mPin = await SecureStorageService.appPassword;

      final response =
          await miniStatementRepository.getMiniStatement(accountNumbner, mPin);

      if (response.status == Status.Success && response.data != null) {
        emit(CommonStateSuccess<MiniStatementModel>(data: response.data!));
      } else {
        emit(CommonError(
            message: response.message ?? "Error fetching customer detail."));
      }
    } catch (e) {
      emit(CommonError(message: e.toString()));
    }
  }
}
