import 'package:bloc/bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/authentication/enum/login_response_value.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class LoginCubit extends Cubit<CommonState> {
  LoginCubit({required this.userRepository}) : super(CommonInitial());

  UserRepository userRepository;

  loginUser({
    required String username,
    required String password,
    required String deviceUUID,
    String? otpCode,
  }) async {
    emit(CommonLoading());
    final res = await userRepository.loginUser(
      username: username,
      password: password,
      deviceUUID: deviceUUID,
      otpCode: otpCode,
    );
    if (res.status == Status.Success && res.data != null) {
      emit(CommonStateSuccess<LoginResponseValue>(data: res.data!));
    } else {
      emit(
        CommonError(
          message: res.message ?? "Error logging in.",
          statusCode: res.statusCode,
        ),
      );
    }
  }
}
