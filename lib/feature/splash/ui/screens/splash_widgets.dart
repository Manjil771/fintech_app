import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/authentication/ui/screens/login_page.dart';
import 'package:ismart/feature/onboard/ui/screen/onboard_page.dart';
import 'package:ismart/feature/splash/cubit/startup_cubit.dart';

import '../../../dashboard/screen/dashboard_page.dart';

class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return BlocListener<StartupCubit, StartupState>(
      listener: (context, state) {
        if (state is StartupSuccess) {
          if (state.isFirstTime) {
            NavigationService.push(target: OnboardPage());
          } else if (state.isLogged) {
            NavigationService.pushReplacement(target: const DashboardPage());
          } else {
            NavigationService.pushReplacement(target: const LoginPage());
          }
        }
      },
      child: PageWrapper(
        showAppBar: false,
        body: Container(
          child: Center(
            child: Text(
              "Splash",
              style: _textTheme.titleLarge,
            ),
          ),
        ),
      ),
    );
  }
}
