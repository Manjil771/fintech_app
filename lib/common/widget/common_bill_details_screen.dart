import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_transaction_success_screen.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class CommonBillDetailPage extends StatelessWidget {
  final String serviceIdentifier;
  final Map<String, dynamic> accountDetails;
  final Map<String, dynamic> apiBody;
  final String apiEndpoint;
  final Widget body;
  final ServiceList service;

  CommonBillDetailPage(
      {super.key,
      required this.body,
      required this.accountDetails,
      required this.apiEndpoint,
      required this.apiBody,
      required this.service,
      required this.serviceIdentifier});
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;

    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
        utilityPaymentRepository:
            RepositoryProvider.of<UtilityPaymentRepository>(context),
      ),
      child: CommonBillDetailWidget(
        body: body,
        service: service,
        apiBody: apiBody,
        apiEndpoint: apiEndpoint,
        accountDetails: accountDetails,
        serviceIdentifier: serviceIdentifier,
      ),
    );
  }
}

class CommonBillDetailWidget extends StatelessWidget {
  final Map<String, dynamic> accountDetails;
  final Map<String, dynamic> apiBody;
  final String apiEndpoint;
  final ServiceList service;
  final Widget body;
  final String serviceIdentifier;

  CommonBillDetailWidget({
    super.key,
    required this.accountDetails,
    required this.apiEndpoint,
    required this.body,
    required this.apiBody,
    required this.service,
    required this.serviceIdentifier,
  });
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;

    return PageWrapper(
      body: BlocListener<UtilityPaymentCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoading && _isLoading == false) {
            _isLoading = true;
            showLoadingDialogBox(context);
          }
          if (state is! CommonLoading && _isLoading) {
            NavigationService.pop();
            _isLoading = false;
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
            UtilityResponseData _response = state.data;
            if (_response.status == "M0000") {
              NavigationService.pushReplacement(
                  target: CommonTransactionSuccessPage(
                      transactionID: state.data.transactionIdentifier,
                      body: body,
                      message: state.data.message,
                      service: service));
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
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: CustomTheme.white,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        NavigationService.pop();
                      },
                      icon: Icon(Icons.arrow_back)),
                  Center(
                    child: Image.network(
                      "${RepositoryProvider.of<CoOperative>(context).baseUrl}/ismart/serviceIcon/${service.icon}",
                      height: _height * 0.08,
                    ),
                  ),
                  SizedBox(height: _height * 0.02),
                  service.service.isEmpty
                      ? Container()
                      : Text(
                          service.service,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                  SizedBox(height: _height * 0.02),
                  Text(
                      "Details about the payable amount for the service of ${service.service} is shown below.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(height: _height * 0.02),
                  const Divider(thickness: 1),
                  SizedBox(height: _height * 0.02),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFF3F3F3),
                      // border: Border.all(color: Colors.black),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Paymet Details",
                            style: Theme.of(context).textTheme.titleLarge),
                        SizedBox(height: _height * 0.02),
                        body,
                        KeyValueTile(
                            title: "Cashback",
                            value: "${service.cashBackView ?? 0} %")
                      ],
                    ),
                  ),
                  SizedBox(height: _height * 0.02),
                  CustomRoundedButtom(
                      title: "Pay",
                      onPressed: () {
                        NavigationService.push(target: TransactionPinScreen(
                          onValueCallback: (p0) {
                            NavigationService.pop();

                            context.read<UtilityPaymentCubit>().makePayment(
                                  mPin: p0,
                                  serviceIdentifier: serviceIdentifier,
                                  // serviceIdentifier: "traffic_fine_payments",
                                  apiEndpoint: apiEndpoint,
                                  body: apiBody,
                                  accountDetails: accountDetails,
                                );
                          },
                        ));
                      }),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(18),
                  //       border:
                  //           Border.all(color: Theme.of(context).primaryColor)),
                  //   child: CustomRoundedButtom(
                  //       textColor: Theme.of(context).primaryColor,
                  //       title: "Download Receipt",
                  //       color: Colors.transparent,
                  //       onPressed: () {}),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
