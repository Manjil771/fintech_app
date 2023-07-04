import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/constant/fonts.dart';
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
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class LifeInsurcnceWidget extends StatefulWidget {
  final String companyName;
  final String companyLogo;
  final Service service;

  LifeInsurcnceWidget(
      {super.key,
      required this.companyName,
      required this.companyLogo,
      required this.service});

  @override
  State<LifeInsurcnceWidget> createState() => _LifeInsurcnceWidgetState();
}

class _LifeInsurcnceWidgetState extends State<LifeInsurcnceWidget> {
  TextEditingController selectedDateController = TextEditingController();
  TextEditingController policyNoController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
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
          UtilityResponseData _response = state.data;
          if (_response.code == "M0000") {
            NavigationService.push(
              target: CommonBillDetailPage(
                onButtonPress: () {
                  final myAmount = _response.findValue(
                      primaryKey: "hashResponse", secondaryKey: "amount");
                  NavigationService.push(target: TransactionPinScreen(
                    onValueCallback: (p0) {
                      NavigationService.pop();

                      context.read<UtilityPaymentCubit>().makePayment(
                          serviceIdentifier: widget.service.uniqueIdentifier,
                          apiEndpoint: "/api/insurance/pay",
                          body: {
                            // "policyNo": "108006674",

                            "policyNo": _response.findValue(
                                primaryKey: "hashResposne",
                                secondaryKey: "policyNo"),
                            // "policyName": "DEEPAK SHRESTHA"

                            "policyName": _response.findValue(
                                primaryKey: "hashResposne",
                                secondaryKey: "policyName"),
                          },
                          accountDetails: {
                            "account_number":
                                RepositoryProvider.of<CustomerDetailRepository>(
                                        context)
                                    .selectedAccount
                                    .value!
                                    .accountNumber,
                            // "account_number": "002001-001-102-0001010",

                            "amount": myAmount,

                            // "amount": _response.findValue(
                            //     primaryKey: "hashResposne",
                            //     secondaryKey: "amount"),
                            "mPin": p0,
                            "dob": selectedDateController.text
                          });
                    },
                  ));
                },
                serviceType: widget.service.service,
                image:
                    "${RepositoryProvider.of<CoOperative>(context).baseUrl}/ismart/serviceIcon/${widget.service.icon}",
                body: Column(
                  children: [
                    KeyValueTile(
                      title: "Policy Number",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "policyNo",
                          )
                          .toString(),
                    ),
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
                      title: "Amount",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "amount",
                          )
                          .toString(),
                    ),
                    KeyValueTile(
                      title: "Premium",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "premium",
                          )
                          .toString(),
                    ),
                    KeyValueTile(
                      title: "Due Date",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "dueDate",
                          )
                          .toString(),
                    ),
                    KeyValueTile(
                      title: "Penalty",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "interestOccured",
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
        title: "Insurance Paymenent",
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
                          "${RepositoryProvider.of<CoOperative>(context).baseUrl}/ismart/serviceIcon/${widget.companyLogo}"),
                    ),
                    Expanded(
                      child: Text(widget.companyName,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                Text(
                  "From Account",
                  style: const TextStyle(
                    fontFamily: Fonts.poppin,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: CustomTheme.lightTextColor,
                  ),
                ),
                PrimaryAccountBox(),
                CustomTextField(
                  title: "Policy No",
                  hintText: "Policy NO",
                  controller: policyNoController,
                ),
                SizedBox(height: _height * 0.01),
                CustomTextField(
                  onTap: () async {
                    final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1905),
                        lastDate: DateTime.now());
                    setState(
                      () {
                        selectedDateController.text =
                            "${date!.year}-${date.month}-${date.day}";
                      },
                    );
                  },
                  title: "Date of Birth",
                  hintText: "yyyy-mm-dd",
                  readOnly: true,
                  controller: selectedDateController,
                  trailing: SvgPicture.asset(
                    Assets.calanderIcon,
                    height: _height * 0.05,
                  ),
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
                  "dob": selectedDateController.text,
                  // "dob": "1983-07-24",
                },
                apiEndpoint: "api/insurance/policy",
              );
        },
      ),
    ));
  }
}
