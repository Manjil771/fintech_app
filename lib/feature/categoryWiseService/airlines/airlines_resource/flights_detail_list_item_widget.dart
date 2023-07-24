// import 'package:flutter/material.dart';
// import 'package:paywell_wallet/app/theme.dart';
// import 'package:paywell_wallet/common/icons/paywell_icons_icons.dart';
// import 'package:paywell_wallet/common/localization/paywell_localizations.dart';
// import 'package:paywell_wallet/common/model/utility_services.dart';
// import 'package:paywell_wallet/common/utils/size_utils.dart';
// import 'package:paywell_wallet/common/widgets/images/custom_cache_network_image.dart';
// import 'package:paywell_wallet/features/flights/models/flights.dart';

// class FlightDetailsListItemWidget extends StatefulWidget {
//   const FlightDetailsListItemWidget({
//     Key? key,
//     required this.flight,
//     required this.isSelected,
//     required this.isAboveSelection,
//     required this.serviceInfo,
//   }) : super(key: key);

//   final bool isSelected;
//   final bool isAboveSelection;

//   final Flight flight;
//   final UtilityServices serviceInfo;

//   @override
//   State<FlightDetailsListItemWidget> createState() =>
//       _FlightDetailsListItemWidgetState();
// }

// class _FlightDetailsListItemWidgetState
//     extends State<FlightDetailsListItemWidget> {
//   double _cashbackAmount = 0.0;

//   @override
//   void initState() {
//     // TODO: implement initState
//     _cashbackAmount =
//         widget.serviceInfo.calculateCashback(widget.flight.fareTotal);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;
//     final _width = SizeUtils.width;
//     return Container(
//       width: _width,
//       decoration: BoxDecoration(
//         color: widget.isSelected ? _theme.primaryColor.withOpacity(0.15) : null,
//         // borderRadius: BorderRadius.circular(20.hp),
//       ),
//       padding: widget.isSelected ? EdgeInsets.all(15.hp) : EdgeInsets.zero,
//       // margin: EdgeInsets.only(bottom: 15.hp),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomCachedNetworkImage(
//                 url: widget.flight.airlineLogo,
//                 height: 40,
//                 width: 40,
//                 fit: BoxFit.fill,
//               ),
//               SizedBox(width: 15.hp),
//               Expanded(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               widget.flight.airlineName,
//                               style: _textTheme.headline6!.copyWith(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 5.hp,
//                             ),
//                             Text(
//                               widget.flight.flightNo,
//                               style: _textTheme.subtitle2!.copyWith(
//                                 color: CustomTheme.darkGrayColor,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Text(
//                           widget.flight.currency +
//                               " " +
//                               widget.flight.fareTotal.toString(),
//                           style: _textTheme.headline6!.copyWith(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10.hp,
//                     ),
//                     Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               widget.flight.departureTime,
//                               style: _textTheme.subtitle2!.copyWith(
//                                   color: CustomTheme.darkGrayColor,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 5.hp),
//                               child: Icon(
//                                 PaywellIcons.flight,
//                                 color: _theme.primaryColor,
//                               ),
//                             ),
//                             Text(
//                               widget.flight.arrivalTime,
//                               style: _textTheme.subtitle2!.copyWith(
//                                 color: CustomTheme.darkGrayColor,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: widget.isSelected
//                                 ? Colors.white
//                                 : _theme.primaryColor.withOpacity(0.15),
//                             borderRadius: BorderRadius.circular(
//                               10.hp,
//                             ),
//                           ),
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 10.hp,
//                             vertical: 3.hp,
//                           ),
//                           child: Text(
//                             "${context.loc.cashback}: NPR $_cashbackAmount",
//                             style: _textTheme.subtitle1!.copyWith(
//                               color: _theme.primaryColor,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10.hp,
//                     ),
//                     Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 2.5,
//                               backgroundColor: _theme.primaryColor,
//                             ),
//                             SizedBox(
//                               width: 3.hp,
//                             ),
//                             Text(
//                               "Class " + widget.flight.flightClassCode,
//                               style: _textTheme.subtitle1!.copyWith(
//                                 color: CustomTheme.darkGrayColor,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 5.hp,
//                             ),
//                             CircleAvatar(
//                               radius: 2.5,
//                               backgroundColor: _theme.primaryColor,
//                             ),
//                             SizedBox(
//                               width: 3.hp,
//                             ),
//                             Text(
//                               widget.flight.airline,
//                               style: _textTheme.subtitle1!.copyWith(
//                                 color: CustomTheme.darkGrayColor,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10.hp,
//                     ),
//                     Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 2.5,
//                               backgroundColor: _theme.primaryColor,
//                             ),
//                             SizedBox(
//                               width: 3.hp,
//                             ),
//                             Text(
//                               widget.flight.freeBaggage,
//                               style: _textTheme.subtitle1!.copyWith(
//                                 color: CustomTheme.darkGrayColor,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Text(
//                           widget.flight.refundable
//                               ? context.loc.flight.refundable
//                               : context.loc.flight.nonRefundable,
//                           style: _textTheme.subtitle1!.copyWith(
//                             color: widget.flight.refundable
//                                 ? CustomTheme.green
//                                 : Colors.red,
//                             fontWeight: FontWeight.normal,
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
