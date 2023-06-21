import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/feature/history/models/recent_transaction_model.dart';
import 'package:ismart/feature/history/resources/recent_transaction_repository.dart';

class RecentTransactionCubit extends Cubit<CommonState> {
  final RecentTransactionRepository recentTransactionRepository;
  RecentTransactionCubit({required this.recentTransactionRepository})
      : super(CommonInitial());
  Future<dynamic> fetchrecentTransaction() async {
    emit(CommonLoading());
    try {
      String mPin = await SecureStorageService.appPassword;
      final response = await recentTransactionRepository.getRecentTransaction();

      if (response.status == Status.Success && response.data != null) {
        emit(CommonDataFetchSuccess<RecentTransactionModel>(
            data: response.data!));
      } else {
        emit(CommonError(
            message: response.message ?? "Error fetching customer detail."));
      }
    } catch (e) {
      emit(CommonError(message: e.toString()));
    }
  }

  generateUrl({
    required String transactionId,
  }) async {
    emit(CommonLoading());
    try {
      final response = await recentTransactionRepository.generateDownloadUrl(
        transactionId: transactionId,
      );

      if (response.status == Status.Success && response.data != null) {
        emit(CommonStateSuccess<String>(data: response.data!));
      } else {
        emit(CommonError(
            message: response.message ?? "Error fetching customer detail."));
      }
    } catch (e) {
      emit(CommonError(message: e.toString()));
    }
  }
}
