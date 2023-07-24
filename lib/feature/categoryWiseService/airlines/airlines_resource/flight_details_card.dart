// import 'package:flutter/material.dart';
// import 'package:paywell_wallet/app/theme.dart';
// import 'package:paywell_wallet/common/icons/paywell_icons_icons.dart';
// import 'package:paywell_wallet/common/utils/size_utils.dart';
// import 'package:paywell_wallet/common/widgets/images/rounded_image.dart';
// import 'package:paywell_wallet/common/widgets/key_value_tile.dart';
// import 'package:paywell_wallet/common/widgets/receipt/common_details_wrapper.dart';
// import 'package:paywell_wallet/features/flights/models/flights.dart';

// class FlightDetailsCard extends StatelessWidget {
//   const FlightDetailsCard({
//     Key? key,
//     required this.flightDetails,
//     required this.title,
//     this.showFooter = true,
//   }) : super(key: key);
//   final String title;
//   final Flight flightDetails;
//   final bool showFooter;
//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: _textTheme.headline6!.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(
//           height: 10.hp,
//         ),
//         CommonDetailsWrapper(
//           showDivider: showFooter,
//           header: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomRoundedImage(
//                 image: flightDetails.airlineLogo,
//                 height: 60,
//                 width: 60,
//               ),
//               SizedBox(
//                 width: 10.hp,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Row(
//                   //   children: [
//                   //     Text(
//                   //       flightDetails.departureCode,
//                   //       style: _textTheme.headline6!.copyWith(
//                   //         fontWeight: FontWeight.bold,
//                   //       ),
//                   //     ),
//                   //     Icon(
//                   //       PaywellIcons.flight,
//                   //       color: _theme.primaryColor,
//                   //     ),
//                   //     Text(
//                   //       flightDetails.arrivalCode,
//                   //       style: _textTheme.headline6!.copyWith(
//                   //         fontWeight: FontWeight.bold,
//                   //       ),
//                   //     ),
//                   //   ],
//                   // ),
//                   // SizedBox(
//                   //   height: 10.hp,
//                   // ),
//                   Row(
//                     children: [
//                       Text(
//                         flightDetails.departure,
//                         style: _textTheme.subtitle1!.copyWith(
//                           color: CustomTheme.darkGrayColor,
//                         ),
//                       ),
//                       Icon(
//                         PaywellIcons.flight,
//                         color: _theme.primaryColor,
//                       ),
//                       Text(
//                         flightDetails.arrival,
//                         style: _textTheme.subtitle1!.copyWith(
//                           color: CustomTheme.darkGrayColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5.hp,
//                   ),
//                   Text(
//                     flightDetails.flightDate,
//                     style: _textTheme.subtitle1!.copyWith(
//                       color: CustomTheme.darkGrayColor,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5.hp,
//                   ),
//                   Text(
//                     flightDetails.departureTime +
//                         " - " +
//                         flightDetails.arrivalTime,
//                     style: _textTheme.subtitle1!.copyWith(
//                       color: CustomTheme.darkGrayColor,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5.hp,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         flightDetails.flightNo +
//                             " | Class " +
//                             flightDetails.flightClassCode,
//                         style: _textTheme.subtitle1!.copyWith(
//                           color: CustomTheme.darkGrayColor,
//                         ),
//                       ),
//                       Text(
//                         flightDetails.refundable
//                             ? " | Refundable"
//                             : " | Non - Refundable",
//                         style: _textTheme.subtitle1!.copyWith(
//                           color: CustomTheme.darkGrayColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5.hp,
//                   ),
//                   Text(
//                     "Total Luggage : " + flightDetails.freeBaggage,
//                     style: _textTheme.subtitle1!.copyWith(
//                       color: CustomTheme.darkGrayColor,
//                     ),
//                   ),
//                   if (flightDetails.pnr.isNotEmpty)
//                     SizedBox(
//                       height: 5.hp,
//                     ),

//                   if (flightDetails.pnr.isNotEmpty)
//                     Text(
//                       "PNR No. : " + flightDetails.pnr,
//                       style: _textTheme.subtitle1!.copyWith(
//                         color: CustomTheme.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                 ],
//               ),
//             ],
//           ),
//           footer: showFooter
//               ? Column(
//                   children: [
//                     KeyValueTile(
//                       title: "Passenger",
//                       value: (flightDetails.adult + flightDetails.child)
//                           .toString(),
//                     ),
//                     KeyValueTile(
//                       title:
//                           "${flightDetails.adult} Adult * ${flightDetails.adultFare}",
//                       value: (flightDetails.adult * flightDetails.adultFare)
//                           .toString(),
//                     ),
//                     KeyValueTile(
//                       title:
//                           "${flightDetails.child} Child * ${flightDetails.childFare}",
//                       value: (flightDetails.child * flightDetails.childFare)
//                           .toString(),
//                     ),
//                     KeyValueTile(
//                       title: "Fuel Charges",
//                       value: (flightDetails.fuelSurcharge).toString(),
//                     ),
//                     KeyValueTile(
//                       title: "Tax",
//                       value: (flightDetails.tax).toString(),
//                       bottomPadding: 0,
//                     )
//                   ],
//                 )
//               : Container(),
//         ),
//       ],
//     );
//   }
// }
