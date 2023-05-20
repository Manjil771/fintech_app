import 'package:ismart/common/constant/env.dart';
import 'package:ismart/feature/authentication/cubit/social_login_cubit.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  final Env env;
  const MultiBlocWrapper({required this.child, required this.env});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialLoginCubit(
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
        )
      ],
      child: child,
    );
  }
}
