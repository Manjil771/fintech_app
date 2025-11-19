import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/receiveMoney/resources/receive_money_repository.dart';
import 'package:ismart/feature/sendMoney/models/bank.dart';

class KhaltiTxnConfirmCubit extends Cubit<CommonState> {
  ReceiveMoneyRepository receiveMoneyRepository;

  KhaltiTxnConfirmCubit({
    required this.receiveMoneyRepository,
  }) : super(CommonInitial());

  completeKhaltiTxn({
    required String amount,
    required String status,
    required String transaction_id,
    required String pidx,
  }) async {
    emit(CommonLoading());

    final res = await receiveMoneyRepository.completeKhaltiTxn(
      status: status,
      amount: amount,
      pidx: pidx,
      transaction_id: transaction_id,
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
