import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/resource/credit_card_bank_model.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/resource/credit_card_repository.dart';

class CreditCardCubit extends Cubit<CommonState> {
  CreditCardRepository creditCardRepository;

  CreditCardCubit({
    required this.creditCardRepository,
  }) : super(CommonInitial());

  fetchBanksList({required String apiEndPoint}) async {
    emit(CommonLoading());

    final res =
        await creditCardRepository.getBanksList(apiEndpoint: apiEndPoint);
    if (res.status == Status.Success && res.data != null) {
      emit(CommonDataFetchSuccess<CreditCardBankList>(data: res.data!));
    } else {
      emit(CommonError(
        message: res.message ?? "Error fetching wallet balance.",
      ));
    }
  }

  fetchCharge({required String amount, required String bankId}) async {
    emit(CommonLoading());

    final res = await creditCardRepository.getBankCharges(
      amount: amount,
      bankId: bankId,
    );
    if (res.status == Status.Success && res.data != null) {
      emit(CommonStateSuccess(data: res.data!));
    } else {
      emit(CommonError(
        message: res.message ?? "Error fetching wallet balance.",
      ));
    }
  }
}
