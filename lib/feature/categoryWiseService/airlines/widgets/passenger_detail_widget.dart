import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/common_transaction_success_screen.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_avliable_list_model.dart';
import 'package:ismart/feature/categoryWiseService/airlines/resources/passenger_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class PassengerDetailWidget extends StatefulWidget {
  Availability? departureFlight;
  Availability? arrivalFlight;

  final double totalFare;
  final ServiceList service;

  PassengerDetailWidget(
      {Key? key,
      required this.arrivalFlight,
      required this.adultCount,
      required this.childrenCount,
      required this.departureFlight,
      required this.service,
      required this.totalFare})
      : super(key: key);

  final int adultCount;
  final int childrenCount;

  @override
  State<PassengerDetailWidget> createState() => _PassengerDetailWidgetState();
}

class _PassengerDetailWidgetState extends State<PassengerDetailWidget> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final contactName = TextEditingController();

  final contactEmail = TextEditingController();

  final contactNumber = TextEditingController();

  List<PassengerDetailModel> passengers = [];

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.adultCount; i++) {
      passengers.add(PassengerDetailModel(
          firstname: "",
          lastname: "",
          gender: "",
          title: "",
          type: PassengerType.adult));
    }
    for (int i = 0; i < widget.childrenCount; i++) {
      passengers.add(PassengerDetailModel(
          gender: "",
          title: "",
          firstname: "",
          lastname: "",
          type: PassengerType.child));
    }
    // for (int i = 0; i < widget.numberOfInfants; i++) {
    //   passengers
    //       .add(Passenger(name: '', phone: '', type: PassengerType.infant));
    // }
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
        body: CommonContainer(
      showDetail: true,
      topbarName: 'Payment',
      title: 'Passenger Details',
      detail: 'Provide the details of the person traveling on the plane',
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
              NavigationService.push(
                  target: CommonTransactionSuccessPage(
                      body: Container(),
                      message: _response.message,
                      transactionID: _response.transactionIdentifier));
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    color: CustomTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(18)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: CustomTheme.gray,
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.departureFlight?.airline ?? "",
                                style: _textTheme.displaySmall!
                                    .copyWith(fontSize: 14),
                              ),
                              Text(
                                (widget.departureFlight?.departureTime ?? "") +
                                    "-" +
                                    (widget.departureFlight?.arrivalTime ?? ""),
                                style: _textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        Column(
                          children: [
                            Text(
                              'Ticket Price',
                              style: _textTheme.titleLarge,
                            ),
                            Text(
                              widget.totalFare.toString(),
                              style: _textTheme.displaySmall!
                                  .copyWith(fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KeyValueTile(
                          title: 'Departure',
                          value:
                              "${widget.departureFlight?.flightDate.year}-${widget.departureFlight?.flightDate.month}-${widget.departureFlight?.flightDate.day}",
                        ),
                        KeyValueTile(
                            title: "Routes",
                            value: (widget.departureFlight?.departure ?? "") +
                                " - " +
                                (widget.departureFlight?.arrival ?? ""))
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              Text(
                'Contact Person Details',
                style: _textTheme.displaySmall,
              ),
              Text(
                'Ticket will be sent to below input number',
                style: _textTheme.bodyLarge,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                title: 'Full Name',
                hintText: 'Full Name',
                controller: contactName,
              ),
              CustomTextField(
                title: 'Email',
                hintText: 'Email',
                controller: contactEmail,
              ),
              CustomTextField(
                title: 'Mobile Number',
                hintText: 'Mobile Number',
                controller: contactNumber,
              ),
              Text(
                'Passenger Detail',
                style: _textTheme.displaySmall,
              ),
              Text(
                'Please enter following details',
                style: _textTheme.bodyLarge,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 120,
                child: ListView.builder(
                  itemCount: widget.adultCount + widget.childrenCount,
                  itemBuilder: (context, index) {
                    final passenger = passengers[index];
                    return CustomTextField(
                      title: "First Name",
                      onChanged: (value) {
                        setState(() {
                          passenger.firstname = value;
                        });
                      },
                    );
                  },
                ),
              ),

              // if (widget.adultCount > 0)
              //   ListView.builder(
              //     physics: NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     itemCount: widget.adultCount,
              //     itemBuilder: (context, index) {
              //       return Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             'Please enter adult ${index + 1} details',
              //             style: _textTheme.headlineSmall,
              //           ),
              //           SizedBox(
              //             height: 10,
              //           ),
              //           CustomTextField(
              //             controller: _firstNameController,
              //             validator: (value) =>
              //                 FormValidator.validateFieldNotEmpty(
              //                     value, 'Name'),
              //             title: 'First Name',
              //           ),
              //           CustomTextField(
              //             controller: lastNameController,
              //             validator: (value) =>
              //                 FormValidator.validateFieldNotEmpty(
              //                     value, 'Name'),
              //             title: 'Last Name',
              //           ),
              //           CustomTextField(
              //             title: 'Nationality',
              //           ),
              //         ],
              //       );
              //     },
              //   ),
              // if (widget.childrenCount > 0)
              //   ListView.builder(
              //     physics: NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     itemCount: widget.childrenCount,
              //     itemBuilder: (context, index) {
              //       return Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             'Please enter children ${index + 1} details',
              //             style: _textTheme.headlineSmall,
              //           ),
              //           SizedBox(
              //             height: 10,
              //           ),
              //           CustomTextField(
              //             title: 'Full Name',
              //           ),
              //           CustomTextField(
              //             title: 'Nationality',
              //           ),
              //         ],
              //       );
              //     },
              //   ),
            ],
          ),
        ),
      ),
      buttonName: 'Pay',
      onButtonPressed: () {
        _formKey.currentState!.save();
        if (_formKey.currentState!.validate()) {
          NavigationService.push(
              target: CommonBillDetailPage(
                  body: Container(),
                  accountDetails: {},
                  apiEndpoint: "/api/arsissueticket",
                  apiBody: {
                    "accountNumber":
                        RepositoryProvider.of<CustomerDetailRepository>(context)
                            .selectedAccount
                            .value!
                            .accountNumber,
                    "serviceIdentifier": "ARS",
                    "airlineId": "",
                    "flightId": widget.departureFlight!.flightId,
                    "returnFlightId": "",
                    "amount": widget.departureFlight!.totalFare,
                    "channel": "MOBILE",
                    "reservationStatus": "OK",
                    "feeTax": widget.departureFlight!.tax,
                    "totalPassenger": widget.adultCount,
                    "agencyCommission":
                        widget.departureFlight!.agencyCommission,
                    "contactName": contactName.text,
                    "contactEmail": contactEmail.text,
                    "contactNumber": contactNumber.text,
                    "issueTicketRequest": [
                      {
                        "firstName": _firstNameController.text,
                        "lastName": lastNameController.text,
                        "nationality": "NP",
                        "paxRemarks": "Test",
                        "paxType": "Adult",
                        "title": "Mr.",
                        "gender": "M"
                      }
                    ],
                  },
                  service: widget.service,
                  serviceIdentifier: "ARS"));

          print('validated');
        }
      },
    ));
  }
}
