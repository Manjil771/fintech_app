import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/categoryWiseService/governmentPayment/ui/screen/gov_place_page.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/receiveMoney/models/bank.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class TvPaymentWidget extends StatefulWidget {
  final Service service;

  const TvPaymentWidget({Key? key, required this.service}) : super(key: key);

  @override
  State<TvPaymentWidget> createState() => _TvPaymentWidgetState();
}

class _TvPaymentWidgetState extends State<TvPaymentWidget> {
  final TextEditingController _selectedProvinceNameController =
      TextEditingController();
  final TextEditingController _selectedDistrictController =
      TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  String? selectedDistrictValue;
  String? selectedProvinceValue;
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
                  NavigationService.push(target: TransactionPinScreen(
                    onValueCallback: (p0) {
                      NavigationService.pop();

                      context.read<UtilityPaymentCubit>().payTrafficFine(
                          serviceIdentifier: widget.service.uniqueIdentifier,
                          // serviceIdentifier: "traffic_fine_payments",
                          apiEndpoint: "/api/governmentpayment/pay",
                          body: {
                            "voucherCode": usernameController.text,
                            // "voucherCode": "34600",
                            "billerCode": _response
                                .findValue(
                                    primaryKey: "hashResposne",
                                    secondaryKey: "billerCode")
                                .toString(),
                            // "serviceCharge": serviceCharge,
                            // "serviceCharge": _response
                            //     .findValue(
                            //         primaryKey: "hashResposne",
                            //         secondaryKey: "charge")
                            //     .toString(),
                            "fiscalYear": dateController.text
                          },
                          accountDetails: {
                            "account_number":
                                RepositoryProvider.of<CustomerDetailRepository>(
                                        context)
                                    .selectedAccount
                                    .value!
                                    .accountNumber
                                    .toString(),
                            // "account_number": "002001-001-102-0001010",

                            // "amount": myAmount,
                            // "amount": _response.findValue(
                            //     primaryKey: "hashResposne",
                            //     secondaryKey: "formattedFinalAmount"),
                            "mPin": p0
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
                        title: "Customer ID",
                        value: _response
                            .findValue(
                              primaryKey: "hashResponse",
                              secondaryKey: "customerId",
                            )
                            .toString()),
                    KeyValueTile(
                        title: "Customer Name",
                        value: _response
                            .findValue(
                              primaryKey: "hashResponse",
                              secondaryKey: "customerName",
                            )
                            .toString()),
                    KeyValueTile(
                        title: "Number of TV",
                        value: _response
                            .findValue(
                              primaryKey: "hashResponse",
                              secondaryKey: "noOfTv",
                            )
                            .toString())
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
        }
      },
      child: CommonContainer(
        showAccountSelection: true,
        buttonName: "Show Bill",
        title: widget.service.service,
        detail: widget.service.instructions,
        showDetail: true,
        topbarName: "Payment",
        body: Column(
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
            SizedBox(height: _height * 0.02),
            CustomTextField(
              title: "Username",
              hintText: "XXXXXXXXX",
              controller: usernameController,
            ),
          ],
        ),
        onButtonPressed: () {
          context.read<UtilityPaymentCubit>().fetchDetails(
              serviceIdentifier: widget.service.uniqueIdentifier,
              accountDetails: {
                "username": usernameController.text,
              },
              apiEndpoint: "api/tvpackages");
        },
      ),
    ));
  }
}
