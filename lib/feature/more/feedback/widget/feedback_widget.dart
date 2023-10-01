import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/fonts.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/dashboard/widgets/dashboard_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class FeedBackWidget extends StatelessWidget {
  final String? transactionIdentifier;
  FeedBackWidget({Key? key, this.transactionIdentifier}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final dateNow = DateTime.now();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
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
            showPopUpDialog(
              context: context,
              message: state.data.message,
              title: state.data.status.toString(),
              showCancelButton: false,
              buttonCallback: () {
                NavigationService.pushReplacement(target: DashboardPage());
              },
            );

            _formKey.currentState!.reset();
          }
        },
        child: CommonContainer(
            title: "Report a Problem",
            buttonName: "Submit",
            onButtonPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<UtilityPaymentCubit>().makePayment(
                    serviceIdentifier: "",
                    accountDetails: {
                      "email": emailController.text,
                      "message": messageController.text
                    },
                    body: {},
                    apiEndpoint: "/api/addSuggestionBox",
                    mPin: "");
              }
            },
            body: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: messageController,
                    title: "Date",
                    customHintTextStyle: true,
                    hintText: dateNow.toString(),
                  ),
                  if (transactionIdentifier != null)
                    CustomTextField(
                      title: "Transaction Identifier",
                      hintText: transactionIdentifier.toString(),
                      customHintTextStyle: true,
                    ),
                  CustomTextField(
                    maxLine: 3,

                    hintText: "Message",
                    title: "Message",
                    textInputType: TextInputType.multiline,
                    // maxLine: 5,
                    validator: (value) =>
                        FormValidator.validateFieldNotEmpty(value, "Message"),
                  ),
                  Text(
                    "Picture",
                    style: const TextStyle(
                      fontFamily: Fonts.poppin,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: CustomTheme.lightTextColor,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      width: _width,
                      decoration: BoxDecoration(
                          color: _theme.primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(18)),
                      height: _height * 0.2,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Assets.uploadImageIcon,
                              height: 50.hp,
                            ),
                            SizedBox(height: 10.hp),
                            Text(
                              "Upload Picture",
                              style: _textTheme.titleSmall,
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            topbarName: "Report"),
      ),
    );
  }
}
