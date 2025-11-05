import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/qrCode/shareQr/resources/qr_repository.dart';

class QrCubit extends Cubit<CommonState> {
  final QrRepository qrRepository;
  QrCubit({required this.qrRepository}) : super(CommonInitial());
  Future<dynamic> generateQr(
      {required String customerName, required String customerId}) async {
    emit(CommonLoading());
    try {
      // final String mPin = await SecureStorageService.appPassword;
      final response = await qrRepository.generateQr(
          customerName: customerName, customerId: customerId);

      if (response.status == Status.Success) {
        emit(CommonStateSuccess(data: response.data!));
      } else {
        emit(CommonError(message: response.message ?? "Error fetching qr"));
      }
    } catch (e) {
      emit(CommonError(message: e.toString()));
    }
  }
}
