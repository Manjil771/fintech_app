// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:paywell_wallet/common/constants/slugs.dart';
// import 'package:paywell_wallet/common/cubits/data_state.dart';
// import 'package:paywell_wallet/common/cubits/use_service_cubit.dart';
// import 'package:paywell_wallet/common/localization/paywell_localizations.dart';
// import 'package:paywell_wallet/common/model/use_service_response.dart';
// import 'package:paywell_wallet/common/model/utility_services.dart';
// import 'package:paywell_wallet/common/navigation/navigation_service.dart';
// import 'package:paywell_wallet/common/utils/amount_utils.dart';
// import 'package:paywell_wallet/common/utils/size_utils.dart';
// import 'package:paywell_wallet/common/widgets/buttons/custom_rounded_button.dart';
// import 'package:paywell_wallet/common/widgets/dialog/confirmation_dialog.dart';
// import 'package:paywell_wallet/common/widgets/dialog/loading_dialog.dart';
// import 'package:paywell_wallet/common/widgets/dialog/wallet_error_dialog.dart';
// import 'package:paywell_wallet/common/widgets/page_wrapper.dart';
// import 'package:paywell_wallet/features/flights/models/flights.dart';
// import 'package:paywell_wallet/features/flights/ui/screens/passenger_details_form_page.dart';
// import 'package:paywell_wallet/features/flights/ui/widgets/flight_details_card.dart';

// class FlightDetailsWidget extends StatefulWidget {
//   const FlightDetailsWidget({
//     Key? key,
//     required this.outboundFlightDetails,
//     this.inboundFlightDetails,
//     required this.isTwoWay,
//     required this.bookingID,
//     required this.services,
//   }) : super(key: key);
//   final Flight outboundFlightDetails;
//   final Flight? inboundFlightDetails;
//   final bool isTwoWay;
//   final String bookingID;
//   final UtilityServices services;

//   @override
//   State<FlightDetailsWidget> createState() => _FlightDetailsWidgetState();
// }

// class _FlightDetailsWidgetState extends State<FlightDetailsWidget> {
//   bool _isLoading = false;

//   int _totalAmount = 0;
//   double _cashbackAmount = 0.0;

//   @override
//   void initState() {
//     _totalAmount = widget.outboundFlightDetails.fareTotal;

//     if (widget.inboundFlightDetails != null) {
//       _totalAmount += widget.inboundFlightDetails!.fareTotal;
//     }

//     _cashbackAmount = widget.services.calculateCashback(_totalAmount);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;
//     final _height = SizeUtils.height;
//     final _width = SizeUtils.width;

//     return PageWrapper(
//       title: context.loc.flight.flightDetails,
//       padding: EdgeInsets.zero,
//       body: Container(
//         height: _height,
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.hp),
//                 child: Column(
//                   children: [
//                     BlocListener<UseServiceCubit, WalletCommonState>(
//                       listener: (context, state) {
//                         if (state is WalletCommonLoading &&
//                             _isLoading == false) {
//                           showLoadingDialogBox(context);
//                           _isLoading = true;
//                         } else if (state is! WalletCommonLoading &&
//                             _isLoading == true) {
//                           Navigator.pop(context);
//                           _isLoading = false;
//                         }
//                         if (state
//                             is WalletCommonStateSuccess<UseServiceResponse>) {
//                           String validityRaw =
//                               state.data.findValueString("ttl");
//                           DateTime validityTime =
//                               DateTime.tryParse(validityRaw) ??
//                                   DateTime.now().add(Duration(minutes: 30));
//                           String minutes = validityTime
//                               .difference(DateTime.now())
//                               .inMinutes
//                               .toString();
//                           showConfirmationDialog(
//                             context,
//                             context.loc.flight.getBookedTimeDynamic(minutes),
//                             context.loc.flight.success,
//                             () {
//                               NavigationService.pop();
//                               NavigationService.pop();
//                               NavigationService.pushReplacement(
//                                 target: PassengerDetailsPage(
//                                   inboundFlight: widget.inboundFlightDetails,
//                                   outboundFlight: widget.outboundFlightDetails,
//                                   bookingID: widget.bookingID,
//                                   validityTime: validityTime,
//                                   services: widget.services,
//                                 ),
//                               );
//                             },
//                             showCancelButton: false,
//                           );
//                         } else if (state is WalletCommonError) {
//                           showWalletErrorDialogBox(
//                             context: context,
//                             message: state.message,
//                             errorCode: state.statusCode?.toString() ?? "",
//                           );
//                         }
//                       },
//                       child: Container(),
//                     ),
//                     FlightDetailsCard(
//                       flightDetails: widget.outboundFlightDetails,
//                       title: context.loc.flight.departureFlightDetails,
//                     ),
//                     SizedBox(
//                       height: 10.hp,
//                     ),
//                     if (widget.inboundFlightDetails != null)
//                       FlightDetailsCard(
//                         flightDetails: widget.inboundFlightDetails!,
//                         title: context.loc.flight.returnFlightDetails,
//                       ),
//                     SizedBox(
//                       height: 190.hp,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 0.00,
//               width: _width,
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white, borderRadius: BorderRadius.only()),
//                 padding: EdgeInsets.all(20.hp),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           context.loc.flight.totalAmount,
//                           style: _textTheme.titleLarge!.copyWith(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               _totalAmount.toString(),
//                               style: _textTheme.headlineSmall!.copyWith(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5.hp,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: _theme.primaryColor.withOpacity(0.15),
//                                 borderRadius: BorderRadius.circular(10.hp),
//                               ),
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 10.hp, vertical: 3.hp),
//                               child: Text(
//                                   "${context.loc.cashback} : Rs. $_cashbackAmount"),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15.hp,
//                     ),
//                     CustomRoundedButtom(
//                       title: context.loc.continueKey,
//                       onPressed: () {
//                         Map<String, dynamic> _body = {
//                           "wallet_service": "FLIGHT_BOOK",
//                           "booking_id": widget.bookingID,
//                           "flight_id": widget.outboundFlightDetails.flightId,
//                           "amount": AmountUtils.getAmountInPaisa(
//                               amount: _totalAmount.toString()),
//                         };

//                         if (widget.isTwoWay) {
//                           _body['return_flight_id'] =
//                               widget.inboundFlightDetails!.flightId;
//                         }

//                         showConfirmationDialog(
//                           context,
//                           context.loc.flight.flightWillBeBooked,
//                           context.loc.flight.confirmation,
//                           () {
//                             NavigationService.pop();
//                             context
//                                 .read<UseServiceCubit>()
//                                 .fetchDetails(slug: Slugs.flights, body: _body);
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
