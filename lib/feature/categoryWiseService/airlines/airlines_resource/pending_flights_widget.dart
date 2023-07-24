// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:paywell_wallet/common/constants/constant_assets.dart';
// import 'package:paywell_wallet/common/cubits/data_state.dart';
// import 'package:paywell_wallet/common/localization/paywell_localizations.dart';
// import 'package:paywell_wallet/common/model/use_service_response.dart';
// import 'package:paywell_wallet/common/model/utility_services.dart';
// import 'package:paywell_wallet/common/utils/size_utils.dart';
// import 'package:paywell_wallet/common/widgets/no_data_available_widget.dart';
// import 'package:paywell_wallet/common/widgets/page_wrapper.dart';
// import 'package:paywell_wallet/features/flights/cubits/flights_booking_cubit.dart';
// import 'package:paywell_wallet/features/flights/models/flights.dart';
// import 'package:paywell_wallet/features/flights/ui/widgets/pending_bookings_list_item_widget.dart';

// class PendingFlightsListWidget extends StatefulWidget {
//   const PendingFlightsListWidget({Key? key, required this.services})
//       : super(key: key);
//   final UtilityServices services;

//   @override
//   State<PendingFlightsListWidget> createState() =>
//       _PendingFlightsListWidgetState();
// }

// class _PendingFlightsListWidgetState extends State<PendingFlightsListWidget> {
//   @override
//   void initState() {
//     super.initState();
//     context
//         .read<WalletBookedFlightCubit>()
//         .fetchPendingBookedFlights(context: context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;

//     return PageWrapper(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 15.hp),
//             Text(
//               context.loc.flight.pendingBookings,
//               style: _textTheme.headline1,
//             ),
//             SizedBox(height: 5.hp),
//             Text(
//               context.loc.flight.pleaseSelectABooking,
//               style: _textTheme.headline6,
//             ),
//             SizedBox(
//               height: 15.hp,
//             ),
// // aa
//             BlocBuilder<WalletBookedFlightCubit, WalletCommonState>(
//               builder: (context, state) {
//                 if (state
//                     is WalletCommonStateSuccess<List<UseServiceResponse>>) {
//                   List<UseServiceResponse> data = state.data;

//                   if (data.isNotEmpty) {
//                     return Column(
//                       children: List.generate(
//                         data.length,
//                         (index) {
//                           Flight? _inboundFlightParsed;
//                           UseServiceResponse _individualData =
//                               state.data[index];
//                           Map<String, dynamic> _inboundFlight =
//                               _individualData.findValue(name: "inbound");
//                           Map<String, dynamic> _outboundFlight =
//                               _individualData.findValue(name: "outbound");

//                           if (_outboundFlight.isEmpty) {
//                             return Container();
//                           }
//                           int passengerCount = _individualData.findValue(
//                               name: "passenger_count");
//                           int bookingID =
//                               _individualData.findValue(name: "booking_id");

//                           String _ttlRaw =
//                               _individualData.findValueString("ttl");

//                           DateTime _ttl = DateTime.parse(_ttlRaw);

//                           Duration _timeLeft =
//                               _ttl.difference(DateTime.now().toUtc());

//                           print(_timeLeft.inMinutes);
//                           Flight _outboundFlightParsed =
//                               Flight.fromJson(_outboundFlight);
//                           if (_inboundFlight.isNotEmpty) {
//                             _inboundFlightParsed =
//                                 Flight.fromJson(_inboundFlight);
//                           }

//                           return FlightBookingListItemParent(
//                             outboundFlight: _outboundFlightParsed,
//                             inboundFlight: _inboundFlightParsed,
//                             bookingID: bookingID,
//                             passengerCount: passengerCount,
//                             services: widget.services,
//                             leftMinutes: _timeLeft.inMinutes,
//                           );
//                         },
//                       ),
//                     );
//                   } else {
//                     return WalletNoDataAvailableWidget(
//                       description: "No pending flights found.",
//                       image: WalletAssets.noData,
//                       title: "",
//                     );
//                   }
//                 } else {
//                   return Container(
//                     child: Text("No data found."),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
