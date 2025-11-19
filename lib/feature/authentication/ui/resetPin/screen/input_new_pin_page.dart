import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/authentication/ui/resetPin/cubit/reset_pin_cubit.dart';
import 'package:ismart/feature/authentication/ui/resetPin/resources/reset_pin_repository.dart';
import 'package:ismart/feature/authentication/ui/resetPin/widget/input_new_pin_widget.dart';

class InputNewPinPage extends StatelessWidget {
  final String otp;
  final String mobileNumber;
  const InputNewPinPage(
      {Key? key, required this.otp, required this.mobileNumber})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPinCubit(
          resetPinRepository:
              RepositoryProvider.of<ResetPinRepository>(context)),
      child: InputNewPinWidget(
        mobileNumber: mobileNumber,
        otp: otp,
      ),
    );
  }
}
