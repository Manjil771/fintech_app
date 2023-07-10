import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/splash/cubit/startup_cubit.dart';
import 'package:ismart/feature/splash/resource/startup_repository.dart';
import 'package:ismart/feature/splash/ui/screens/splash_widgets.dart';

class SplashScreens extends StatelessWidget {
  const SplashScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StartupCubit(
        startUpRepository: RepositoryProvider.of<StartUpRepository>(context),
        userRepository: RepositoryProvider.of<UserRepository>(context),
      )..fetchStartupData(),
      child: SplashWidget(),
    );
  }
}
