import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/splash/resource/startup_repository.dart';

part 'startup_state.dart';

class StartupCubit extends Cubit<StartupState> {
  StartupCubit({required this.startUpRepository, required this.userRepository})
      : super(StartupInitial());

  final StartUpRepository startUpRepository;
  final UserRepository userRepository;

  fetchStartupData() async {
    emit(StartupLoading());
    final isFirstTime = await SharedPref.getFirstTimeAppOpen();
    await userRepository.initialState();
    await startUpRepository.fetchConfig();
    await Future.delayed(const Duration(seconds: 2));

    if (isFirstTime) {
      await SharedPref.setFirstTimeAppOpen(false);
    }
    emit(StartupSuccess(
      isFirstTime: isFirstTime,
      // isLogged: userRepository.isLoggedIn.value,
      isLogged: false,
    ));
  }
}
