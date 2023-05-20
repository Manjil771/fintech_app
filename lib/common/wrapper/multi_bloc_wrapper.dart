import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  final Env env;
  const MultiBlocWrapper({required this.child, required this.env});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: const [
        // BlocProvider(
        //   create: (context) => SocialLoginCubit(
        //     userRepository: RepositoryProvider.of<UserRepository>(context),
        //   ),
        // )
      ],
      child: child,
    );
  }
}
