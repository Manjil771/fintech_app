import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/authentication/ui/actiateAccount/widget/registration_mpin_widget.dart';
import 'package:ismart/feature/authentication/ui/actiateAccount/widget/registration_otp_widget.dart';
import 'package:ismart/feature/authentication/ui/resetPin/cubit/reset_pin_cubit.dart';
import 'package:ismart/feature/authentication/ui/resetPin/resources/reset_pin_repository.dart';
import 'package:ismart/feature/authentication/ui/resetPin/widget/reset_otp_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class RegisterMpinPage extends StatelessWidget {
  final String mobileNumber;
  final String accountNumber;
  final String otp;

  const RegisterMpinPage(
      {super.key,
      required this.mobileNumber,
      required this.accountNumber,
      required this.otp});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return BlocProvider(
        create: (context) => ResetPinCubit(
            resetPinRepository:
                RepositoryProvider.of<ResetPinRepository>(context)),
        child: RegisterMpinWidget(
          otp: otp,
          accountNumber: accountNumber,
          mobileNumber: mobileNumber,
        ));
  }
}
