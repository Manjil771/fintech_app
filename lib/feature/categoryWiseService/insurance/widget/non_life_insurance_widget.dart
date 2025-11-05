import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/constant/fonts.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/constant/slugs.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/primary_account_box.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class NonLifeInsurcnceWidget extends StatefulWidget {
  final ServiceList service;

  const NonLifeInsurcnceWidget({super.key, required this.service});

  @override
  State<NonLifeInsurcnceWidget> createState() => _NonLifeInsurcnceWidgetState();
}

class _NonLifeInsurcnceWidgetState extends State<NonLifeInsurcnceWidget> {
  TextEditingController selectedDateController = TextEditingController();
  TextEditingController policyNoController = TextEditingController();
  TextEditingController documentNoController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
        body: BlocListener<UtilityPaymentCubit, CommonState>(
      listener: (context, state) {
        print(state);
        if (state is CommonLoading && _isLoading == false) {
          _isLoading = true;
          showLoadingDialogBox(context);
        } else if (state is! CommonLoading && _isLoading) {
          _isLoading = false;
          NavigationService.pop();
        }

        if (state is CommonStateSuccess<UtilityResponseData>) {
          final UtilityResponseData _response = state.data;
          if (_response.code == "M0000") {
            NavigationService.push(
              target: CommonBillDetailPage(
                serviceName: widget.service.service,
                service: widget.service,
                serviceIdentifier: widget.service.uniqueIdentifier,
                apiEndpoint: "/api/insurance/pay",
                apiBody: {
                  "proformaNo": _response.findValue(
                      primaryKey: "hashResposne", secondaryKey: "proformaNo"),
                  "policyName": _response.findValue(
                      primaryKey: "hashResposne", secondaryKey: "policyName"),
                },
                accountDetails: {
                  "account_number":
                      RepositoryProvider.of<CustomerDetailRepository>(context)
                          .selectedAccount
                          .value!
                          .accountNumber,
                  "amount": _response.findValue(
                      primaryKey: "hashResponse", secondaryKey: "totalPremium"),
                },
                body: Column(
                  children: [
                    KeyValueTile(
                      title: "Username",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "policyName",
                          )
                          .toString(),
                    ),
                    KeyValueTile(
                      title: "Total Insured Amount",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "sumInsuredAmount",
                          )
                          .toString(),
                    ),
                    KeyValueTile(
                      title: "Premium",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "totalPremium",
                          )
                          .toString(),
                    ),
                    KeyValueTile(
                      title: "Proforma No",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "proformaNo",
                          )
                          .toString(),
                    ),
                  ],
                ),
              ),
            );
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
      child: CommonContainer(
        title: "Insurance Payment",
        detail: "Pay for your Insurance premium from here.",
        showDetail: true,
        topbarName: "Insurance Payment",
        buttonName: "Show Details",
        body: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      height: _height * 0.11,
                      width: _width * 0.23,
                      margin: const EdgeInsets.only(right: 18),
                      child: Image.network(
                          "${RepositoryProvider.of<CoOperative>(context).baseUrl}/ismart/serviceIcon/${widget.service.icon}"),
                    ),
                    Expanded(
                      child: Text(widget.service.service,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                 Text(
                  LocaleKeys.fromaccount.tr(), 
                  style: TextStyle(
                    fontFamily: Fonts.poppin,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: CustomTheme.lightTextColor,
                  ),
                ),
                const PrimaryAccountBox(),
                CustomTextField(
                  title: widget.service.labelName,
                  hintText: widget.service.labelSample,
                  controller: policyNoController,
                ),
                if (widget.service.uniqueIdentifier ==
                    Slugs.prabhuInsuranceNonLife)
                  CustomTextField(
                    title: "Document No.",
                    hintText: "document no.",
                    controller: documentNoController,
                  ),
              ],
            )
          ],
        ),
        onButtonPressed: () {
          context.read<UtilityPaymentCubit>().fetchDetails(
                serviceIdentifier: widget.service.uniqueIdentifier,
                accountDetails: {
                  // "username": "108006674",
                  "username": policyNoController.text,
                  "documentNo": documentNoController.text
                  // "dob": "1983-07-24",
                },
                apiEndpoint: "api/insurance/policy",
              );
        },
      ),
    ));
  }
}
