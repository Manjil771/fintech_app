import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/appContact/cubit/app_contact_cubit.dart';
import 'package:ismart/feature/appContact/resources/app_contact_repository.dart';
import 'package:ismart/feature/authentication/ui/widgets/login_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UtilityPaymentCubit(
              utilityPaymentRepository:
                  RepositoryProvider.of<UtilityPaymentRepository>(context))
            ..fetchDetails(
                serviceIdentifier: "",
                accountDetails: {},
                apiEndpoint: "public/getallCountry"),
        ),
        BlocProvider(
          create: (context) => AppContactCubit(
              appContactRepository:
                  RepositoryProvider.of<AppContactRepository>(context))
            ..fetchAppContact(),
        ),
      ],
      child: const LoginWidget(),
    );
  }
}
