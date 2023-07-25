import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/enum/counters_fetch_enum.dart';
import 'package:ismart/common/models/key_value.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
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

  final TextEditingController _selectedCounterController =
      TextEditingController();
  bool _isLoading = false;
  final TextEditingController _scNumberController = TextEditingController();
  final TextEditingController _customerIDController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: CommonContainer(
        showDetail: true,
        title: "NEA Payment",
        detail: "Pay for your electricity bill from here.",
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
                  title: "Error",
                  showCancelButton: false,
                  buttonCallback: () {
                    NavigationService.pop();
                  },
                );
              }
              // NavigationService.push(
              //   target: CommonBillDetailPage(
              //     body: Column(
              //       children: [
              //         KeyValueTile(
              //             title: "Customer Name",
              //             value: _response.findValue(
              //                 primaryKey: "hashResponse",
              //                 secondaryKey: "Customer Name")),
              //         KeyValueTile(
              //             title: "Session ID",
              //             value: _response.findValue(
              //                 primaryKey: "hashResponse",
              //                 secondaryKey: "sessionId")),
              //         // KeyValueTile(
              //         //     title: "Date",
              //         //     value: _response.findValue(
              //         //         primaryKey: "payment"[0],
              //         //         secondaryKey: "_description")),
              //         KeyValueTile(
              //             title: "Billable Amount",
              //             value: _response.findValue(
              //                 primaryKey: "hashResponse",
              //                 secondaryKey: "Billable Amount")),
              //         KeyValueTile(
              //             title: "Amount",
              //             value: _response.findValue(
              //                 primaryKey: "payment"[0],
              //                 secondaryKey: "_amount")),
              //       ],
              //     ),
              //     accountDetails: {},
              //     apiEndpoint: "",
              //     apiBody: {},
              //     service: widget.service,
              //     serviceIdentifier: "",
              //   ),
              // );
            }
          },
          child: Column(
            children: [
              CustomTextField(
                title: "Select Counter ",
                hintText: "Select From List",
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
              ),
              CustomTextField(
                title: "SC No.",
                hintText: "Enter SC Number", //Need to add dropdown button
                controller: _scNumberController,
              ),
              CustomTextField(
                title: "Customer Id",
                hintText: "ID", //Need to add dropdown button
                controller: _customerIDController,
              ),
            ],
          ),
        ),
        buttonName: "Procced",
        onButtonPressed: () {
          context.read<UtilityPaymentCubit>().fetchDetails(
                serviceIdentifier: "nea_online_topup",
                accountDetails: {
                  "scno": _scNumberController.text,
                  "office_code": selectedCounter?.value ?? "",
                  "customerId": _customerIDController.text,
                },
                apiEndpoint: "/api/getneabill",
              );
        },
        topbarName: "Payment",
      ),
    );
  }
}
