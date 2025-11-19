import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
// import 'package:ismart/feature/categoryWiseService/kalimati_rent_service/screens/khalimati_detail_page.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class KalimatiRentWidget extends StatefulWidget {
  final ServiceList service;
  const KalimatiRentWidget({super.key, required this.service});

  @override
  State<KalimatiRentWidget> createState() => _KalimatiRentWidgetState();
}

class _KalimatiRentWidgetState extends State<KalimatiRentWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _shopNumber = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
     
        final _customerDetailRepo =
            RepositoryProvider.of<CustomerDetailRepository>(context);
        if (
            _customerDetailRepo.accountsList.value.any((account) => account.accountType.toLowerCase() == "rentsaving")
            ){
          _customerDetailRepo.selectedAccount.value =
              _customerDetailRepo.accountsList.value.firstWhere(
                  (account) => account.accountType.toLowerCase() == "rentsaving",
                  orElse: (){         
            return _customerDetailRepo.accountsList.value.first; } );
          
        }else{
              showPopUpDialog(
              context: NavigationService.context,
              message: "You have no Rent Saving Account in cooperative to use this service. Please contact cooperative.",
              title: "Error".tr(),
              showCancelButton: false,
              buttonCallback: () {
                NavigationService.pop();
                NavigationService.pop();
              },
            );   
        }
    
    });
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
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
            if (_response.code == "M0000") {
              // NavigationService.push(
              //     target: KalimatiRentDetailPage(
              //   service: widget.service,
              //   data: state.data,
              // ));
              final payload = _response.detail?['payload'] ?? {};
              NavigationService.push(
                target: CommonBillDetailPage(
                  serviceName: "kalimati",
                  body: Column(children: [
                    KeyValueTile(
                        title: "Trader Name",
                        value: payload['traderName'] ?? '-'),
                    KeyValueTile(
                        title: "Trader ID",
                        value: payload['shopIdentification'] ?? '-'),
                    KeyValueTile(
                        title: "Invoice Due Date",
                        value: payload['invoiceDueDate'] ?? '-'),
                    KeyValueTile(
                      title: "Base Rent Amount",
                      value: payload['baseRentAmount'] ?? '-',
                    ),
                    KeyValueTile(
                      title: "Late Fee Amount",
                      value: payload['lateFeeAmount'] ?? '-',
                    ),
                    KeyValueTile(
                      title: "Other Amount",
                      value: payload['otherAmount'] ?? '-',
                    ),
                    KeyValueTile(
                      title: "Adjusted Amount",
                      value: payload['adjustedAmount'] ?? '-',
                    ),
                    KeyValueTile(
                      title: "Total Amount",
                      value: payload['totalAmount'] ?? '-',
                      bottomPadding: 0,
                    ),
                  ]),
                  accountDetails: {
                    "accountNo":
                        RepositoryProvider.of<CustomerDetailRepository>(context)
                            .selectedAccount
                            .value
                            ?.accountNumber,
                  },
                  apiBody: {
                    "referenceNumber": payload['invoiceNumber'].toString(),
                    "shopId": payload['shopIdentification'].toString(),
                    "customerMobileNumber":
                        RepositoryProvider.of<CustomerDetailRepository>(context)
                            .customerDetailModel
                            .value
                            ?.mobileNumber,
                    "amount": payload['totalAmount'] is String
                        ? double.parse(payload['totalAmount'])
                        : payload['totalAmount'] * 1.0,
                    "sessionInfo": {
                      "sessionRequestId": _response.detail?['sessionInfo']
                          ['sessionRequestId'],
                      "sessionAuthenticationSignature":
                          _response.detail?['sessionInfo']
                              ['sessionAuthenticationSignature'],
                    },
                  },
                  apiEndpoint: "/api/kmdb/pay",
                  service: widget.service,
                  serviceIdentifier: '',
                ),
              );
            } else {
              showPopUpDialog(
                context: context,
                message: _response.message,
                title: "Error",
                showCancelButton: false,
                buttonCallback: () {
                  NavigationService.pop();
                },
              );
            }
          }
        },
        child: CommonContainer(
          showRentSavingOnly: true,
          topbarName: "Rent Service".tr(),
          showAccountSelection: true,
          accountTitle: LocaleKeys.fromaccount.tr(),
          buttonName: LocaleKeys.Proceed.tr(),
          title: "Kalimati Rent Service".tr(),
          detail: "From here you can pay the rent.".tr(),
          body: Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _shopNumber,
                    title: "Enter the Trader Id",
                    hintText: "Trader Id here",
                    validator: (value) => FormValidator.validateFieldNotEmpty(
                        value, "Trader Id"),
                  ),
                ),
              ],
            ),
          ),
          onButtonPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<UtilityPaymentCubit>().makePayment(
                    mPin: '',
                    serviceIdentifier: "",
                    accountDetails: {},
                    body: {"shopNumber": "${_shopNumber.text}"},
                    apiEndpoint: "/api/kmdb/inquiry",
                  );
            }
          },
        ),
      ),
    );
  }
}
