// import 'package:flutter/material.dart';
// import 'package:paywell_wallet/common/utils/size_utils.dart';
// import 'package:paywell_wallet/common/widgets/buttons/increment_button.dart';

// class IncrementalListTile extends StatelessWidget {
//   final String title;
//   final String subTitle;
//   final int initialValue;
//   final ValueChanged<int> onChanged;
//   final ValueNotifier<int> valueNotifier;

//   const IncrementalListTile({
//     Key? key,
//     required this.title,
//     required this.subTitle,
//     required this.initialValue,
//     required this.onChanged,
//     required this.valueNotifier,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;
//     return Container(
//       child: Row(
//         children: [
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 10.hp),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: _textTheme.headline6!.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(subTitle),
//                 ],
//               ),
//             ),
//           ),
//           IncrementButton(
//             initialValue: initialValue,
//             onChanged: onChanged,
//           )
//         ],
//       ),
//     );
//   }
// }
