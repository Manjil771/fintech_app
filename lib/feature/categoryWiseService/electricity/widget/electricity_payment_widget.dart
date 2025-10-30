import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/enum/counters_fetch_enum.dart';
import 'package:ismart/common/models/key_value.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/categoryWiseService/electricity/screen/electricity_detail_page.dart';
import 'package:ismart/feature/categoryWiseService/electricity/screen/electricity_search_page.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class ElectricityPaymentWidget extends StatefulWidget {
  final ServiceList service;
  const ElectricityPaymentWidget({Key? key, required this.service})
      : super(key: key);

  @override
  State<ElectricityPaymentWidget> createState() =>
      _ElectricityPaymentWidgetState();
}

class _ElectricityPaymentWidgetState extends State<ElectricityPaymentWidget> {
  KeyValue? selectedCounter;
  String recentTransactionOfficeCode = "";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _selectedCounterController =
      TextEditingController();
  bool _isLoading = false;
  final TextEditingController _scNumberController = TextEditingController();
  final TextEditingController _customerIDController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: CommonContainer(
        onRecentTransactionPressed: (p0) {
          // NavigationService.pop();
          _selectedCounterController.text =
              p0.requestDetail.officeCode.toString();
          recentTransactionOfficeCode = p0.requestDetail.officeCode.toString();
          _customerIDController.text = p0.requestDetail.customerId.toString();
          _scNumberController.text = p0.requestDetail.scno.toString();
          setState(() {});
        },
        showRecentTransaction: true,
        associatedId: widget.service.id.toString(),
        showAccountSelection: true,
        showDetail: true,
        title: widget.service.service,
        detail: widget.service.instructions,
        body: BlocListener<UtilityPaymentCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoading && _isLoading == false) {
              _isLoading = true;
              showLoadingDialogBox(context);
            } else if (state is! CommonLoading && _isLoading) {
              _isLoading = false;
              NavigationService.pop();
            } else if (state is CommonError) {
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
              if (_response.status == "M0000") {
                NavigationService.push(
                    target: ElectricityDetailPage(
                  useServiceResponse: _response,
                  counterCode: selectedCounter?.value ?? "",
                  counterName: selectedCounter?.title ?? "",
                  customerId: _customerIDController.text,
                  scNumber: _scNumberController.text,
                  services: widget.service,
                ));
              } else {
                showPopUpDialog(
                  context: context,
                  message: _response.message,
                  title: "Error".tr(),
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
            child: Column(
              children: [
                CustomTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  title: "Select Counter".tr(),
                  hintText: "Select From List".tr(),
                  readOnly: true,
                  suffixIcon: Icons.arrow_downward,
                  showSearchIcon: true,
                  controller: _selectedCounterController,
                  onTap: () {
                    NavigationService.push(
                        target: CounterSearchPage(
                      counterType: CountersEnums.NEA,
                      onChanged: (val) {
                        selectedCounter = val;
                        _selectedCounterController.text =
                            selectedCounter?.title ?? "";
                      },
                    ));
                  },
                  validator: (value) {
                    if (_selectedCounterController.text.isEmpty) {
                      return "Please Select Counter".tr();
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                  title: widget.service.labelName,
                  hintText:
                      widget.service.labelSample, //Need to add dropdown button
                  controller: _scNumberController,
                  validator: (value) =>
                      FormValidator.validateFieldNotEmpty(value, "SC No."),
                ),
                CustomTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                  title: "Customer Id",
                  hintText: "ID", //Need to add dropdown button
                  controller: _customerIDController,
                  validator: (value) =>
                      FormValidator.validateFieldNotEmpty(value, "Customer ID"),
                ),
              ],
            ),
          ),
        ),
        buttonName: "Procced".tr(),
        onButtonPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<UtilityPaymentCubit>().fetchDetails(
                  serviceIdentifier: "nea_online_topup",
                  accountDetails: {
                    "scno": _scNumberController.text,
                    "office_code":
                        selectedCounter?.value ?? recentTransactionOfficeCode,
                    "customerId": _customerIDController.text,
                  },
                  apiEndpoint: "/api/getneabill",
                );
          }
        },
        topbarName: "Electricity".tr(),
      ),
    );
  }
}
