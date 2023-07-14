import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class ChangeMpinWidget extends StatelessWidget {
  TextEditingController oldPinController = TextEditingController();

  TextEditingController newPinController = TextEditingController();
  TextEditingController reEnterPinController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        title: "Change PIN",
        showDetail: true,
        detail: "Enter a unique PIN Code.",
        topbarName: "Settings",
        buttonName: "Submit",
        onButtonPressed: () {
          // if (_formKey.currentState!.validate()) {
          context.read<UtilityPaymentCubit>().makePayment(
            mPin: oldPinController.text,
            serviceIdentifier: "",
            // serviceIdentifier: "traffic_fine_payments",
            apiEndpoint: "/api/changepin",
            body: {},
            accountDetails: {
              "oldmPin": oldPinController.text,
              "newmPin": newPinController.text,
              "remPin": reEnterPinController.text,
            },
          );
          // }
        },
        body: BlocListener<UtilityPaymentCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoading && _isLoading == false) {
              _isLoading = true;
              showLoadingDialogBox(context);
            } else if (state is! CommonLoading && _isLoading) {
              _isLoading = false;
              NavigationService.pop();
            }

            if (state is CommonStateSuccess<UtilityResponseData>) {
              showPopUpDialog(
                context: context,
                message: state.data.message,
                title: "Success",
                showCancelButton: false,
                buttonCallback: () {
                  NavigationService.pop();
                },
              );
            } else if (state is CommonError) {
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
          },
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: oldPinController,
                  title: "Old MPin",
                  hintText: "XXXXXXX",
                  validator: (val) {
                    if (val!.length != 5) {
                      return "Invalid MPin";
                    }
                  },
                ),
                SizedBox(height: _height * 0.02),
                CustomTextField(
                    validator: (val) {
                      if (val!.length != 5) {
                        return "Invalid MPin";
                      }
                    },
                    controller: newPinController,
                    title: "New MPin",
                    hintText: "XXXXXXX"),
                SizedBox(height: _height * 0.02),
                CustomTextField(
                    validator: (val) {
                      if (val!.length != 5) {
                        return "Invalid MPin";
                      }
                    },
                    controller: reEnterPinController,
                    title: "Re-Enter MPin",
                    hintText: "XXXXXXX"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
