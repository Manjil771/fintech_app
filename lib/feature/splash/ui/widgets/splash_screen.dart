import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/appServiceManagement/resource/app_service_repository.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/dashboard/bannerImage/resource/banner_repository.dart';
import 'package:ismart/feature/splash/cubit/startup_cubit.dart';
import 'package:ismart/feature/splash/resource/startup_repository.dart';
import 'package:ismart/feature/splash/ui/screens/splash_widgets.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({Key? key}) : super(key: key);

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StartupCubit(
          appServiceRepository:
              RepositoryProvider.of<AppServiceRepository>(context),
          startUpRepository: RepositoryProvider.of<StartUpRepository>(context),
          userRepository: RepositoryProvider.of<UserRepository>(context),
          bannerRepository: RepositoryProvider.of<BannerRepository>(context))
        ..fetchStartupData(),
      child: SplashWidget(),
    );
  }
}
