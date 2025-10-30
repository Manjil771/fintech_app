import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/receiveMoney/resources/receive_from_bank_repository.dart';
import 'package:ismart/feature/sendMoney/models/bank.dart';

class ReceiveFromBankCubit extends Cubit<CommonState> {
  ReceiveFromBankRepository receiveFromBankRepository;

  ReceiveFromBankCubit({
    required this.receiveFromBankRepository,
  }) : super(CommonInitial());

  receiveMoneyFromBank({
    //required String charge,
    required String amount,
    //required String mpin,
    required String remarks,
    required String destinationBankInstrumentCode,
    //required String destinationBankAccountName,
    required String destinationBankAccountNumber,
    //required String destinationBankName,
  }) async {
    emit(CommonLoading());

    final res = await receiveFromBankRepository.receiveMoneyFromBank(
      amount: amount,
      accountNumber: destinationBankAccountNumber,
      bankInstrumentCode: destinationBankInstrumentCode,
      // mpin: mpin,
      remarks: remarks,
      //destinationBankAccountName: destinationBankAccountName,
      //destinationBankAccountNumber: destinationBankAccountNumber,
      //destinationBankInstrumentCode: destinationBankInstrumentCode,
      //serviceCharge: charge,
      //destinationBankName: destinationBankName,
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

    final res = await receiveFromBankRepository.getBanksList();
    if (res.status == Status.Success && res.data != null) {
      emit(CommonDataFetchSuccess<Bank>(data: res.data!));
    } else {
      emit(CommonError(
        message: res.message ?? "Error fetching wallet balance.",
      ));
    }
  }
}
