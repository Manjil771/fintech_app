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
import 'package:ismart/feature/categoryWiseService/governmentPayment/ui/screen/gov_place_page.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/receiveMoney/models/bank.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class TrafficFinePaymentWidget extends StatefulWidget {
  final Service service;

  const TrafficFinePaymentWidget({Key? key, required this.service})
      : super(key: key);

  @override
  State<TrafficFinePaymentWidget> createState() =>
      _TrafficFinePaymentWidgetState();
}

class _TrafficFinePaymentWidgetState extends State<TrafficFinePaymentWidget> {
  final TextEditingController _selectedProvinceNameController =
      TextEditingController();
  final TextEditingController _selectedDistrictController =
      TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController chitNumberController = TextEditingController();
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
                  print("press");
                  context.read<UtilityPaymentCubit>().payTrafficFine(
                      serviceIdentifier: "traffic_fine_payments",
                      apiEndpoint: "/api/governmentpayment/pay",
                      body: {
                        "voucherCode": "34600",
                        "billerCode": "GON-7-TVRS-1",
                        "serviceCharge": "10",
                        "fiscalYear": "2077/78"
                      },
                      accountDetails: {
                        "account_number": "002001-001-102-0001010",
                        "amount": "500",
                        "mPin": "70074"
                      });
                },
                serviceType: widget.service.service,
                image:
                    "${RepositoryProvider.of<CoOperative>(context).baseUrl}/ismart/serviceIcon/${widget.service.icon}",
                body: Column(
                  children: [
                    KeyValueTile(
                        title: "Biller Code",
                        value: _response
                            .findValue(
                              primaryKey: "hashResponse",
                              secondaryKey: "billerCode",
                            )
                            .toString()),
                    // KeyValueTile(
                    //     title: "title",
                    //     value: _response
                    //         .findValue(
                    //           primaryKey: "hashResponse",
                    //           secondaryKey: "amount",
                    //         )
                    //         .toString()),
                    KeyValueTile(
                        title: "Amount",
                        value: _response
                            .findValue(
                              primaryKey: "hashResponse",
                              secondaryKey: "amount",
                            )
                            .toString()),
                    KeyValueTile(
                        title: "Charge",
                        value: _response
                            .findValue(
                              primaryKey: "hashResponse",
                              secondaryKey: "charge",
                            )
                            .toString()),
                    KeyValueTile(
                        title: "Remarks",
                        value: _response
                            .findValue(
                              primaryKey: "hashResponse",
                              secondaryKey: "remarks",
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
            CustomTextField(
              hintText: "Select",
              title: "Select Province",
              readOnly: true,
              controller: _selectedProvinceNameController,
              onTap: () {
                NavigationService.push(
                  target: GovPlacePage(
                    isProvince: true,
                    accountDetails: {},
                    apiEndpoint: "/api/governmentpayment/getProvance",
                    serviceIdentifier: "",
                    onBankSelected: ({required value, required name}) {
                      NavigationService.pop();
                      _selectedProvinceNameController.text = name;
                      selectedProvinceValue = value;

                      setState(() {});
                    },
                  ),
                );
              },
              validator: (value) {},
            ),
            CustomTextField(
              hintText: "Select",
              title: "Select District",
              readOnly: true,
              controller: _selectedDistrictController,
              onTap: () {
                NavigationService.push(
                  target: GovPlacePage(
                    isProvince: false,
                    accountDetails: {
                      "provinceId": selectedProvinceValue,
                    },
                    apiEndpoint: "/api/governmentpayment/getDistrict",
                    serviceIdentifier: widget.service.uniqueIdentifier,
                    onBankSelected: ({required value, required name}) {
                      NavigationService.pop();
                      _selectedDistrictController.text = name;
                      selectedDistrictValue = value;
                      setState(() {});
                    },
                  ),
                );
              },
              validator: (value) {
                // if (selectedBank != null) {
                //   return null;
                // } else {
                //   return "Please select destination bank.";
                // }
              },
            ),
            CustomTextField(
              controller: dateController,
              title: "Date",
              hintText: "Select Date",
            ),
            CustomTextField(
              title: "Chit No.",
              hintText: "XXXXXXXXX",
              controller: chitNumberController,
            ),
          ],
        ),
        onButtonPressed: () {
          context.read<UtilityPaymentCubit>().fetchDetails(
                serviceIdentifier: widget.service.uniqueIdentifier,
                accountDetails: {
                  "chitNumber": "34600",
                  "fiscalYear": "2077/78",
                  "provinceId": "000",
                  "districtId": "002",
                },
                apiEndpoint: "api/governmentpayment/trafficFineDetail",
              );
          // context.read<UtilityPaymentCubit>().fetchDetails(
          //               serviceIdentifier: widget.service.uniqueIdentifier,
          //               accountDetails: {
          //                 "chitNumber": chitNumberController.text,
          //                 "fiscalYear": dateController.text,
          //                 "provinceId": selectedProvinceValue,
          //                 "districtId": selectedDistrictValue,
          //               },
          //               apiEndpoint: "api/governmentpayment/trafficFineDetail",
          //             );
        },
      ),
    ));
  }
}
