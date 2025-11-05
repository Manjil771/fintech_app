// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/fonts.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/common_container.dart';
// import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
// import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/resources/category_repository.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/widget/remitanceDetailFetchPage.dart';
// import 'package:ismart/feature/receiveMoney/remit/receiveRemit/widget/remittance_detail_fetch_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class RemittanceDetailsWidgets extends StatefulWidget {
  final String companyID;
  final String imagePath;
  final String bankName;

  const RemittanceDetailsWidgets(
      {super.key,
      required this.companyID,
      required this.imagePath,
      required this.bankName});

  @override
  State<RemittanceDetailsWidgets> createState() =>
      _RemittanceDetailsWidgetsState();
}

class _RemittanceDetailsWidgetsState extends State<RemittanceDetailsWidgets> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _remittancepin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UtilityPaymentCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonLoading ) { 
                showLoadingDialogBox(context);
              } else if (state is! CommonLoading ) {
                NavigationService.pop();
              }
        if (state is CommonStateSuccess<UtilityResponseData>) {
          final UtilityResponseData response = state.data;
          if (response.code == "M0000") {
            NavigationService.push(
                target: RemittanceDetailFetchPage(
              path: widget.imagePath,
              bankName: widget.bankName,
              data: response,
            ));
          }
           else {
            print("this is msg $response.message");
            showPopUpDialog(
                showCancelButton: false,
                context: context,
                message: response.message,
                title: response.status,
                buttonCallback: () {
                  NavigationService.pop();
                });
          }
        } else if (state is CommonError) {
          showPopUpDialog(
              showCancelButton: false,
              context: context,
              message: state.message,
              title: "Error",
              buttonCallback: () {
                NavigationService.pop();
              });
        }
      },
      child: PageWrapper(
          body: CommonContainer(
           showDetail: true,
           detail: "You can receive your own remittance from abroad.",
        topbarName: "Receive Remit",
        title: widget.bankName,
        // detail: "Fetch your Remittance details from here",
        buttonName: "Procced",
        onButtonPressed: () {
          onButtonPressed();
          // NavigationService.push(
          //   target: RemittanceDetailFetchWidget(
          //     path: widget.imagePath,
          //     bankName: widget.bankName,
          //     data: const {
          //       "details": {
          //         "receiverName": "NISHAN THAPA",
          //         "receiverMobileNumber": "9869191849",
          //         "receiverCity": "KATHMANDU",
          //         "receiverCountary": "NPL",
          //         "senderName": "SHYAM BDR THAPA",
          //         "senderCountary": "JPN",
          //         "pinNo": "66621470641",
          //         "payoutAmount": "2552.0000",
          //         "payoutCurrency": "NPR",
          //         "payoutType": "Cash Pay",
          //         "txnDate": "2025-05-30 14:56:48.340",
          //         "tokenId": "460341",
          //       }
          //     },
          //   ),
          // );
        },
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 56,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(),
                child: CustomCachedNetworkImage(
                    url: widget.imagePath, fit: BoxFit.contain),
              ),
                CustomTextField(
                  titleStyle:const TextStyle(
                      fontFamily: Fonts.poppin,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: CustomTheme.gray,
                    ),
                  readOnly: true,
                  enabled: false,
                title: "Receiver Name",
                customHintTextStyle: false,
                hintText: '${RepositoryProvider.of<CustomerDetailRepository>(
                                          context).customerDetailModel.value?.fullName ?? ''}',
                textInputType: TextInputType.number,
               
              ),
                CustomTextField(
                  readOnly: true,
                  enabled: false,
                    titleStyle:const TextStyle(
                      fontFamily: Fonts.poppin,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: CustomTheme.gray,
                    ),
                  customHintTextStyle: false,
                title: "Receiver Mobile Number",
                hintText: '${RepositoryProvider.of<CustomerDetailRepository>(
                                          context).customerDetailModel.value?.mobileNumber ?? ''}',
                textInputType: TextInputType.number,
               
              ),
              CustomTextField(
                title: "Remit Code",
                hintText: "Enter Remit Code",
                textInputType: TextInputType.number,
                controller: _remittancepin,
              )
            ],
          ),
        ),
      )),
    );
  }

  void onButtonPressed() {
    context.read<UtilityPaymentCubit>().fetchDetails(
          serviceIdentifier: "",
          accountDetails: {
            "transactionPin": _remittancepin.text,
            "remittanceCompanyId": widget.companyID
          },
          apiEndpoint: "api/remittance/transactionDetail",
        );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
