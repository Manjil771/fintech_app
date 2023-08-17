import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_transaction_success_screen.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_avliable_list_model.dart';
import 'package:ismart/feature/categoryWiseService/airlines/widgets/flight_detail_box.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class AirlinesBillDetailPage extends StatelessWidget {
  final String serviceIdentifier;
  Availability? departureFlight;
  Availability? arrivalFlight;
  final String contactName;
  final String contactPhoneNumber;
  final String contactEmail;

  final double totalFare;

  final Map<String, dynamic> accountDetails;
  final Map<String, dynamic> apiBody;
  final String apiEndpoint;
  final ServiceList service;

  AirlinesBillDetailPage(
      {super.key,
      this.departureFlight,
      this.arrivalFlight,
      required this.accountDetails,
      required this.apiEndpoint,
      required this.apiBody,
      required this.service,
      required this.serviceIdentifier,
      required this.totalFare,
      required this.contactName,
      required this.contactPhoneNumber,
      required this.contactEmail});
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
      child: AirlinesBillDetailWidget(
        contactEmail: contactEmail,
        contactName: contactName,
        contactPhoneNumber: contactPhoneNumber,
        service: service,
        totalFare: totalFare,
        apiBody: apiBody,
        arrivalFlight: arrivalFlight,
        departureFlight: departureFlight,
        apiEndpoint: apiEndpoint,
        accountDetails: accountDetails,
        serviceIdentifier: serviceIdentifier,
      ),
    );
  }
}

class AirlinesBillDetailWidget extends StatefulWidget {
  final ServiceList service;

  final Map<String, dynamic> accountDetails;
  final Map<String, dynamic> apiBody;
  final String apiEndpoint;
  final String serviceIdentifier;
  Availability? departureFlight;
  Availability? arrivalFlight;
  final double totalFare;
  final String contactName;
  final String contactPhoneNumber;
  final String contactEmail;

  AirlinesBillDetailWidget({
    super.key,
    required this.accountDetails,
    this.departureFlight,
    this.arrivalFlight,
    required this.apiEndpoint,
    required this.apiBody,
    required this.service,
    required this.serviceIdentifier,
    required this.totalFare,
    required this.contactName,
    required this.contactPhoneNumber,
    required this.contactEmail,
  });

  @override
  State<AirlinesBillDetailWidget> createState() =>
      _AirlinesBillDetailWidgetState();
}

class _AirlinesBillDetailWidgetState extends State<AirlinesBillDetailWidget> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _height = SizeUtils.height;

    return PageWrapper(
      backgroundColor: CustomTheme.white,
      padding: EdgeInsets.zero,
      useOwnAppBar: true,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomTheme.white,
          title: Text(
            widget.service.service,
            style: _textTheme.displaySmall,
          )),
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
            if (_response.code == "M0000" ||
                _response.status.toLowerCase() == "Success" ||
                _response.message
                    .toLowerCase()
                    .contains("success".toLowerCase())) {
              NavigationService.pushReplacement(
                  target: CommonTransactionSuccessPage(
                      arrival: widget.arrivalFlight,
                      departure: widget.departureFlight,
                      pdfUrl:
                          state.data.findValue(primaryKey: "airlinesPdfUrl"),
                      transactionID: state.data.transactionIdentifier,
                      body: Container(),
                      message: state.data.message,
                      service: widget.service));
            } else {
              showPopUpDialog(
                context: context,
                message: _response.message,
                title: _response.status,
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
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Contact Detail"),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: const Color(0xFFF3F3F3),
                          ),
                          child: Column(children: [
                            KeyValueTile(
                                title: "Contact Name",
                                value: widget.contactName),
                            KeyValueTile(
                                title: "Contact Email",
                                value: widget.contactEmail),
                            KeyValueTile(
                                title: "Contact Contact",
                                value: widget.contactName)
                          ]),
                        ),
                        Text(
                          "Departure Flight Details",
                          style: _textTheme.titleSmall!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 5.hp),
                        FlightDetailBox(
                          flight: widget.departureFlight,
                        ),
                        SizedBox(height: 10.hp),
                        if (widget.arrivalFlight != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Return Flight Details",
                                style: _textTheme.titleSmall!
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 5.hp),
                              FlightDetailBox(
                                flight: widget.arrivalFlight,
                              )
                            ],
                          ),

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
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: _theme.scaffoldBackgroundColor),
              padding: EdgeInsets.all(18),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Amount",
                      style: _textTheme.headlineSmall,
                    ),
                    Text(
                      "Rs " + widget.totalFare.toString(),
                      style: _textTheme.displaySmall!
                          .copyWith(color: _theme.primaryColor),
                    ),
                  ],
                ),
                SizedBox(height: 10.hp),
                CustomRoundedButtom(
                    title: "Pay",
                    onPressed: () {
                      NavigationService.push(target: TransactionPinScreen(
                        onValueCallback: (p0) {
                          NavigationService.pop();

                          context.read<UtilityPaymentCubit>().makePayment(
                                mPin: p0,
                                serviceIdentifier: widget.serviceIdentifier,
                                apiEndpoint: widget.apiEndpoint,
                                body: widget.apiBody,
                                accountDetails: widget.accountDetails,
                              );
                        },
                      ));
                    }),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
