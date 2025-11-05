import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class TootleDetailWidget extends StatefulWidget {
  final ServiceList service;
  final String type;

  const TootleDetailWidget(
      {super.key, required this.service, required this.type});

  @override
  State<TootleDetailWidget> createState() => _TootleDetailWidgetState();
}

class _TootleDetailWidgetState extends State<TootleDetailWidget> {
  final TextEditingController _amountController = TextEditingController();
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
            title: "Error",
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
              context.read<UtilityPaymentCubit>().makePayment(
                    body: {
                      "product_identity": "",
                      "mobile_number": "",
                    },
                    mPin: "",
                    serviceIdentifier: widget.service.uniqueIdentifier,
                    accountDetails: {
                      "service_identifier": widget.service.uniqueIdentifier,
                      "amount": _amountController.text,
                      "account_number":
                          RepositoryProvider.of<CustomerDetailRepository>(
                                  context)
                              .selectedAccount
                              .value!
                              .accountNumber,
                    },
                    apiEndpoint: "/api/tootle/pay",
                  );
          },
          buttonName: "Pay",
          topbarName: widget.service.service,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const KeyValueTile(title: "Name", value: ""),
              const KeyValueTile(title: "Phone Number", value: ""),
              CustomTextField(
                title: "Amount",
                hintText: "Amount",
                controller: _amountController,
                validator: (value) => FormValidator.validateAmount(
                    val: value.toString(),
                    minAmount: widget.service.minValue,
                    maxAmount: widget.service.maxValue),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
