// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:paywell_wallet/app/theme.dart';
// import 'package:paywell_wallet/common/constants/slugs.dart';
// import 'package:paywell_wallet/common/cubits/data_state.dart';
// import 'package:paywell_wallet/common/cubits/use_service_cubit.dart';
// import 'package:paywell_wallet/common/localization/paywell_localizations.dart';
// import 'package:paywell_wallet/common/model/utility_services.dart';
// import 'package:paywell_wallet/common/navigation/navigation_service.dart';
// import 'package:paywell_wallet/common/utils/custom_toast.dart';
// import 'package:paywell_wallet/common/utils/form_validator.dart';
// import 'package:paywell_wallet/common/utils/size_utils.dart';
// import 'package:paywell_wallet/common/utils/text_utils.dart';
// import 'package:paywell_wallet/common/widgets/buttons/custom_rounded_button.dart';
// import 'package:paywell_wallet/common/widgets/dialog/loading_dialog.dart';
// import 'package:paywell_wallet/common/widgets/dialog/wallet_error_dialog.dart';
// import 'package:paywell_wallet/common/widgets/page_wrapper.dart';
// import 'package:paywell_wallet/common/widgets/text_field/custom_text_field.dart';
// import 'package:paywell_wallet/features/flights/models/add_info_pending_flights_response.dart';
// import 'package:paywell_wallet/features/flights/models/flights.dart';
// import 'package:paywell_wallet/features/flights/models/passenger_info.dart';
// import 'package:paywell_wallet/features/flights/ui/screens/booked_flight_details_page.dart';
// import 'package:paywell_wallet/features/flights/ui/widgets/individual_passenger_details_form_widget.dart';

// class PassengerDetailsFormWidget extends StatefulWidget {
//   const PassengerDetailsFormWidget({
//     Key? key,
//     required this.outboundFlight,
//     this.inboundFlight,
//     this.passengerInfo,
//     required this.bookingId,
//     required this.validityTime,
//     required this.services,
//   }) : super(key: key);

//   final Flight outboundFlight;
//   final Flight? inboundFlight;
//   final String bookingId;
//   final DateTime validityTime;
//   final UtilityServices services;

//   final PendingFlightsAddInfoResponse? passengerInfo;
//   @override
//   State<PassengerDetailsFormWidget> createState() =>
//       _PassengerDetailsFormWidgetState();
// }

// class _PassengerDetailsFormWidgetState
//     extends State<PassengerDetailsFormWidget> {
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   TextEditingController _contactNameController = TextEditingController();
//   TextEditingController _contactNumberController = TextEditingController();

//   List<ValueNotifier<PassengerInfo>> listOfAdultPassengerDetails = [];
//   List<ValueNotifier<PassengerInfo>> listOfChildPassengerDetails = [];

//   String remainingTime = "";

//   Timer? _timer;

//   bool _isButtonEnabled = true;

//   @override
//   void dispose() {
//     _timer!.cancel();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();

//     startTimer();
//     if (widget.passengerInfo != null) {
//       _contactNameController.text = widget.passengerInfo!.contactName;
//       _contactNumberController.text = widget.passengerInfo!.contactPhone;

//       widget.passengerInfo!.passengers.forEach((element) {
//         if (element.type == "ADULT") {
//           listOfAdultPassengerDetails.add(ValueNotifier(PassengerInfo(
//             title: element.title,
//             country: element.nationality,
//             name: element.firstname + element.lastname,
//             type: element.type,
//           )));
//         } else {
//           listOfChildPassengerDetails.add(ValueNotifier(PassengerInfo(
//             title: element.title,
//             country: element.nationality,
//             name: element.firstname + element.lastname,
//             type: element.type,
//           )));
//         }
//       });
//     } else {
//       if (widget.outboundFlight.adult > 0) {
//         listOfAdultPassengerDetails = List.generate(
//           widget.outboundFlight.adult,
//           (index) => ValueNotifier(
//             PassengerInfo(
//               title: "MR",
//               country: "Nepal",
//               name: "",
//               type: "ADULT",
//             ),
//           ),
//         );
//       }

//       if (widget.outboundFlight.child > 0) {
//         listOfChildPassengerDetails = List.generate(
//           widget.outboundFlight.child,
//           (index) => ValueNotifier(
//             PassengerInfo(
//               title: "MR",
//               country: "Nepal",
//               name: "",
//               type: "CHILD",
//             ),
//           ),
//         );
//       }
//     }
//   }

//   startTimer() {
//     _timer = Timer.periodic(
//       Duration(seconds: 1),
//       (timer) {
//         DateTime _now = DateTime.now().toUtc();
//         Duration _differentDuration =
//             widget.validityTime.toUtc().difference(_now);

//         if (_differentDuration.isNegative) {
//           _timer!.cancel();
//         }
//         remainingTime = " ${_differentDuration.inSeconds} sec";

//         if (_differentDuration.inSeconds <= 0) {
//           _isButtonEnabled = false;
//           showWalletErrorDialogBox(
//             context: context,
//             message: context.loc.flight.flightBookingTimeIsOver,
//             errorCode: "",
//           );
//         }
//         setState(() {});
//       },
//     );
//   }

