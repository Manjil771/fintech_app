import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/constant/slugs.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class RidePaymentWidget extends StatefulWidget {
  final ServiceList service;
  const RidePaymentWidget({Key? key, required this.service}) : super(key: key);

  @override
  State<RidePaymentWidget> createState() => _RidePaymentWidgetState();
}

class _RidePaymentWidgetState extends State<RidePaymentWidget> {
  final TextEditingController amountController = TextEditingController();

  final TextEditingController riderIDController = TextEditingController();

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  String _currentAmount = '';

  @override
  Widget build(BuildContext context) {
    final TextEditingController remarksController =
        TextEditingController(text: "${widget.service.service} ride payment");
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
            final UtilityResponseData _response = state.data;
            if (_response.details.toString() == "M0000" ||
                _response.status.toLowerCase() == "success") {
              if (_response
                      .findValue(primaryKey: "status")
                      .toString()
                      .toLowerCase() ==
                  "success") {
                NavigationService.push(
                    target: CommonBillDetailPage(
                        serviceName: widget.service.service,
                        body: Column(
                          children: [
                            KeyValueTile(
                                title: "Rider Id".tr(),
                                value: riderIDController.text),
                            KeyValueTile(
                                title: "Amount".tr(),
                                value: amountController.text),
                            KeyValueTile(
                                title: "Remarks".tr(),
                                value: remarksController.text),
                          ],
                        ),
                        accountDetails: const {},
                        apiEndpoint:
                            widget.service.uniqueIdentifier.toLowerCase() ==
                                    Slugs.pathaoTopup
                                ? "/api/pathao/payment"
                                : "/api/indrive/payment",
                        apiBody: {
                          "accountNo":
                              RepositoryProvider.of<CustomerDetailRepository>(
                                      context)
                                  .selectedAccount
                                  .value!
                                  .accountNumber,
                          "amount": amountController.text,
                          "mobileNo": riderIDController.text,
                          "remarks": remarksController.text,
                        },
                        service: widget.service,
                        serviceIdentifier: widget.service.uniqueIdentifier));
              } else {
                showPopUpDialog(
                    context: context,
                    message:
                        _response.findValue(primaryKey: "message").toString() ==
                                "null"
                            ? "Something went wrong.Please try again later."
                            : _response.findValue(primaryKey: "message"),
                    title: _response.findValueString("status"),
                    buttonCallback: () {
                      NavigationService.pop();
                    },
                    showCancelButton: false);
              }
            } else {
              showPopUpDialog(
                  context: context,
                  message: _response.message,
                  title: _response.status,
                  buttonCallback: () {
                    NavigationService.pop();
                  },
                  showCancelButton: false);
            }
          }
        },
        child: CommonContainer(
            showRecentTransaction: true,
            onButtonPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<UtilityPaymentCubit>().fetchDetails(
                      serviceIdentifier: widget.service.uniqueIdentifier,
                      accountDetails: {
                        "mobileNo": riderIDController.text,
                        "amount": amountController.text,
                      },
                      apiEndpoint:
                          widget.service.uniqueIdentifier.toLowerCase() ==
                                  Slugs.pathaoTopup
                              ? "/api/pathao/validate"
                              : "/api/indrive/validate",
                    );
              }
            },
            verificationAmount: _currentAmount,
            detail: widget.service.instructions,
            title: widget.service.service,
            showAccountSelection: true,
            buttonName: LocaleKeys.Proceed.tr(),
            body: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    title: "Rider Id".tr(),
                    hintText: widget.service.labelSample,
                    controller: riderIDController,
                    validator: (value) =>
                        FormValidator.validateFieldNotEmpty(value, "Rider ID"),
                  ),
                  CustomTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: amountController,
                    title: "Amount".tr(),
                    hintText: "XXXXX",
                    onChanged: (value) {
                      setState(() {
                        _currentAmount = value;
                      });
                    },
                    validator: (value) => FormValidator.validateAmount(
                        val: value.toString(),
                        minAmount: widget.service.minValue,
                        maxAmount: widget.service.maxValue),
                  ),
                  CustomTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    title: "Remarks".tr(),
                    controller: remarksController,
                    hintText: "remarks",
                    validator: (value) =>
                        FormValidator.validateFieldNotEmpty(value, "Remarks"),
                  ),
                ],
              ),
            ),
            topbarName: "Ride Payment".tr()),
      ),
    );
  }
}
