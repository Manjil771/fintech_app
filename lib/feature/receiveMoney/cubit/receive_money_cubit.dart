import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/receiveMoney/resources/receive_money_repository.dart';
import 'package:ismart/feature/sendMoney/models/bank.dart';

class ReceiveMoneyCubit extends Cubit<CommonState> {
  ReceiveMoneyRepository receiveMoneyRepository;

  ReceiveMoneyCubit({
    required this.receiveMoneyRepository,
  }) : super(CommonInitial());

  loadFromBank({
    required String bankCode,
    required String amount,
    required String remarks,
    required String accountNumber,
  }) async {
    emit(CommonLoading());

    final res = await receiveMoneyRepository.loadFromBank(
      bankCode: bankCode,
      accountNumber: accountNumber,
      amount: amount,
      remarks: remarks,
    );
    if (res.status == Status.Success && res.data != null) {
      emit(CommonStateSuccess(data: res.data!));
    } else {
      emit(CommonError(
        message: res.message ?? "Error fetching wallet balance.",
      ));
    }
  }

  loadFromKhalti({
    required String amount,
    required String remarks,
    required String accountNumber,
  }) async {
    emit(CommonLoading());

    final res = await receiveMoneyRepository.loadFromKhalti(
      accountNumber: accountNumber,
      amount: amount,
      remarks: remarks,
    );
    if (res.status == Status.Success && res.data != null) {
      emit(CommonStateSuccess(data: res.data!));
    } else {
      emit(CommonError(
        message: res.message ?? "Error fetching wallet balance.",
      ));
    }
  }

  fetchBanksList({required String type}) async {
    emit(CommonLoading());

    final res = await receiveMoneyRepository.fetchBanksList(
      type: type,
    );
    if (res.status == Status.Success && res.data != null) {
      emit(CommonDataFetchSuccess<Bank>(data: res.data!));
    } else {
      emit(CommonError(
        message: res.message ?? "Error fetching wallet balance.",
      ));
    }
  }
}