//   Map<String, dynamic> _bookingData = {};
//   List<Map<String, dynamic>> _passengerData = [];

//   bool _isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;

//     return PageWrapper(
//       padding: EdgeInsets.zero,
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(),
//           SliverPadding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: CustomTheme.symmetricHozPadding),
//             sliver: SliverToBoxAdapter(
//               child: BlocListener<UseServiceCubit, WalletCommonState>(
//                 listener: (context, state) {
//                   if (state is WalletCommonLoading && _isLoading == false) {
//                     showLoadingDialogBox(context);
//                     _isLoading = true;
//                   } else if (state is! WalletCommonLoading &&
//                       _isLoading == true) {
//                     Navigator.pop(context);
//                     _isLoading = false;
//                   }
//                   if (state is WalletCommonStateSuccess) {
//                     NavigationService.pushReplacement(
//                       target: BookedFlightDetailsPage(
//                         inboundFlightDetails: widget.inboundFlight,
//                         outboundFlightDetails: widget.outboundFlight,
//                         passengerAndContactInfo: _bookingData,
//                         bookingId: widget.bookingId,
//                         validityTime: widget.validityTime,
//                         services: widget.services,
//                       ),
//                     );
//                   }
//                 },
//                 child: Container(),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: CustomTheme.symmetricHozPadding),
//               child: Text(
//                 context.loc.flight.passengerInformation,
//                 style: _textTheme.displayLarge!.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           SliverPadding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: CustomTheme.symmetricHozPadding),
//             sliver: SliverToBoxAdapter(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ...List.generate(
//                       listOfAdultPassengerDetails.length,
//                       (index) {
//                         return IndividualPassengerDetailsFormWidget(
//                           index: index + 1,
//                           passengerType: context.loc.flight.adults,
//                           passengerInfo: listOfAdultPassengerDetails[index],
//                         );
//                       },
//                     ),
//                     ...List.generate(
//                       listOfChildPassengerDetails.length,
//                       (index) {
//                         return IndividualPassengerDetailsFormWidget(
//                           index: index + 1,
//                           passengerType: context.loc.flight.child,
//                           passengerInfo: listOfChildPassengerDetails[index],
//                         );
//                       },
//                     ),
//                     SizedBox(
//                       height: 20.hp,
//                     ),
//                     Text(
//                       context.loc.flight.contactDetails,
//                       style: _textTheme.displayLarge,
//                     ),
//                     SizedBox(
//                       height: 10.hp,
//                     ),
//                     CustomTextField(
//                       title: context.loc.flight.contactName,
//                       controller: _contactNameController,
//                       validator: (val) => FormValidator.validateFieldNotEmpty(
//                         val,
//                         context.loc.flight.contactName,
//                       ),
//                       inputFormatters: TextUtils.textOnlyFormater,
//                     ),
//                     CustomTextField(
//                       title: context.loc.flight.contactNumber,
//                       controller: _contactNumberController,
//                       textInputType: TextInputType.phone,
//                       validator: (val) => FormValidator.validateFieldNotEmpty(
//                         val,
//                         context.loc.flight.contactNumber,
//                       ),
//                       inputFormatters: TextUtils.numberOnlyFormater,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(child: SizedBox(height: 20.hp)),
//           SliverFillRemaining(
//             hasScrollBody: false,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 CustomRoundedButtom(
//                   isDisabled: !_isButtonEnabled,
//                   horizontalMargin: CustomTheme.symmetricHozPadding,
//                   onPressed: () {
//                     if (!_isButtonEnabled) {
//                       CustomToast.error(
//                           message: context.loc.flight.flightBookingTimeIsOver);
//                       return;
//                     }
//                     if (_formKey.currentState!.validate()) {
//                       _passengerData.clear();
//                       listOfAdultPassengerDetails.forEach(
//                         (element) {
//                           _passengerData.add(element.value.toJson());
//                         },
//                       );
//                       listOfChildPassengerDetails.forEach(
//                         (element) {
//                           _passengerData.add(element.value.toJson());
//                         },
//                       );
//                       _bookingData['wallet_service'] = "FLIGHT_ADD_INFO";
//                       _bookingData['contact_name'] =
//                           _contactNameController.text.trim();
//                       _bookingData['contact_phone'] =
//                           _contactNumberController.text;
//                       _bookingData['passengers'] = _passengerData;
//                       _bookingData['booking_id'] = widget.bookingId;

//                       context.read<UseServiceCubit>().fetchDetails(
//                             slug: Slugs.flights,
//                             body: _bookingData,
//                           );
//                     }
//                   },
//                   title: "Continue Booking " +
//                       (remainingTime.isNotEmpty ? "($remainingTime)" : ""),
//                 ),
//                 SizedBox(
//                     height: MediaQuery.of(context).viewPadding.bottom > 0
//                         ? MediaQuery.of(context).viewPadding.bottom + 10.hp
//                         : 20.hp),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
