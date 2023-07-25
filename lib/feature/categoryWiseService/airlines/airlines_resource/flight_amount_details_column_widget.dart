// import 'package:flutter/material.dart';
// import 'package:paywell_wallet/app/theme.dart';
// import 'package:paywell_wallet/common/utils/size_utils.dart';

// class FlightAmountDetailsColumnWidget extends StatelessWidget {
//   const FlightAmountDetailsColumnWidget({
//     Key? key,
//     required this.title,
//     required this.price,
//     required this.cashBack,
//   }) : super(key: key);

//   final String title;
//   final String price;
//   final String cashBack;
//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "$title",
//           style: _textTheme.subtitle2!.copyWith(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(
//           height: 5.hp,
//         ),
//         Text(
//           "NPR $price",
//           style: _textTheme.subtitle1!.copyWith(
//             color: CustomTheme.lightTextColor,
//             fontWeight: FontWeight.normal,
//           ),
//         ),
//       ],
//     );
//   }
// }
