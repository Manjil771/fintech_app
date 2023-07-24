// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:paywell_wallet/app/theme.dart';
// import 'package:paywell_wallet/common/constants/slugs.dart';
// import 'package:paywell_wallet/common/cubits/data_state.dart';
// import 'package:paywell_wallet/common/cubits/use_service_cubit.dart';
// import 'package:paywell_wallet/common/localization/paywell_localizations.dart';
// import 'package:paywell_wallet/common/model/link_account_model.dart';
// import 'package:paywell_wallet/common/model/use_service_response.dart';
// import 'package:paywell_wallet/common/model/utility_services.dart';
// import 'package:paywell_wallet/common/navigation/navigation_service.dart';
// import 'package:paywell_wallet/common/pages/ui/verify_with_pin_screens.dart';
// import 'package:paywell_wallet/common/pages/widgets/show_payment_methods_bottom_sheet.dart';
// import 'package:paywell_wallet/common/utils/amount_utils.dart';
// import 'package:paywell_wallet/common/utils/size_utils.dart';
// import 'package:paywell_wallet/common/widgets/buttons/custom_rounded_button.dart';
// import 'package:paywell_wallet/common/widgets/common_amount_section.dart';
// import 'package:paywell_wallet/common/widgets/controllers/amount_summary_controller.dart';
// import 'package:paywell_wallet/common/widgets/dialog/loading_dialog.dart';
// import 'package:paywell_wallet/common/widgets/dialog/wallet_error_dialog.dart';
// import 'package:paywell_wallet/common/widgets/key_value_tile.dart';
// import 'package:paywell_wallet/common/widgets/page_wrapper.dart';
// import 'package:paywell_wallet/features/flights/models/flights.dart';
// import 'package:paywell_wallet/features/flights/ui/screens/flight_receipt_page.dart';
// import 'package:paywell_wallet/features/flights/ui/widgets/flight_details_card.dart';

// class BookedFlightDetailsWidget extends StatefulWidget {
//   const BookedFlightDetailsWidget({
//     Key? key,
//     required this.outBoundFlight,
//     required this.passengerAndContactInfo,
//     required this.bookingID,
//     required this.validityTime,
//     this.inboundFlight,
//     required this.services,
//   }) : super(key: key);
//   final Flight outBoundFlight;
//   final Flight? inboundFlight;
//   final String bookingID;
//   final UtilityServices services;

//   final DateTime validityTime;
//   final Map passengerAndContactInfo;

//   @override
//   State<BookedFlightDetailsWidget> createState() =>
//       _BookedFlightDetailsWidgetState();
// }

// class _BookedFlightDetailsWidgetState extends State<BookedFlightDetailsWidget> {
//   final AmountSummaryController _amountSummaryController =
//       AmountSummaryController(showAmountTextField: false);
//   ValueNotifier<String> _promoCode = ValueNotifier("");

//   final TextEditingController _amountController = TextEditingController();

//   Timer? _timer;
//   String remainingTime = "";

//   @override
//   void initState() {
//     super.initState();
//     startTimer();

//     double _amount = 0;
//     _amount += widget.outBoundFlight.fareTotal;

//     if (widget.inboundFlight != null) {
//       _amount += widget.inboundFlight!.fareTotal;
//     }
//     _amountController.value = TextEditingValue(text: _amount.toString());
//   }

//   @override
//   void dispose() {
//     _timer!.cancel();
//     super.dispose();
//   }

//   startTimer() {
//     _timer = Timer.periodic(
//       Duration(seconds: 1),
//       (timer) {
//         DateTime _now = DateTime.now().toUtc();
//         Duration _differentDuration =
//             widget.validityTime.toUtc().difference(_now);
//         remainingTime = "${_differentDuration.inSeconds} sec";
//         setState(() {});
//       },
//     );
//   }

//   bool _isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;
//     return BlocListener<UseServiceCubit, WalletCommonState>(
//       listener: (context, state) {
//         if (state is WalletCommonLoading && _isLoading == false) {
//           _isLoading = true;
//           showLoadingDialogBox(context);
//         } else if (state is! WalletCommonLoading && _isLoading) {
//           _isLoading = false;
//           Navigator.pop(context);
//         }

//         if (state is WalletCommonStateSuccess<UseServiceResponse>) {
//           Flight? _updatedOutboundFlight;
//           Flight? _updatedInbountFlight;
//           List<String> _flightIds = [];
//           Map<String, dynamic> _mapData = state.data.toJson();

//           if (_mapData['data']?['outbound']['pnr_no'] != null) {
//             _updatedOutboundFlight = widget.outBoundFlight
//                 .copyWith(pnrNumber: _mapData['data']?['outbound']['pnr_no']);
//           }

//           if (_mapData['data']?['inbound']['pnr_no'] != null &&
//               widget.inboundFlight != null) {
//             _updatedInbountFlight = widget.inboundFlight!
//                 .copyWith(pnrNumber: _mapData['data']?['inbound']['pnr_no']);
//           }

//           if (_mapData['data']?['log_ids'] != null) {
//             _flightIds = List.from(_mapData['data']['log_ids'] ?? [])
//                 .map((e) => e as String)
//                 .toList();
//           } else if (_mapData['data']['response_id'] != null) {
//             _flightIds.add(_mapData['data']['response_id']);
//           }

