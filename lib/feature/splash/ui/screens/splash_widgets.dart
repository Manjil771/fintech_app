import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/feature/authentication/ui/screens/login_page.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/splash/cubit/startup_cubit.dart';

class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return BlocListener<StartupCubit, StartupState>(
      listener: (context, state) {
        if (state is StartupSuccess) {
          NavigationService.push(target: const LoginPage());
          // if (state.isFirstTime) {
          //   NavigationService.push(target: OnboardPage());
          // } else
          // if (state.isLogged) {
          //   NavigationService.pushReplacement(target: const DashboardPage());
          // } else {
          //   NavigationService.pushReplacement(target: const LoginPage());
          // }
        }
      },
      child: Scaffold(
        body: Container(
          child: Image.asset(
            Assets.splashImage,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
