import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/authentication/ui/screens/login_page.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/splash/cubit/startup_cubit.dart';
import 'package:ismart/feature/splash/resource/startup_repository.dart';
import 'package:ismart/feature/update/cubit/update_cubit.dart';
import 'package:vpn_connection_detector/vpn_connection_detector.dart';

class SplashWidget extends StatefulWidget {
  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  // String _splashAsset = "";
  @override
  void initState() {
    // _splashAsset = RepositoryProvider.of<CoOperative>(context).splashImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StartupCubit, StartupState>(
      listener: (context, state) {
        if (state is StartupSuccess) {
          NavigationService.pushReplacement(target: const LoginPage());

          if (state.isLogged && kDebugMode) {
            NavigationService.pushReplacement(target: const DashboardPage());
          }
          // if (state.isFirstTime) {
          //   NavigationService.push(target: OnboardPage());
          // } else

          // else {
          //   NavigationService.pushReplacement(target: const LoginPage());
          // }

          Future.delayed(const Duration(seconds: 3), () {
            final _updateValue = RepositoryProvider.of<StartUpRepository>(
                    NavigationService.context)
                .appUpdate;
            // if (_updateValue != null) {
            //   BlocProvider.of<UpdateCubit>(NavigationService.context)
            //       .showUpdate(_updateValue);
            // }
          });
        }
      },
      child: Scaffold(
        // backgroundColor: CustomTheme.testAppColor,
        body: SafeArea(
          child: Image.asset(
            RepositoryProvider.of<CoOperative>(context).splashImage,
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
