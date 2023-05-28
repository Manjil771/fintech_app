import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/sendMoney/models/bank.dart';
import 'package:ismart/feature/sendMoney/resources/send_to_bank_repository.dart';

class SendToBankCubit extends Cubit<CommonState> {
  SendToBankRepository sendToBankRepository;

  SendToBankCubit({
    required this.sendToBankRepository,
  }) : super(CommonInitial());

  // sendMoneyToBank({
  //   required String destinationBankName,
  //   required String mpin,
  //   required String amount,
  //   required String remarks,
  //   required String purpose,
  //   required String destinationBankInstrumentCode,
  //   required String destinationBankAccountName,
  //   required String destinationBankAccountNumber,
  //   required String serviceCharge,
  //   required String totalAmount,
  //   required String gatewayCharge,
  //   required String adminCommission,
  //   required bool isMobile,
  // }) async {
  //   emit(CommonLoading());

  //   final res = await sendToBankRepository.sendMoneyToBank(
  //     userLoginID: userRepository.user.value!.phone,
  //     amount: totalCalculatedAmount.toString(),
  //     mpin: mpin,
  //     remarks: remarks,
  //     adminCommission: adminCommission,
  //     destinationBankAccountName: destinationBankAccountName,
  //     destinationBankAccountNumber: destinationBankAccountNumber,
  //     destinationBankInstrumentCode: destinationBankInstrumentCode,
  //     destinationBankName: destinationBankName,
  //     gatewayCharge: gatewayCharge,
  //     purpose: purpose,
  //     serviceCharge: serviceCharge,
  //     totalAmount: totalCalculatedAmount.toString(),
  //     isMobile: isMobile,
  //   );
  //   if (res.status == Status.Success && res.data != null) {
  //     emit(CommonStateSuccess(data: res.data!));
  //   } else {
  //     emit(CommonError(
  //       message: res.message ?? "Error fetching wallet balance.",
  //     ));
  //   }
  // }

  fetchBanksList() async {
    emit(CommonLoading());

    final res = await sendToBankRepository.getBanksList();
    if (res.status == Status.Success && res.data != null) {
      emit(CommonDataFetchSuccess<Bank>(data: res.data!));
    } else {
      emit(CommonError(
        message: res.message ?? "Error fetching wallet balance.",
      ));
    }
  }
}
