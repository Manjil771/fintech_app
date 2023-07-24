// import 'package:flutter/material.dart';
// import 'package:paywell_wallet/app/theme.dart';
// import 'package:paywell_wallet/common/localization/paywell_localizations.dart';
// import 'package:paywell_wallet/common/model/utility_services.dart';
// import 'package:paywell_wallet/common/navigation/navigation_service.dart';
// import 'package:paywell_wallet/common/utils/size_utils.dart';
// import 'package:paywell_wallet/common/widgets/buttons/custom_rounded_button.dart';
// import 'package:paywell_wallet/features/flights/models/flights.dart';
// import 'package:paywell_wallet/features/flights/ui/screens/flight_details_page.dart';
// import 'package:paywell_wallet/features/flights/ui/widgets/flight_amount_details_column_widget.dart';

// class FlightAmountWidgetWithButton extends StatelessWidget {
//   const FlightAmountWidgetWithButton({
//     Key? key,
//     required this.outBoundValues,
//     required this.inBoundValues,
//     required this.selectedInboundIndex,
//     required this.selectedOutboundIndex,
//     required this.isTwoWay,
//     required this.services,
//     required this.currentIndexNotifier,
//     required this.bookingId,
//     required this.totalPrice,
//   }) : super(key: key);
//   final List<Flight> outBoundValues;
//   final List<Flight> inBoundValues;
//   final int selectedInboundIndex;
//   final int selectedOutboundIndex;
//   final bool isTwoWay;
//   final ValueNotifier<int> currentIndexNotifier;
//   final String bookingId;
//   final double totalPrice;
//   final UtilityServices services;

//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _width = SizeUtils.width;

//     return Container(
//       width: _width,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       padding: EdgeInsets.symmetric(
//         horizontal: 20.hp,
//         vertical: 30.hp,
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               FlightAmountDetailsColumnWidget(
//                 title: context.loc.flight.departure,
//                 price:
//                     outBoundValues[selectedOutboundIndex].fareTotal.toString(),
//                 cashBack:
//                     outBoundValues[selectedOutboundIndex].cashBack.toString(),
//               ),
//               SizedBox(
//                 width: 10.hp,
//               ),
//               if (selectedInboundIndex != -1)
//                 FlightAmountDetailsColumnWidget(
//                   title: context.loc.flight.returnKey,
//                   price:
//                       inBoundValues[selectedInboundIndex].fareTotal.toString(),
//                   cashBack: inBoundValues[selectedInboundIndex].cashBack == null
//                       ? "0.00"
//                       : inBoundValues[selectedInboundIndex].cashBack.toString(),
//                 ),
//               Container(
//                 height: 30.hp,
//                 child: VerticalDivider(
//                   color: CustomTheme.midGrayColor,
//                   thickness: 2.hp,
//                   width: 20.hp,
//                 ),
//               ),
//               FlightAmountDetailsColumnWidget(
//                 title: "Total",
//                 price: "$totalPrice",
//                 cashBack: "0.00",
//               ),
//               SizedBox(
//                 width: 20.hp,
//               ),
//               Expanded(
//                 child: Container(
//                   height: 45.hp,
//                   child: CustomRoundedButtom(
//                     padding: EdgeInsets.zero,
//                     title: "Book",
//                     onPressed: () {
//                       if (isTwoWay && selectedInboundIndex == -1) {
//                         currentIndexNotifier.value = 1;
//                         // setState(() {});
//                       } else {
//                         NavigationService.push(
//                           target: FlightDetailsPage(
//                             isTwoWay: isTwoWay,
//                             outboundFlightDetails:
//                                 outBoundValues[selectedOutboundIndex],
//                             inboundFlightDetails: isTwoWay
//                                 ? inBoundValues[selectedInboundIndex]
//                                 : null,
//                             bookingId: bookingId,
//                             services: services,
//                           ),
//                         );
//                       }
//                     },
//                     textColor: _theme.primaryColor,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 15.hp,
//           ),
//         ],
//       ),
//     );
//   }
// }
