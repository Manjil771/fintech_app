// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ismart/common/common/data_state.dart';
// import 'package:ismart/common/http/response.dart';
// import 'package:ismart/feature/sendMoney/resources/send_to_bank_repository.dart';

// class BankChargeCubit extends Cubit<CommonState> {
//   SendToBankRepository sendToBankRepository;

//   BankChargeCubit({
//     required this.sendToBankRepository,
//   }) : super(CommonInitial());

//   getBankCharges({
//     required String amount,
//     required String bankId,
//   }) async {
//     emit(CommonLoading());

//     final res = await sendToBankRepository.getBankCharges(
//       amount: amount,
//       bankId: bankId,
//     );
//     if (res.status == Status.Success && res.data != null) {
//       emit(CommonStateSuccess(data: res.data!));
//     } else {
//       emit(CommonError(
//         message: res.message ?? "Error fetching wallet balance.",
//       ));
//     }
//   }
// }
