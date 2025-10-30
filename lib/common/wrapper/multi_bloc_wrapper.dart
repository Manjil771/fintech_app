import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/feature/authentication/cubit/login_cubit.dart';
import 'package:ismart/feature/authentication/cubit/validate_co_op_cubit.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/chatBot/resources/audio_upload_repository.dart';
import 'package:ismart/feature/chatBot/resources/cubits/audio_upload_cubit.dart';
import 'package:ismart/feature/customerDetail/cubit/customer_detail_cubit.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/profile/resources/cubits/image_upload_cubit.dart';
import 'package:ismart/feature/profile/resources/image_upload_repository.dart';
import 'package:ismart/feature/update/cubit/update_cubit.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  final CoOperative env;
  const MultiBlocWrapper({required this.child, required this.env});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => ValidateCoOpCubit(
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => CustomerDetailCubit(
            customerDetailRepository:
                RepositoryProvider.of<CustomerDetailRepository>(context),
          ),
        ),

        BlocProvider(
          create: (context) => UpdateCubit(),
          lazy: false,
        ),

        BlocProvider(
          create: (context) => ImageUploadCubit(
            imageUploadRepository:
                RepositoryProvider.of<ImageUploadRepository>(context),
          ),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => AudioUploadCubit(
            audioUploadRepository:
                RepositoryProvider.of<AudioUploadRepository>(context),
          ),
          lazy: false,
        ),
        // BlocProvider(
        //   create: (context) => AppServiceCubit(p
        //     appServiceRepository:
        //         RepositoryProvider.of<AppServiceRepository>(context),
        //   ),
        // )
      ],
      child: child,
    );
  }
}
