// import 'package:flutter/material.dart';
// import 'package:ismart/common/util/size_utils.dart';
// import 'package:ismart/common/widget/common_button.dart';
// import 'package:paywell_wallet/common/localization/paywell_localizations.dart';
// import 'package:paywell_wallet/common/navigation/navigation_service.dart';
// import 'package:paywell_wallet/common/utils/size_utils.dart';
// import 'package:paywell_wallet/common/widgets/bottomsheet/bottom_sheet_wrapper.dart';
// import 'package:paywell_wallet/common/widgets/buttons/custom_rounded_button.dart';
// import 'package:paywell_wallet/features/flights/ui/widgets/incremental_list_tile.dart';

// showTravellerInfoBottomSheet(
//   BuildContext context,
//   ValueNotifier<int> childrenCountNotifier,
//   ValueNotifier<int> adultCountNotifier,
// ) {
//   return showModalBottomSheet(
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(30),
//         topRight: Radius.circular(30),
//       ),
//     ),
//     builder: (context) {
//       return TravellerInfoBottomSheet(
//         adultCountNotifier: adultCountNotifier,
//         childrenCountNotifier: childrenCountNotifier,
//       );
//     },
//   );
// }

// class TravellerInfoBottomSheet extends StatefulWidget {
//   const TravellerInfoBottomSheet({
//     Key? key,
//     required this.childrenCountNotifier,
//     required this.adultCountNotifier,
//   }) : super(key: key);

//   final ValueNotifier<int> childrenCountNotifier;
//   final ValueNotifier<int> adultCountNotifier;

//   @override
//   State<TravellerInfoBottomSheet> createState() =>
//       _TravellerInfoBottomSheetState();
// }

// class _TravellerInfoBottomSheetState extends State<TravellerInfoBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return BottomSheetWrapper(
//       title: context.loc.flight.passengerInformation,
//       child: Column(
//         children: [
//           ValueListenableBuilder<int>(
//             valueListenable: widget.adultCountNotifier,
//             builder: (context, value, _) {
//               return IncrementalListTile(
//                 title: context.loc.flight.adults,
//                 subTitle: context.loc.plusYears(12),
//                 initialValue: value,
//                 valueNotifier: widget.adultCountNotifier,
//                 onChanged: (val) {
//                   setState(() {
//                     widget.adultCountNotifier.value = val;
//                   });
//                 },
//               );
//             },
//           ),
//           SizedBox(
//             height: 15.hp,
//           ),
//           ValueListenableBuilder<int>(
//               valueListenable: widget.childrenCountNotifier,
//               builder: (context, value, _) {
//                 return IncrementalListTile(
//                   title: context.loc.flight.children,
//                   subTitle: context.loc.underYears(12),
//                   initialValue: value,
//                   valueNotifier: widget.childrenCountNotifier,
//                   onChanged: (val) {
//                     print(val);
//                     setState(() {
//                       widget.childrenCountNotifier.value = val;
//                     });
//                   },
//                 );
//               }),
//           SizedBox(height: 15.hp),
//           CustomRoundedButtom(
//             title: "context.loc.apply",
//             onPressed: () {
//               NavigationService.pop();
//             },
//           ),
//           SizedBox(height: 30.hp),
//         ],
//       ),
//     );
//   }
// }
