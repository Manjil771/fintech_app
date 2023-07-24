// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:paywell_wallet/app/theme.dart';
// import 'package:paywell_wallet/common/cubits/data_state.dart';
// import 'package:paywell_wallet/common/icons/paywell_icons_icons.dart';
// import 'package:paywell_wallet/common/localization/paywell_localizations.dart';
// import 'package:paywell_wallet/common/model/use_service_response.dart';
// import 'package:paywell_wallet/common/model/utility_services.dart';
// import 'package:paywell_wallet/common/navigation/navigation_service.dart';
// import 'package:paywell_wallet/common/utils/custom_toast.dart';
// import 'package:paywell_wallet/common/utils/size_utils.dart';
// import 'package:paywell_wallet/common/widgets/images/rounded_image.dart';
// import 'package:paywell_wallet/features/flights/cubits/flights_booking_cubit.dart';
// import 'package:paywell_wallet/features/flights/models/add_info_pending_flights_response.dart';
// import 'package:paywell_wallet/features/flights/models/flights.dart';
// import 'package:paywell_wallet/features/flights/resources/booked_flights_repository.dart';
// import 'package:paywell_wallet/features/flights/ui/screens/booked_flight_details_page.dart';
// import 'package:paywell_wallet/features/flights/ui/screens/passenger_details_form_page.dart';
// import 'package:paywell_wallet/features/flights/ui/widgets/row_icon_text_widget.dart';

// class FlightBookingListItemParent extends StatelessWidget {
//   const FlightBookingListItemParent({
//     Key? key,
//     required this.outboundFlight,
//     required this.bookingID,
//     required this.passengerCount,
//     required this.services,
//     required this.leftMinutes,
//     this.inboundFlight,
//   }) : super(key: key);

//   final Flight outboundFlight;
//   final Flight? inboundFlight;
//   final int passengerCount;
//   final int bookingID;
//   final int leftMinutes;

//   final UtilityServices services;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => WalletBookedFlightCubit(
//         bookedFlightsRepository:
//             RepositoryProvider.of<BookedFlightsRepository>(context),
//       ),
//       child: PendingBookingsListItemWidget(
//         outboundFlight: outboundFlight,
//         inboundFlight: inboundFlight,
//         bookingID: bookingID,
//         passengerCount: passengerCount,
//         services: services,
//         leftMinutes: leftMinutes,
//       ),
//     );
//   }
// }

// class PendingBookingsListItemWidget extends StatefulWidget {
//   const PendingBookingsListItemWidget({
//     Key? key,
//     required this.outboundFlight,
//     required this.bookingID,
//     required this.passengerCount,
//     required this.services,
//     required this.leftMinutes,
//     this.inboundFlight,
//   }) : super(key: key);

//   final Flight outboundFlight;
//   final Flight? inboundFlight;
//   final int passengerCount;
//   final int bookingID;

//   final int leftMinutes;
//   final UtilityServices services;
//   @override
//   State<PendingBookingsListItemWidget> createState() =>
//       _PendingBookingsListItemWidgetState();
// }

// class _PendingBookingsListItemWidgetState
//     extends State<PendingBookingsListItemWidget> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;

//     return BlocListener<WalletBookedFlightCubit, WalletCommonState>(
//       listener: (context, state) {
//         if (state is WalletCommonStateSuccess) {
//           UseServiceResponse _bookingInfoDetails = state.data;
//           String _lastStep = _bookingInfoDetails.findValueString("last_step");
//           Map<String, dynamic> ttlTimeMap =
//               _bookingInfoDetails.findValue(name: "book");
//           String? ttlTime = ttlTimeMap['response']['ttl'];

