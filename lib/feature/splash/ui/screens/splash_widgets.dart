import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/feature/authentication/ui/screens/login_page.dart';
import 'package:ismart/feature/splash/cubit/startup_cubit.dart';
import 'package:ismart/feature/splash/resource/startup_repository.dart';
import 'package:ismart/feature/update/cubit/update_cubit.dart';

class SplashWidget extends StatefulWidget {
  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  String _splashAsset = "";
  @override
  void initState() {
    _splashAsset = RepositoryProvider.of<CoOperative>(context).splashImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return BlocListener<StartupCubit, StartupState>(
      listener: (context, state) {
        if (state is StartupSuccess) {
          NavigationService.pushReplacement(target: const LoginPage());
          // if (state.isFirstTime) {
          //   NavigationService.push(target: OnboardPage());
          // } else
          // if (state.isLogged) {
          //   NavigationService.pushReplacement(target: const DashboardPage());
          // }
          // else {
          //   NavigationService.pushReplacement(target: const LoginPage());
          // }

          Future.delayed(const Duration(milliseconds: 500), () {
            final _updateValue = RepositoryProvider.of<StartUpRepository>(
                    NavigationService.context)
                .appUpdate;
            if (_updateValue != null) {
              BlocProvider.of<UpdateCubit>(NavigationService.context)
                  .showUpdate(_updateValue);
            }
          });
        }
      },
      child: Scaffold(
        body: Image.asset(
          RepositoryProvider.of<CoOperative>(context).splashImage,
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
