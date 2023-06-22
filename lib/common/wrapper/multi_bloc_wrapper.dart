import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/feature/appServiceManagement/cubit/app_service_cubit.dart';
import 'package:ismart/feature/appServiceManagement/resource/app_service_repository.dart';
import 'package:ismart/feature/authentication/cubit/login_cubit.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/customerDetail/cubit/customer_detail_cubit.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/cubit/category_cubit.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/resources/category_repository.dart';

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
          create: (context) => CustomerDetailCubit(
            customerDetailRepository:
                RepositoryProvider.of<CustomerDetailRepository>(context),
          ),
        ),
        // BlocProvider(
        //   create: (context) => AppServiceCubit(
        //     appServiceRepository:
        //         RepositoryProvider.of<AppServiceRepository>(context),
        //   ),
        // )
      ],
      child: child,
    );
  }
}
