import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/models/internal_branch.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/resources/internal_transfer_repository.dart';

class CoopListCubit extends Cubit<CommonState> {
  InternalTransferRepository internalTransferRepository;

  CoopListCubit({
    required this.internalTransferRepository,
  }) : super(CommonInitial());

  sendMoneyToBank({
    required String charge,
    required String amount,
    required String mpin,
    required String remarks,
    required String receivingAccount,
    required String receivingBranchId,
    required String sendingAccount,
  }) async {
    emit(CommonLoading());

    final res = await internalTransferRepository.fundTranfer(
      amount: amount,
      mpin: mpin,
      remarks: remarks,
      receivingAccount: receivingAccount,
      receivingBranchId: receivingBranchId,
      sendingAccount: sendingAccount,
    );
    if (res.status == Status.Success && res.data != null) {
      emit(CommonStateSuccess(data: res.data!));
    } else {
      emit(CommonError(
        message: res.message ?? "Error fetching wallet balance.",
      ));
    }
  }

  fetchBanksList() async {
    emit(CommonLoading());

    final res = await internalTransferRepository.getBranchList();
    if (res.status == Status.Success && res.data != null) {
      emit(CommonDataFetchSuccess<InternalBranch>(data: res.data!));
    } else {
      emit(CommonError(
        message: res.message ?? "Error fetching wallet balance.",
      ));
    }
  }
}
