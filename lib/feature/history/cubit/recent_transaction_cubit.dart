import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/history/models/recent_transaction_model.dart';
import 'package:ismart/feature/history/resources/recent_transaction_repository.dart';

class RecentTransactionCubit extends Cubit<CommonState> {
  int _currentPage = 1;
  bool _hasdata = true;
  bool _isloading = false;
  final RecentTransactionRepository recentTransactionRepository;
  RecentTransactionCubit({required this.recentTransactionRepository})
      : super(CommonInitial());

  Future<dynamic> fetchInitialrecentTransaction(
      {String? service,
      required String serviceCategoryId,
      required String serviceId,
      String? fromDate,
      String? toDate,
      required String associatedId}) async {
    emit(CommonLoading());
    _isloading = true;
    try {
      final response = await recentTransactionRepository.getRecentTransaction(
          pageNo: 1,
          fromDate: fromDate ?? "",
          toDate: toDate ?? "",
          serviceId: serviceId,
          service: service ?? "SERVICE",
          serviceCategoryId: serviceCategoryId,
          associatedId: associatedId);
      _currentPage = 1;
      if (response.status == Status.Success) {
        _isloading = false;
        emit(CommonDataFetchSuccess<RecentTransactionModel>(
            data: response.data!));
        _hasdata = true;
      } else {
        _isloading = false;
        emit(CommonError(
            message: response.message ?? "Error fetching customer detail."));
      }
    } catch (e) {
      _isloading = false;
      emit(CommonError(message: e.toString()));
    }
  }

  Future<dynamic> fetchrecentTransaction(
      {String? service,
      required String serviceCategoryId,
      required String serviceId,
      String? fromDate,
      String? toDate,
      required String associatedId}) async {
    final currentState = state;
    if (currentState is! CommonDataFetchSuccess<RecentTransactionModel>) return;
    if (!_hasdata || _isloading) return;
    _isloading = true;
    try {
      final nextPage = _currentPage + 1;
      final response = await recentTransactionRepository.getRecentTransaction(
          pageNo: nextPage,
          fromDate: fromDate ?? "",
          toDate: toDate ?? "",
          serviceId: serviceId,
          service: service ?? "SERVICE",
          serviceCategoryId: serviceCategoryId,
          associatedId: associatedId);

      if (response.status == Status.Success) {
        _isloading = false;
        emit(CommonDataFetchSuccess<RecentTransactionModel>(
          data: [...currentState.data, ...response.data!],
        ));
        _currentPage = _currentPage + 1;
      } else {
        _isloading = false;
        _hasdata = false;
      }
    } catch (e) {
      _isloading = false;
      emit(CommonError(message: e.toString()));
    }
  }
}
