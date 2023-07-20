import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

import '../../utility_payment/cubit/utility_payment_cubit.dart';

class PayloadWidget extends StatelessWidget {
  PayloadWidget({Key? key}) : super(key: key);
  final TextEditingController _selectedProvinceNameController =
      TextEditingController();
  final TextEditingController _selectedDistrictController =
      TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController chitNumberController = TextEditingController();
  String? selectedDistrictValue;
  String? selectedProvinceValue;
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

        if (state is CommonStateSuccess<UtilityResponseData>) {
          UtilityResponseData _response = state.data;
          final myAmount = _response
              .findValue(
                  primaryKey: "hashResponse",
                  secondaryKey: "formattedFinalAmount")
              .toString();

          // print(
          //   "final amsdasjdoasnsda fd kasdsdis  ...${myAmount.replaceAll("NPR ", "")}",
          // );

          final serviceCharge = _response
              .findValue(primaryKey: "hashResponse", secondaryKey: "charge")
              .toString();

          if (_response.code == "M0000") {
            // NavigationService.push(
            //   target: CommonBillDetailPage(
            //     service: service,
            //     serviceIdentifier: "",
            //     apiEndpoint: "/api/governmentpayment/pay",
            //     apiBody: {
            //       "voucherCode": chitNumberController.text,
            //       "billerCode": _response
            //           .findValue(
            //               primaryKey: "hashResposne",
            //               secondaryKey: "billerCode")
            //           .toString(),
            //       "serviceCharge": serviceCharge,
            //       "fiscalYear": dateController.text,
            //     },
            //     accountDetails: {
            //       "amount": _response
            //           .findValue(
            //               primaryKey: "hashResponse", secondaryKey: "amount")
            //           .toString(),
            //       "account_number":
            //           RepositoryProvider.of<CustomerDetailRepository>(context)
            //               .selectedAccount
            //               .value!
            //               .accountNumber
            //               .toString(),

            //       //"amount": myAmount.replaceAll("NPR ", ""),
            //     },
            //     body: Column(
            //       children: [
            //         KeyValueTile(
            //             title: "Biller Code",
            //             value: _response
            //                 .findValue(
            //                   primaryKey: "hashResponse",
            //                   secondaryKey: "billerCode",
            //                 )
            //                 .toString()),
            //         // KeyValueTile(
            //         //     title: "title",
            //         //     value: _response
            //         //         .findValue(
            //         //           primaryKey: "hashResponse",
            //         //           secondaryKey: "amount",
            //         //         )
            //         //         .toString()),
            //         KeyValueTile(
            //             title: "Amount",
            //             value: _response
            //                 .findValue(
            //                   primaryKey: "hashResponse",
            //                   secondaryKey: "formattedFinalAmount",
            //                 )
            //                 .toString()),
            //         KeyValueTile(
            //             title: "Charge",
            //             value: _response
            //                 .findValue(
            //                   primaryKey: "hashResponse",
            //                   secondaryKey: "charge",
            //                 )
            //                 .toString()),
            //         KeyValueTile(
            //             title: "Remarks",
            //             value: _response
            //                 .findValue(
            //                   primaryKey: "hashResponse",
            //                   secondaryKey: "remarks",
            //                 )
            //                 .toString())
            //       ],
            //     ),
            //   ),
            // );
          } else {
            showPopUpDialog(
                context: context,
                message: _response.message,
                title: "Error",
                buttonCallback: () {
                  NavigationService.pop();
                },
                showCancelButton: false);
          }
        }
      },
      child: CommonContainer(
        showAccountSelection: true,
        buttonName: "Pay",
        showTitleText: false,
        showDetail: false,
        topbarName: "Payment",
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: dateController,
                title: "Date",
                hintText: "2079/80",
                textInputType: TextInputType.number,
                validator: (value) =>
                    FormValidator.validateFieldNotEmpty(value, "Date"),
              ),
              CustomTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                title: "Chit No.",
                textInputType: TextInputType.number,
                hintText: "XXXXXXXXX",
                controller: chitNumberController,
                validator: (value) =>
                    FormValidator.validateFieldNotEmpty(value, "Chit Number"),
              ),
            ],
          ),
        ),
        onButtonPressed: () {
          // context.read<UtilityPaymentCubit>().fetchDetails(
          //       serviceIdentifier: widget.service.uniqueIdentifier,
          //       accountDetails: {
          //         "chitNumber": "34600",//742397
          //         "fiscalYear": "2077/78",
          //         "provinceId": "000",
          //         "districtId": "002",
          //       },
          //       apiEndpoint: "api/governmentpayment/trafficFineDetail",
          //     );
          if (_formKey.currentState!.validate()) {
            context.read<UtilityPaymentCubit>().fetchDetails(
                  serviceIdentifier: "",
                  accountDetails: {
                    "chitNumber": chitNumberController.text,
                    "fiscalYear": dateController.text,
                    "provinceId": selectedProvinceValue,
                    "districtId": _selectedProvinceNameController.text
                                .toString()
                                .toLowerCase() ==
                            'Kathmandu Valley'.toLowerCase()
                        ? "000"
                        : selectedDistrictValue,
                    // "isDistrict": false,
                  },
                  apiEndpoint: "api/governmentpayment/trafficFineDetail",
                );
          }
        },
      ),
    ));
  }
}
