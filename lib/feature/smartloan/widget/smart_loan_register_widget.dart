import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/util/snackbar_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/smartloan/screen/smart_loan_apply_screen.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class SmartLoanRegisterWidget extends StatefulWidget {
  const SmartLoanRegisterWidget({super.key});

  @override
  State<SmartLoanRegisterWidget> createState() =>
      _SmartLoanRegisterWidgetState();
}

class _SmartLoanRegisterWidgetState extends State<SmartLoanRegisterWidget> {
  bool checkAggrement = true;
  Future<String> getMpin() async {
    final String mPin = await SecureStorageService.appPassword;
    return mPin;
  }

  @override
  void initState() {
    getMpin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final customer = RepositoryProvider.of<CustomerDetailRepository>(context);
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return PageWrapper(
      showBackButton: true,
      body: BlocBuilder<UtilityPaymentCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonStateSuccess<UtilityResponseData>) {
            final UtilityResponseData res = state.data;
            if (res.code == "M0000") {
              final String maxLoanAmount = res.findValueString("maximumAmount");
              final String minLoanAmount = res.findValueString("minimumAmount");

              return Column(
                children: [
                  Text(
                    "Register for Loan",
                    style: _textTheme.headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.hp),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: CustomTheme.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.instaLoanIcon,
                          height: 30.hp,
                        ),
                        SizedBox(height: 30.hp),
                        Text(
                          "You are being registered in smartInstaLoan with following information. ",
                          style: _textTheme.labelLarge!.copyWith(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 15.hp),
                        const KeyValueTile(title: "Full Name", value: "test"),
                        const KeyValueTile(
                            title: "Account Type", value: "test"),
                        const KeyValueTile(
                            title: "Account Number", value: "test"),
                        const KeyValueTile(
                            title: "Mobile Number", value: "test"),
                        const KeyValueTile(title: "Address", value: "test"),
                        SizedBox(height: 30.hp),
                        Text(
                          "After clicking Register we will send OTP to your registered mobile number.",
                          style: _textTheme.labelLarge,
                        ),
                        SizedBox(height: 20.hp),
                        Row(
                          children: [
                            Checkbox(
                                value: checkAggrement,
                                onChanged: (val) {
                                  setState(() {
                                    checkAggrement = !checkAggrement;
                                  });
                                }),
                            const Text(
                                "I agree to the terms of use of this service."),
                          ],
                        ),
                        SizedBox(height: 30.hp),
                        CustomRoundedButtom(
                          isDisabled: !checkAggrement,
                          title: "Register",
                          onPressed: () async {
                            final String mPin = await getMpin();
                            if (checkAggrement) {
                              NavigationService.push(
                                target: TransactionPinScreen(
                                  onValueCallback: (p0) {
                                    if (p0 == mPin) {
                                      NavigationService.pushReplacement(
                                          target: SmartLoanApplyScreen(
                                        minLoanAmount:
                                            double.parse(minLoanAmount),
                                        maxLoanAmount:
                                            double.parse(maxLoanAmount),
                                      ));
                                    } else {
                                      NavigationService.pop();
                                      SnackBarUtils.showErrorBar(
                                          context: context,
                                          message:
                                              "The Pin you entered is not correct");
                                    }
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return NoDataScreen(title: "Error", details: state.data.message);
            }
          } else if (state is CommonLoading) {
            return const CommonLoadingWidget();
          } else {
            return const NoDataScreen(
                title: "Error", details: "Please try again later.");
          }
        },
      ),
    );
  }
}
