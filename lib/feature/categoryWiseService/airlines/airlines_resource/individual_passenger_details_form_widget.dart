// import 'package:flutter/material.dart';
// import 'package:paywell_wallet/common/localization/paywell_localizations.dart';
// import 'package:paywell_wallet/common/utils/form_validator.dart';
// import 'package:paywell_wallet/common/utils/size_utils.dart';
// import 'package:paywell_wallet/common/utils/text_utils.dart';
// import 'package:paywell_wallet/common/widgets/bottomsheet/select_options_bottom_sheet.dart';
// import 'package:paywell_wallet/common/widgets/text_field/custom_text_field.dart';
// import 'package:paywell_wallet/features/flights/models/passenger_info.dart';

// class IndividualPassengerDetailsFormWidget extends StatefulWidget {
//   IndividualPassengerDetailsFormWidget({
//     Key? key,
//     required this.index,
//     required this.passengerType,
//     required this.passengerInfo,
//   }) : super(key: key);
//   final int index;
//   final String passengerType;
//   final ValueNotifier<PassengerInfo> passengerInfo;

//   @override
//   State<IndividualPassengerDetailsFormWidget> createState() =>
//       _IndividualPassengerDetailsFormWidgetState();
// }

// class _IndividualPassengerDetailsFormWidgetState
//     extends State<IndividualPassengerDetailsFormWidget> {
//   List<String> _titleOptions = [
//     "MR",
//     "MRS",
//     "MS",
//   ];

//   List<String> _countryOptions = [
//     "Nepal",
//     "India",
//   ];

//   ValueNotifier<int> selectedTitleIndex = ValueNotifier(0);

//   ValueNotifier<int> selectedCountryIndex = ValueNotifier(0);

//   String selectedCountry = "";
//   String selectedTitle = "";

//   TextEditingController _titleTextController = TextEditingController();
//   TextEditingController _countryTextController = TextEditingController();
//   TextEditingController _nameController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();

//     _nameController.text = widget.passengerInfo.value.name;
//     _titleTextController.value = TextEditingValue(
//       text: _titleOptions[0],
//     );
//     _countryTextController.value = TextEditingValue(
//       text: _countryOptions[0],
//     );
//     selectedCountryIndex.addListener(() {
//       _countryTextController.value = TextEditingValue(
//         text: _countryOptions[selectedCountryIndex.value],
//       );

//       widget.passengerInfo.value = widget.passengerInfo.value.copyWith(
//         newCountry: _countryOptions[selectedCountryIndex.value],
//       );
//       selectedCountry = _countryOptions[selectedCountryIndex.value];

//       setState(() {});
//     });

//     selectedTitleIndex.addListener(() {
//       _titleTextController.value = TextEditingValue(
//         text: _titleOptions[selectedTitleIndex.value],
//       );
//       selectedTitle = _titleOptions[selectedCountryIndex.value];

//       widget.passengerInfo.value = widget.passengerInfo.value.copyWith(
//         newTitle: _titleOptions[selectedTitleIndex.value],
//       );

//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: 20.hp,
//         ),
//         Text(
//           "${widget.passengerType} ${widget.index} Details",
//           style: _textTheme.headline6!.copyWith(
//             fontWeight: FontWeight.bold,
//             color: _theme.primaryColor,
//           ),
//         ),
//         SizedBox(
//           height: 10.hp,
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: CustomTextField(
//                 readOnly: true,
//                 title: context.loc.flight.title,
//                 hintText: selectedTitle,
//                 controller: _titleTextController,
//                 showSearchIcon: true,
//                 suffixIcon: Icons.arrow_drop_down,
//                 validator: (val) => FormValidator.validateFieldNotEmpty(
//                   val,
//                   context.loc.flight.title,
//                 ),
//                 onTap: () {
//                   selectOptionsBottomSheet(
//                     context,
//                     _titleOptions,
//                     selectedTitleIndex,
//                     context.loc.flight.title,
//                   );
//                 },
//               ),
//             ),
//             SizedBox(
//               width: 10.hp,
//             ),
//             Expanded(
//               child: CustomTextField(
//                 readOnly: true,
//                 hintText: selectedCountry,
//                 controller: _countryTextController,
//                 showSearchIcon: true,
//                 suffixIcon: Icons.arrow_drop_down,
//                 title: context.loc.flight.country,
//                 onTap: () {
//                   selectOptionsBottomSheet(
//                     context,
//                     _countryOptions,
//                     selectedCountryIndex,
//                     context.loc.flight.country,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 15.hp,
//         ),
//         CustomTextField(
//           readOnly: false,
//           controller: _nameController,
//           title: context.loc.flight.fullName,
//           validator: (val) => FormValidator.validateFirstNameAndLastName(
//             val,
//             context.loc.flight.fullName,
//           ),
//           inputFormatters: TextUtils.textOnlyFormater,
//           onChanged: (val) {
//             widget.passengerInfo.value =
//                 widget.passengerInfo.value.copyWith(newName: val);
//           },
//         ),
//       ],
//     );
//   }
// }