//           NavigationService.pushReplacement(
//             target: FlightsReceiptPage(
//               outboundFlightDetails: _updatedOutboundFlight!,
//               inboundFlightDetails: _updatedInbountFlight,
//               passengerAndContactInfo: widget.passengerAndContactInfo,
//               bookingId: widget.bookingID,
//               validityTime: widget.validityTime,
//               services: widget.services,
//               ids: _flightIds,
//             ),
//           );
//         } else if (state is WalletCommonError) {
//           showWalletErrorDialogBox(
//             context: context,
//             message: state.message,
//             errorCode: state.statusCode?.toString() ?? "",
//           );
//         }
//       },
//       child: PageWrapper(
//         padding: EdgeInsets.zero,
//         floatinActionButton: CustomRoundedButtom(
//           title: context.loc.pay +
//               (remainingTime.isNotEmpty ? " ($remainingTime) " : ""),
//           onPressed: () {
//             showPaymentMethodsBottomSheet(
//               context: context,
//               onPaymentPressed:
//                   (PaymentType type, WalletLinkedAccountsDetail? data) {
//                 NavigationService.push(
//                   target: VerifyWithPinScreens(
//                     onSuccess: (pin) async {
//                       Map<String, dynamic> _body = {
//                         "wallet_service": "FLIGHT_ISSUE",
//                         "flight_id": widget.outBoundFlight.flightId,
//                         "booking_id": widget.bookingID,
//                         "amount": AmountUtils.getAmountInPaisa(
//                             amount: _amountController.text),
//                       };

//                       if (pin != null) {
//                         _body["pin"] = pin;
//                       } else {
//                         _body['pin'] = "";
//                       }

//                       if (_promoCode.value.isNotEmpty) {
//                         _body["coupon"] = _promoCode.value;
//                       }

//                       if (widget.inboundFlight != null) {
//                         _body['return_flight_id'] =
//                             widget.inboundFlight!.flightId;
//                       }

//                       if (type == PaymentType.LinkedAccount && data != null) {
//                         _body['link_id'] = data.linkId;
//                       }
//                       context.read<UseServiceCubit>().makePayments(
//                             slug: Slugs.flights,
//                             body: _body,
//                           );
//                       NavigationService.pop();
//                     },
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.hp),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 15.hp,
//                 ),
//                 Text(
//                   "Flight Details",
//                   style: _textTheme.displayLarge,
//                 ),
//                 SizedBox(
//                   height: 30.hp,
//                 ),
//                 FlightDetailsCard(
//                   flightDetails: widget.outBoundFlight,
//                   title: context.loc.flight.departureFlight,
//                   showFooter: false,
//                 ),
//                 if (widget.inboundFlight != null)
//                   SizedBox(
//                     height: 30.hp,
//                   ),
//                 if (widget.inboundFlight != null)
//                   FlightDetailsCard(
//                     flightDetails: widget.inboundFlight!,
//                     title: context.loc.flight.returnFlight,
//                     showFooter: false,
//                   ),
//                 SizedBox(
//                   height: 20.hp,
//                 ),
//                 Text(
//                   context.loc.flight.passengerInformation,
//                   style: _textTheme.titleLarge!.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.hp,
//                 ),
//                 ...List.generate(
//                   widget.passengerAndContactInfo['passengers'].length,
//                   (index) {
//                     return Container(
//                       padding: EdgeInsets.all(20.hp),
//                       decoration: BoxDecoration(
//                         color: CustomTheme.lightGray,
//                         borderRadius: BorderRadius.circular(
//                           30.hp,
//                         ),
//                       ),
//                       margin: EdgeInsets.only(bottom: 5.hp),
//                       child: Column(
//                         children: [
//                           KeyValueTile(
//                             title: context.loc.flight.name,
//                             value: widget.passengerAndContactInfo['passengers']
//                                     [index]['firstname'] +
//                                 " " +
//                                 widget.passengerAndContactInfo['passengers']
//                                     [index]['lastname'],
//                           ),
//                           KeyValueTile(
//                             title: context.loc.flight.nationality,
//                             value: widget.passengerAndContactInfo['passengers']
//                                 [index]['nationality'],
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(
//                   height: 10.hp,
//                 ),
//                 Text(
//                   context.loc.flight.contactPersonInformation,
//                   style: _textTheme.titleLarge!.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.hp,
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(20.hp),
//                   decoration: BoxDecoration(
//                     color: CustomTheme.lightGray,
//                     borderRadius: BorderRadius.circular(
//                       30.hp,
//                     ),
//                   ),
//                   margin: EdgeInsets.only(bottom: 5.hp),
//                   child: Column(
//                     children: [
//                       KeyValueTile(
//                         title: context.loc.flight.name,
//                         value: widget.passengerAndContactInfo['contact_name'],
//                       ),
//                       KeyValueTile(
//                         title: context.loc.flight.phone,
//                         value: widget.passengerAndContactInfo['contact_phone'],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.hp,
//                 ),
//                 CommonAmountSummarySection(
//                   amountController: _amountController,
//                   services: widget.services,
//                   promoCode: _promoCode,
//                   validator: (val) {
//                     return null;
//                   },
//                   summaryController: _amountSummaryController,
//                 ),
//                 SizedBox(
//                   height: 100.hp,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
