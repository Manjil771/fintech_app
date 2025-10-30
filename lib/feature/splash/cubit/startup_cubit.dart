import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';
import 'package:ismart/feature/appServiceManagement/resource/app_service_repository.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/dashboard/bannerImage/resource/banner_repository.dart';
import 'package:ismart/feature/splash/resource/startup_repository.dart';

part 'startup_state.dart';

class StartupCubit extends Cubit<StartupState> {
  StartupCubit(
      {required this.startUpRepository,
      required this.userRepository,
      required this.appServiceRepository,
      required this.bannerRepository})
      : super(StartupInitial());
  final AppServiceRepository appServiceRepository;
  final StartUpRepository startUpRepository;
  final UserRepository userRepository;
  final BannerRepository bannerRepository;
  fetchStartupData() async {
    emit(StartupLoading());
    final isFirstTime = await SharedPref.getFirstTimeAppOpen();
    await userRepository.initialState();
    await startUpRepository.fetchBannerImages();
    await startUpRepository.fetchAppConfig();
    await startUpRepository.fetchdefaultBannerImages();
    await bannerRepository.fetchBannerImages(bannerImageType: "OfferBanner");
    await bannerRepository.fetchEventPoster(bannerImageType: "EventFestivals");
    await startUpRepository.getAppService();

    if (isFirstTime) {
      await SharedPref.setFirstTimeAppOpen(false);
    }
    Future.delayed(const Duration(milliseconds: 800));
    emit(StartupSuccess(
      isFirstTime: isFirstTime,
      isLogged: userRepository.isLoggedIn.value,
      // isLogged: true,
    ));
  }
}
