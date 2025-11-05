import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class TootlePaymentWidget extends StatefulWidget {
  final ServiceList service;

  const TootlePaymentWidget({super.key, required this.service});

  @override
  State<TootlePaymentWidget> createState() => _TootlePaymentWidgetState();
}

class _TootlePaymentWidgetState extends State<TootlePaymentWidget> {
  bool isPartner = true;
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
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
            title: "Error".tr(),
            showCancelButton: false,
            buttonCallback: () {
              NavigationService.pop();
            },
          );
        }
        if (state is CommonStateSuccess<UtilityResponseData>) {
          final UtilityResponseData res = state.data;
          if (res.code == "M0000") {
            NavigationService.push(target: const DashboardPage());
          } else {
            showPopUpDialog(
              context: context,
              message: res.message,
              title: res.status,
              showCancelButton: false,
              buttonCallback: () {
                NavigationService.pop();
              },
            );
          }
        }
      },
      child: Form(
        key: _formKey,
        child: CommonContainer(
          onButtonPressed: () {
            if (_formKey.currentState!.validate())
              context.read<UtilityPaymentCubit>().fetchDetails(
                    serviceIdentifier: widget.service.uniqueIdentifier,
                    accountDetails: {
                      "mobile_number": _phoneNumberController.text,
                      "type": isPartner == true ? "partner" : "client"
                    },
                    apiEndpoint: "/api/tootle/detail",
                  );
          },
          buttonName: LocaleKeys.Proceed.tr(),
          title: "Ride Payment".tr(),
          topbarName: widget.service.service,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                title: "Phone Number",
                hintText: "Phone Numeber",
                controller: _phoneNumberController,
                validator: (value) =>
                    FormValidator.validateFieldNotEmpty(value, "Phone Number"),
              ),
              Text(
                "Type",
                style:
                    _textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.shade300),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomRoundedButtom(
                      color: isPartner == true
                          ? _theme.primaryColor
                          : Colors.transparent,
                      borderColor: isPartner == true
                          ? _theme.primaryColor
                          : Colors.transparent,
                      textColor: isPartner == true
                          ? CustomTheme.white
                          : CustomTheme.darkerBlack,
                      onPressed: () {
                        setState(() {
                          isPartner = true;
                        });
                      },
                      title: "Partner",
                    )),
                    Expanded(
                      child: CustomRoundedButtom(
                        borderColor: isPartner == false
                            ? _theme.primaryColor
                            : Colors.transparent,
                        textColor: isPartner == false
                            ? CustomTheme.white
                            : CustomTheme.darkerBlack,
                        color: isPartner == false
                            ? _theme.primaryColor
                            : Colors.transparent,
                        onPressed: () {
                          setState(() {
                            isPartner = false;
                          });
                        },
                        title: "Customer",
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
