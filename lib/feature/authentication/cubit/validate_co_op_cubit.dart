import 'package:bloc/bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/authentication/model/coop_value.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class ValidateCoOpCubit extends Cubit<CommonState> {
  ValidateCoOpCubit({required this.userRepository}) : super(CommonInitial());

  UserRepository userRepository;

  validateCoOperative({
    required String username,
  }) async {
    emit(CommonLoading());
    final res = await userRepository.validateCoOperative(
      username: username,
    );
    if (res.status == Status.Success && res.data != null) {
      emit(CommonStateSuccess<LoginCoOpValue>(data: res.data!));
    } else {
      emit(
        CommonError(
          message: res.message ?? "Error finding co-op value.",
          statusCode: res.statusCode,
        ),
      );
    }
  }
}
