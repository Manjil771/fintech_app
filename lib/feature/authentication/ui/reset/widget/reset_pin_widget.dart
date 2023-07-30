import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/ismart_top_widget.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/authentication/ui/widgets/otp_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class ResetPinWidget extends StatelessWidget {
  ResetPinWidget({Key? key}) : super(key: key);
  final _accountNumberController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  bool _isLoading = false;
  final _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      showAppBar: false,
      body: BlocListener<UtilityPaymentCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoading && _isLoading == false) {
            _isLoading = true;
            showLoadingDialogBox(context);
          } else if (state is! CommonLoading && _isLoading) {
            _isLoading = false;
            NavigationService.pop();
          }
          if (state is CommonError) {
            showPopUpDialog(
              context: context,
              message: state.message,
              title: "Error",
              showCancelButton: false,
              buttonCallback: () {
                NavigationService.pop();
              },
            );
          }

          if (state is CommonStateSuccess<UtilityResponseData>) {
            UtilityResponseData _response = state.data;

            NavigationService.push(target: OTPWidget(onValueCallback: (p0) {
              NavigationService.pop();
            }));
            // TODO: implement listener
          }
          print("state is +$state");
        },
        child: Column(
          children: [
            IsmartTopWidget(),
            CommonContainer(
                onButtonPressed: () {
                  if (_fromKey.currentState!.validate()) {
                    context.read<UtilityPaymentCubit>().makePayment(
                        serviceIdentifier: "",
                        accountDetails: {
                          "mobileNumber": _mobileNumberController.text,
                          "accountNumber": _accountNumberController.text,
                          "clientId":
                              RepositoryProvider.of<CoOperative>(context)
                                  .clientCode,
                          // "smsReadToken"
                        },
                        body: {},
                        apiEndpoint: "/customer/reset/send",
                        mPin: "");
                  }
                },
                buttonName: "Proceed",
                title: "Reset Pin",
                showDetail: false,
                body: Form(
                  key: _fromKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        title: "Mobile Number",
                        validator: (value) =>
                            FormValidator.validatePhoneNumber(value),
                      ),
                      CustomTextField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        title: "Account Number",
                        validator: (value) =>
                            FormValidator.validateFieldNotEmpty(
                                value, "Account Number"),
                      ),
                    ],
                  ),
                ),
                topbarName: "Reset Pin")
          ],
        ),
      ),
    );
  }
}
