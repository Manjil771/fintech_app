import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';
import 'package:ismart/common/util/fingerprint_utils.dart';
import 'package:ismart/common/util/secure_storage_service.dart';

import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/custom_pin_field.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';

class TransactionPinScreen extends StatefulWidget {
  final Function(String) onValueCallback;

  const TransactionPinScreen({super.key, required this.onValueCallback});
  @override
  State<TransactionPinScreen> createState() => _TransactionPinScreenState();
}

class _TransactionPinScreenState extends State<TransactionPinScreen> {
  String pinValue = "";

  final ValueNotifier<bool> _isBiometricEnabled = ValueNotifier(false);
  @override
  void initState() {
    _checkBiometric();
    super.initState();
  }

  _checkBiometric() async {
    bool? isLocalBiometricEnabled = await SharedPref.getBiometricLogin();
    if (isLocalBiometricEnabled != null && isLocalBiometricEnabled) {
      _isBiometricEnabled.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;

    final width = SizeUtils.width;
    final height = SizeUtils.height;
    final _theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: [
              SizedBox(height: _height * 0.03),
              Container(
                padding: const EdgeInsets.all(30),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: CustomTheme.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      Assets.verify,
                      color: const Color(0xff4E4E4E),
                      height: _height * 0.05,
                    ),
                    SizedBox(height: _height * 0.02),
                    Text(
                      "Enter your MPIN",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: _height * 0.01),
                    Text("Please enter your MPIN to proceed.",
                        style: Theme.of(context).textTheme.headlineSmall),
                    SizedBox(height: _height * 0.04),
                    //TODO need to remove condition ,using just for test
                    CustomPinCodeField(
                      // length: 5,
                      length: RepositoryProvider.of<CustomerDetailRepository>(
                                      context)
                                  .selectedAccount
                                  .value!
                                  .accountHolderName ==
                              "Umesh Giri"
                          ? 6
                          : 5,
                      onChanged: (p0) {
                        pinValue = p0;
                      },
                    ),
                    SizedBox(height: _height * 0.05),
                    CustomRoundedButtom(
                      title: "Proceed",
                      onPressed: () {
                        widget.onValueCallback(pinValue);
                      },
                    ),
                    SizedBox(height: _height * 0.01),
                    SizedBox(height: size.height * 0.01),
                    SizedBox(height: height * 0.014),
                    ValueListenableBuilder<bool>(
                        valueListenable: _isBiometricEnabled,
                        builder: (context, val, _) {
                          if (val) {
                            return InkWell(
                              onTap: () async {
                                bool authenticated =
                                    await FingerPrintUtils.verifyFingerPrint(
                                  context: NavigationService.context,
                                );
                                if (authenticated) {
                                  final String password =
                                      await SecureStorageService.appPassword;

                                  if (password.isNotEmpty) {
                                    widget.onValueCallback(password);
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.fingerprint,
                                    size: 35,
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  Text(
                                    "User Biometric ",
                                    style: _theme.textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                    TextButton(
                        onPressed: () {
                          NavigationService.pop();
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
