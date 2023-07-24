// import 'package:flutter/material.dart';
// import 'package:paywell_wallet/app/theme.dart';
// import 'package:paywell_wallet/common/utils/size_utils.dart';

// class FlightsFilterWidget extends StatelessWidget {
//   const FlightsFilterWidget({
//     Key? key,
//     required this.isFilterApplied,
//     required this.filterTitle,
//     required this.filterIcon,
//     required this.onClickFilterCallback,
//   }) : super(key: key);
//   final bool isFilterApplied;
//   final String filterTitle;
//   final IconData filterIcon;

//   final Function() onClickFilterCallback;
//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;

//     return Container(
//       decoration: BoxDecoration(
//         color: isFilterApplied ? _theme.primaryColor : CustomTheme.midGrayColor,
//         borderRadius: BorderRadius.circular(10.hp),
//       ),
//       padding: EdgeInsets.symmetric(vertical: 5.hp, horizontal: 10.hp),
//       child: InkWell(
//         onTap: onClickFilterCallback,
//         child: Row(
//           children: [
//             Text(
//               "$filterTitle",
//               style: _textTheme.subtitle2!.copyWith(
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(
//               width: 5.hp,
//             ),
//             Icon(
//               filterIcon,
//               color: Colors.white,
//               size: 15.hp,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