//           DateTime? _validity;
//           if (ttlTime != null) {
//             _validity = DateTime.parse(ttlTime);
//           } else {
//             _validity = DateTime.now();
//           }
//           print(_validity.difference(DateTime.now().toUtc()));
//           if (_lastStep != "book") {
//             Map<String, dynamic> _addInfoRawData =
//                 _bookingInfoDetails.findValue(name: "addinfo");
//             Map<String, dynamic> _passengerDetailsRawData =
//                 _addInfoRawData['request'];
//             PendingFlightsAddInfoResponse _parsedPassengerInfoDetails =
//                 PendingFlightsAddInfoResponse.fromJson(
//                     _passengerDetailsRawData);
//             if (_lastStep == "issue") {
//               CustomToast.error(
//                 message:
//                     "Flight booking has been already completed. Check my bookings section to see all your booked flights",
//               );
//             } else if (_lastStep == "addinfo") {
//               NavigationService.pushReplacement(
//                 target: BookedFlightDetailsPage(
//                   inboundFlightDetails: widget.inboundFlight,
//                   outboundFlightDetails: widget.outboundFlight,
//                   passengerAndContactInfo: _passengerDetailsRawData,
//                   bookingId: widget.bookingID.toString(),
//                   validityTime: _validity,
//                   services: widget.services,
//                 ),
//               );
//             }
//           } else if (_lastStep == "book") {
//             NavigationService.push(
//               target: PassengerDetailsPage(
//                 outboundFlight: widget.outboundFlight,
//                 bookingID: widget.bookingID.toString(),
//                 validityTime: _validity,
//                 services: widget.services,
//               ),
//             );
//           }
//         }
//       },
//       child: Material(
//         color: CustomTheme.lightGray,
//         borderRadius: BorderRadius.circular(30.hp),
//         child: InkWell(
//           onTap: () {
//             context.read<WalletBookedFlightCubit>().fetchBookingInfo(
//                   context: context,
//                   bookingID: widget.bookingID,
//                 );
//           },
//           splashColor: CustomTheme.primaryColor.withOpacity(0.15),
//           borderRadius: BorderRadius.circular(30.hp),
//           child: Container(
//             padding: EdgeInsets.all(20.hp),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomRoundedImage(
//                       height: 60.hp,
//                       image: widget.outboundFlight.airlineLogo,
//                       width: 60.hp,
//                     ),
//                     SizedBox(width: 15.hp),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 widget.outboundFlight.departureCode,
//                                 style: _textTheme.headline6!.copyWith(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Icon(
//                                 PaywellIcons.flight,
//                                 color: _theme.primaryColor,
//                               ),
//                               Text(
//                                 widget.outboundFlight.arrivalCode,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: _textTheme.headline6!.copyWith(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 8.hp),
//                           Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     widget.outboundFlight.departure,
//                                     style: _textTheme.subtitle2!.copyWith(
//                                       color: CustomTheme.darkGrayColor,
//                                     ),
//                                   ),
//                                   Icon(Icons.arrow_right_alt),
//                                   Text(
//                                     widget.outboundFlight.arrival,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: _textTheme.subtitle2!.copyWith(
//                                       color: CustomTheme.darkGrayColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 8.hp),
//                           RowIconTextWidget(
//                             icon: PaywellIcons.user,
//                             text:
//                                 "${widget.passengerCount} ${context.loc.flight.passengers}",
//                           ),
//                           RowIconTextWidget(
//                             icon: PaywellIcons.calendar,
//                             text: widget.outboundFlight.flightDate,
//                           ),
//                           RowIconTextWidget(
//                             icon: PaywellIcons.ticket,
//                             text:
//                                 "${context.loc.flight.timeLeft}: ${widget.leftMinutes} min",
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 Divider(
//                   color: CustomTheme.darkGrayColor,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       context.loc.flight.tripTotal,
//                       style: _textTheme.headline6!.copyWith(
//                         color: CustomTheme.darkGrayColor,
//                       ),
//                     ),
//                     Text(
//                       widget.outboundFlight.fareTotal.toString(),
//                       style: _textTheme.headline6!.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
