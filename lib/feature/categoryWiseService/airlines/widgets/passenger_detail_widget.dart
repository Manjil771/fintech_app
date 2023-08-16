import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/common_transaction_success_screen.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_avliable_list_model.dart';
import 'package:ismart/feature/categoryWiseService/airlines/resources/passenger_detail_model.dart';
import 'package:ismart/feature/categoryWiseService/airlines/widgets/airlines_bill_detail_widget.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class PassengerDetailWidget extends StatefulWidget {
  Availability? departureFlight;
  Availability? arrivalFlight;

  final double totalFare;
  final ServiceList service;

  PassengerDetailWidget({
    Key? key,
    required this.arrivalFlight,
    required this.adultCount,
    required this.childrenCount,
    required this.departureFlight,
    required this.service,
    required this.totalFare,
  }) : super(key: key);

  final int adultCount;
  final int childrenCount;

  @override
  State<PassengerDetailWidget> createState() => _PassengerDetailWidgetState();
}

class _PassengerDetailWidgetState extends State<PassengerDetailWidget> {
  final _formKey = GlobalKey<FormState>();

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
          remarks: "",
          lastname: "",
          gender: "",
          title: "",
          nationality: "",
          type: "ADULT"));
    }
    for (int i = 0; i < widget.childrenCount; i++) {
      passengers.add(PassengerDetailModel(
          nationality: "",
          gender: "",
          remarks: "",
          title: "",
          firstname: "",
          lastname: "",
          type: "CHILDREN"));
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
        showAccountSelection: true,
        buttonName: "Procced",
        showDetail: true,
        title: widget.service.service,
        detail: widget.service.instructions,
        topbarName: widget.service.serviceCategoryName,
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
                                  (widget.departureFlight?.departureTime ??
                                          "") +
                                      "-" +
                                      (widget.departureFlight?.arrivalTime ??
                                          ""),
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
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.adultCount + widget.childrenCount,
                  itemBuilder: (context, index) {
                    final passenger = passengers[index];
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: CustomTextField(
                                  readOnly: true,
                                  customHintTextStyle: true,
                                  hintText: passenger.type == "ADULT"
                                      ? "Adult"
                                      : "Children",
                                  title: "Type",
                                  onChanged: (value) {
                                    setState(() {
                                      passenger.type = passenger.type == "ADULT"
                                          ? "ADULT".toLowerCase()
                                          : "CHILDREN".toLowerCase();
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 20.wp),
                            Expanded(
                              child: Container(
                                child: CustomTextField(
                                  title: "Nationality",
                                  onChanged: (value) {
                                    setState(() {
                                      // passenger.nationality = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: CustomTextField(
                                  title: "First Name",
                                  onChanged: (value) {
                                    setState(() {
                                      passenger.firstname = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 20.wp),
                            Expanded(
                              child: Container(
                                child: CustomTextField(
                                  title: "Last Name",
                                  onChanged: (value) {
                                    setState(() {
                                      passenger.lastname = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: CustomTextField(
                                  title: "Title",
                                  onChanged: (value) {
                                    setState(() {
                                      passenger.title = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 20.wp),
                            Expanded(
                              child: Container(
                                child: CustomTextField(
                                  title: "Gender",
                                  onChanged: (value) {
                                    setState(() {
                                      passenger.gender = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        CustomTextField(
                          title: "Remarks",
                          onChanged: (value) {
                            setState(() {
                              passenger.remarks = value;
                            });
                          },
                        ),
                        Divider(thickness: 2),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        onButtonPressed: () {
          final List passengerList =
              passengers.map((passenger) => passenger.toJson()).toList();
          final numberOfPassenger = widget.adultCount + widget.childrenCount;
          final departureComission =
              double.parse(widget.departureFlight?.agencyCommission ?? "0");
          final arrivalComission =
              double.parse(widget.arrivalFlight?.agencyCommission ?? "0");
          final double totalAgencyComission =
              (departureComission + arrivalComission) * numberOfPassenger;
          final departureFee = double.parse(widget.departureFlight?.tax ?? "0");
          final arrivalFee = double.parse(widget.arrivalFlight?.tax ?? "0");

          final double feeTax = departureFee + arrivalFee;
          _formKey.currentState!.save();
          if (_formKey.currentState!.validate()) {
            NavigationService.push(
                target: AirlinesBillDetailPage(
                    contactEmail: contactEmail.text,
                    contactName: contactName.text,
                    contactPhoneNumber: contactNumber.text,
                    arrivalFlight: widget.arrivalFlight,
                    departureFlight: widget.departureFlight,
                    totalFare: widget.totalFare,
                    accountDetails: {},
                    apiEndpoint: "/api/arsissueticket",
                    apiBody: {
                      "accountNumber":
                          RepositoryProvider.of<CustomerDetailRepository>(
                                  context)
                              .selectedAccount
                              .value!
                              .accountNumber,
                      "agencyCommission": totalAgencyComission,
                      "airlineId": "",
                      "amount": widget.totalFare,
                      "channel": "MOBILE",
                      "serviceIdentifier": "ARS",
                      "contactEmail": contactEmail.text,
                      "contactName": contactName.text,
                      "contactNumber": contactNumber.text,
                      "feeTax": feeTax * numberOfPassenger,
                      "flightId": widget.departureFlight?.flightId ?? "",
                      "returnFlightId": widget.arrivalFlight?.flightId ?? "",
                      "reservationStatus": "OK",
                      "totalPassenger": numberOfPassenger,
                      "issueTicketRequest": passengerList,
                    },
                    service: widget.service,
                    serviceIdentifier: widget.service.uniqueIdentifier));
          }
        },
      ),
    );
  }
}
