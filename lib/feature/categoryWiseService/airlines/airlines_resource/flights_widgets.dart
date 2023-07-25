// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jiffy/jiffy.dart';
// import 'package:paywell_wallet/app/theme.dart';
// import 'package:paywell_wallet/common/constants/slugs.dart';
// import 'package:paywell_wallet/common/cubits/data_state.dart';
// import 'package:paywell_wallet/common/cubits/service_details_cubit.dart';
// import 'package:paywell_wallet/common/cubits/use_service_cubit.dart';
// import 'package:paywell_wallet/common/icons/paywell_icons_icons.dart';
// import 'package:paywell_wallet/common/localization/paywell_localizations.dart';
// import 'package:paywell_wallet/common/model/key_value.dart';
// import 'package:paywell_wallet/common/model/service_info.dart';
// import 'package:paywell_wallet/common/model/use_service_response.dart';
// import 'package:paywell_wallet/common/model/utility_services.dart';
// import 'package:paywell_wallet/common/navigation/navigation_service.dart';
// import 'package:paywell_wallet/common/utils/form_validator.dart';
// import 'package:paywell_wallet/common/utils/shared_pref_utils.dart';
// import 'package:paywell_wallet/common/utils/size_utils.dart';
// import 'package:paywell_wallet/common/widgets/buttons/custom_rounded_button.dart';
// import 'package:paywell_wallet/common/widgets/cards/service_title_description.dart';
// import 'package:paywell_wallet/common/widgets/common_error_widget.dart';
// import 'package:paywell_wallet/common/widgets/common_navigation_bar.dart';
// import 'package:paywell_wallet/common/widgets/date_picker/date_picker_bottom_sheet.dart';
// import 'package:paywell_wallet/common/widgets/dialog/loading_dialog.dart';
// import 'package:paywell_wallet/common/widgets/dialog/wallet_error_dialog.dart';
// import 'package:paywell_wallet/common/widgets/loading/common_loading.dart';
// import 'package:paywell_wallet/common/widgets/maintenance_widget.dart';
// import 'package:paywell_wallet/common/widgets/page_wrapper.dart';
// import 'package:paywell_wallet/common/widgets/service_label.dart';
// import 'package:paywell_wallet/common/widgets/text_field/custom_text_field.dart';
// import 'package:paywell_wallet/features/flights/cubits/flight_ticket_download_cubit.dart';
// import 'package:paywell_wallet/features/flights/models/flights.dart';
// import 'package:paywell_wallet/features/flights/models/recent_search.dart';
// import 'package:paywell_wallet/features/flights/ui/screens/available_flights_list_page.dart';
// import 'package:paywell_wallet/features/flights/ui/screens/flights_sectors_search_page.dart';
// import 'package:paywell_wallet/features/flights/ui/widgets/flight_text_field.dart';
// import 'package:paywell_wallet/features/flights/ui/widgets/traveller_info_bottomsheet.dart';

// class FlightsWidgets extends StatefulWidget {
//   final ServiceInfo serviceInfo;
//   const FlightsWidgets({Key? key, required this.serviceInfo}) : super(key: key);

//   @override
//   State<FlightsWidgets> createState() => _FlightsWidgetsState();
// }

// class _FlightsWidgetsState extends State<FlightsWidgets> {
//   TextEditingController _passengerCountController =
//       TextEditingController(text: "1 Adult, 0 Children");
//   TextEditingController _flightToController = TextEditingController();
//   TextEditingController _flightFromController = TextEditingController();
//   TextEditingController _departureDateOneWay = TextEditingController();
//   TextEditingController _returnDate = TextEditingController();

//   ValueNotifier<int> flightTypeIndex = ValueNotifier(0);
//   ValueNotifier<int> _adultCountNotifier = ValueNotifier(1);
//   ValueNotifier<int> _childrenCountNotifier = ValueNotifier(0);
//   ValueNotifier<KeyValue?> _fromSectorNotifier = ValueNotifier(null);
//   ValueNotifier<KeyValue?> _toSectorNotifier = ValueNotifier(null);

//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   bool _showReturnDate = false;

//   UtilityServices? _flightsServices;

//   @override
//   void initState() {
//     super.initState();
//     context
//         .read<ServiceDetailsCubit>()
//         .fetchServiceDetails(slug: Slugs.flights);

//     flightTypeIndex.addListener(() {
//       if (flightTypeIndex.value == 1) {
//         _updateShowReturnDate(true);
//       } else {
//         _updateShowReturnDate(false);
//       }
//     });

//     _adultCountNotifier.addListener(
//       () {
//         if (_adultCountNotifier.value != 0) {
//           _passengerCountController.value = TextEditingValue(
//             text:
//                 "${_adultCountNotifier.value} ${context.loc.flight.adults}, ${_childrenCountNotifier.value} ${context.loc.flight.children}",
//           );
//         }

//         setState(() {});
//       },
//     );
//     _childrenCountNotifier.addListener(
//       () {
//         _passengerCountController.value = TextEditingValue(
//           text:
//               "${_adultCountNotifier.value} ${context.loc.flight.adults}, ${_childrenCountNotifier.value} ${context.loc.flight.children}",
//         );

//         setState(() {});
//       },
//     );
//   }

//   _updateShowReturnDate(bool status) {
//     setState(() {
//       _showReturnDate = status;
//     });
//   }

//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     final _width = SizeUtils.width;
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;
//     return PageWrapper(
//       title: context.loc.flight.flight,
//       padding: EdgeInsets.zero,
//       body: BlocListener<UseServiceCubit, WalletCommonState>(
//         listener: (context, state) {
//           if (state is WalletCommonLoading && _isLoading == false) {
//             showLoadingDialogBox(context);
//             _isLoading = true;
//           } else if (state is! WalletCommonLoading && _isLoading == true) {
//             Navigator.pop(context);
//             _isLoading = false;
//           }
//           if (state is WalletCommonStateSuccess<UseServiceResponse>) {
//             FocusScope.of(context).unfocus();

//             List _rawOutboundList =
//                 state.data.findValue(name: "outbound") as List;
//             List _rawInboundList =
//                 state.data.findValue(name: "inbound") as List;

//             List<Flight> _outboundFlights = [];
//             List<Flight> _inboundFlights = [];
//             if (_rawOutboundList.isNotEmpty) {
//               _outboundFlights = _rawOutboundList.map((e) {
//                 return Flight.fromJson(e);
//               }).toList();
//               if (_rawInboundList.isNotEmpty) {
//                 _inboundFlights = _rawInboundList.map((e) {
//                   return Flight.fromJson(e);
//                 }).toList();
//               }
//               print(_outboundFlights);
//               if (_flightsServices != null) {
//                 NavigationService.push(
//                   target: AvailableFlightsListPage(
//                     useServiceResponse: state.data,
//                     isTwoWay: flightTypeIndex.value == 1,
//                     fromSector: _fromSectorNotifier.value!,
//                     toSector: _toSectorNotifier.value!,
//                     services: _flightsServices!,
//                     inboundFlights: _inboundFlights,
//                     outboundFlights: _outboundFlights,
//                     serviceInfo: _flightsServices!,
//                   ),
//                 );
//               }
//             } else {
//               showWalletErrorDialogBox(
//                 context: context,
//                 message: context.loc.flight.noFlightFound,
//                 errorCode: "",
//               );
//             }
//           } else if (state is WalletCommonError) {
//             showWalletErrorDialogBox(
//               context: context,
//               message: state.message,
//               errorCode: state.statusCode?.toString() ?? "",
//             );
//           }
//         },
//         child: BlocConsumer<ServiceDetailsCubit, WalletCommonState>(
//           listener: (context, state) {
//             if (state is WalletCommonStateSuccess<UtilityServices>) {
//               _flightsServices = state.data;
//             }
//           },
//           buildWhen: (context, state) {
//             if (state is WalletCommonDummyLoading) {
//               return false;
//             } else {
//               return true;
//             }
//           },
//           builder: (context, state) {
//             if (state is WalletCommonError) {
//               if (state.isNoConnection) {
//                 return WalletCommonErrorWidget(
//                   message: state.message,
//                   isNoConnection: state.isNoConnection,
//                   horizontalPadding: CustomTheme.symmetricHozPadding,
//                   onReloadPressed: () {
//                     context
//                         .read<ServiceDetailsCubit>()
//                         .fetchServiceDetails(slug: Slugs.flights);
//                   },
//                 );
//               } else {
//                 return WalletMaintenanceWidget();
//               }
//             } else if (state is WalletCommonLoading) {
//               return WalletCommonLoadingWidget();
//             } else if (state is WalletCommonStateSuccess<UtilityServices>) {
//               return SingleChildScrollView(
//                 child: Container(
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ServiceLabel(label: widget.serviceInfo.notes),
//                         ServiceTitleDescription(
//                           title: context.loc.flight.flight,
//                           description: context.loc.flight.flightDesc,
//                         ),
//                         CommonNavigationBar(
//                           selectedIndex: flightTypeIndex,
//                           borderRadius: 100,
//                           margin: EdgeInsets.only(
//                             left: CustomTheme.symmetricHozPadding,
//                             right: CustomTheme.symmetricHozPadding,
//                             bottom: 20.hp,
//                           ),
//                           items: [
//                             context.loc.flight.oneWay,
//                             context.loc.flight.twoWay,
//                           ],
//                         ),
//                         ValueListenableBuilder<KeyValue?>(
//                             valueListenable: _fromSectorNotifier,
//                             builder: (context, val, _) {
//                               return FlightTextField(
//                                 title: context.loc.from,
//                                 hintText: context.loc.from,
//                                 prefixIcon: PaywellIcons.take_off,
//                                 suffixIcon: PaywellIcons.location,
//                                 controller: _flightFromController,
//                                 validator: (val) =>
//                                     FormValidator.validateFieldNotEmpty(
//                                   val,
//                                   "${context.loc.from}",
//                                 ),
//                                 readOnly: true,
//                                 onTap: () {
//                                   NavigationService.push(
//                                     target: FlightsSearchPage(
//                                       selectedValue: _toSectorNotifier.value,
//                                       onChanged: (val) {
//                                         _fromSectorNotifier.value = val;
//                                         _flightFromController.value =
//                                             TextEditingValue(
//                                           text:
//                                               _fromSectorNotifier.value!.title,
//                                         );

//                                         setState(() {});
//                                         print(val);
//                                       },
//                                       onRecentSearchClick: (recentSearch) {
//                                         _fromSectorNotifier.value =
//                                             recentSearch.from;
//                                         _flightFromController.value =
//                                             TextEditingValue(
//                                           text:
//                                               _fromSectorNotifier.value!.title,
//                                         );

//                                         _toSectorNotifier.value =
//                                             recentSearch.to;
//                                         _flightToController.value =
//                                             TextEditingValue(
//                                                 text: _toSectorNotifier
//                                                     .value!.title);
//                                         setState(() {});
//                                       },
//                                     ),
//                                   );
//                                 },
//                                 margin: EdgeInsets.only(
//                                   left: CustomTheme.symmetricHozPadding,
//                                   right: CustomTheme.symmetricHozPadding,
//                                   bottom: 20.hp,
//                                 ),
//                               );
//                             }),
//                         ValueListenableBuilder<KeyValue?>(
//                             valueListenable: _toSectorNotifier,
//                             builder: (context, val, _) {
//                               return FlightTextField(
//                                 title: context.loc.to,
//                                 hintText: context.loc.to,
//                                 controller: _flightToController,
//                                 prefixIcon: PaywellIcons.land,
//                                 suffixIcon: PaywellIcons.location,
//                                 readOnly: true,
//                                 validator: (val) =>
//                                     FormValidator.validateFieldNotEmpty(
//                                   val,
//                                   "${context.loc.to}",
//                                 ),
//                                 onTap: () {
//                                   NavigationService.push(
//                                     target: FlightsSearchPage(
//                                       selectedValue: _fromSectorNotifier.value,
//                                       onChanged: (val) {
//                                         _toSectorNotifier.value = val;
//                                         _flightToController.value =
//                                             TextEditingValue(
//                                           text: _toSectorNotifier.value!.title,
//                                         );

//                                         setState(() {});
//                                         print(val);
//                                       },
//                                       onRecentSearchClick: (recentSearch) {
//                                         _fromSectorNotifier.value =
//                                             recentSearch.from;
//                                         _flightFromController.value =
//                                             TextEditingValue(
//                                           text:
//                                               _fromSectorNotifier.value!.title,
//                                         );

//                                         _toSectorNotifier.value =
//                                             recentSearch.to;
//                                         _flightToController.value =
//                                             TextEditingValue(
//                                                 text: _toSectorNotifier
//                                                     .value!.title);
//                                         setState(() {});
//                                       },
//                                     ),
//                                   );
//                                 },
//                                 margin: EdgeInsets.only(
//                                   left: CustomTheme.symmetricHozPadding,
//                                   right: CustomTheme.symmetricHozPadding,
//                                   bottom: 20.hp,
//                                 ),
//                               );
//                             }),
//                         AnimatedSwitcher(
//                           duration: Duration(milliseconds: 250),
//                           reverseDuration: Duration(milliseconds: 250),
//                           switchInCurve: Curves.linear,
//                           switchOutCurve: Curves.linear,
//                           transitionBuilder: (child, animation) {
//                             final offsetAnimation = Tween(
//                               begin: const Offset(0.5, 0.0),
//                               end: const Offset(0.0, 0.0),
//                             ).animate(animation);
//                             return SlideTransition(
//                               position: offsetAnimation,
//                               child: FadeTransition(
//                                 opacity: animation,
//                                 child: child,
//                               ),
//                             );
//                           },
//                           child: _showReturnDate
//                               ? Row(
//                                   children: [
//                                     Expanded(
//                                       child: CustomTextField(
//                                         title: context.loc.flight.departureDate,
//                                         hintText:
//                                             context.loc.inputField.selectDate,
//                                         showSearchIcon: true,
//                                         suffixIcon: PaywellIcons.calendar,
//                                         readOnly: true,
//                                         controller: _departureDateOneWay,
//                                         validator: (val) =>
//                                             FormValidator.validateFieldNotEmpty(
//                                           val,
//                                           "${context.loc.flight.departureDate}",
//                                         ),
//                                         onTap: () {
//                                           showDatePickerBottomSheet(
//                                             title: context
//                                                 .loc.flight.departureDate,
//                                             context: context,
//                                             onChanged: (val) {
//                                               _departureDateOneWay.text =
//                                                   Jiffy(val.dateInAD).format(
//                                                 'yyyy-MM-dd',
//                                               );
//                                             },
//                                             currentDate: DateTime.now(),
//                                             minDate: DateTime.now(),
//                                           );
//                                         },
//                                         margin: EdgeInsets.only(
//                                           left: CustomTheme.symmetricHozPadding,
//                                           right:
//                                               CustomTheme.symmetricHozPadding /
//                                                   2,
//                                           bottom: 20.hp,
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: CustomTextField(
//                                         title: context.loc.flight.returnDate,
//                                         hintText:
//                                             context.loc.inputField.selectDate,
//                                         showSearchIcon: true,
//                                         suffixIcon: PaywellIcons.calendar,
//                                         readOnly: true,
//                                         validator: (val) =>
//                                             FormValidator.validateFieldNotEmpty(
//                                           val,
//                                           "${context.loc.flight.returnDate}",
//                                         ),
//                                         controller: _returnDate,
//                                         onTap: () {
//                                           showDatePickerBottomSheet(
//                                             title:
//                                                 context.loc.flight.returnDate,
//                                             context: context,
//                                             onChanged: (val) {
//                                               _returnDate.text =
//                                                   Jiffy(val.dateInAD).format(
//                                                 'yyyy-MM-dd',
//                                               );
//                                             },
//                                             currentDate: DateTime.now(),
//                                             minDate: DateTime.now(),
//                                           );
//                                         },
//                                         margin: EdgeInsets.only(
//                                           left:
//                                               CustomTheme.symmetricHozPadding /
//                                                   2,
//                                           right:
//                                               CustomTheme.symmetricHozPadding,
//                                           bottom: 20.hp,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               : CustomTextField(
//                                   title: context.loc.flight.departureDate,
//                                   hintText: context.loc.inputField.selectDate,
//                                   showSearchIcon: true,
//                                   suffixIcon: PaywellIcons.calendar,
//                                   readOnly: true,
//                                   validator: (val) =>
//                                       FormValidator.validateFieldNotEmpty(
//                                     val,
//                                     "${context.loc.flight.departureDate}",
//                                   ),
//                                   controller: _departureDateOneWay,
//                                   onTap: () {
//                                     showDatePickerBottomSheet(
//                                       title: context.loc.flight.departureDate,
//                                       context: context,
//                                       onChanged: (val) {
//                                         _departureDateOneWay.text =
//                                             Jiffy(val.dateInAD).format(
//                                           'yyyy-MM-dd',
//                                         );
//                                         setState(() {});
//                                       },
//                                       currentDate: DateTime.now(),
//                                       minDate: DateTime.now(),
//                                     );
//                                   },
//                                   margin: EdgeInsets.only(
//                                     left: CustomTheme.symmetricHozPadding,
//                                     right: CustomTheme.symmetricHozPadding / 2,
//                                     bottom: 20.hp,
//                                   ),
//                                 ),
//                         ),
//                         CustomTextField(
//                           title: context.loc.flight.traveller,
//                           hintText: context.loc.flight.selectNumberOfTraveller,
//                           showSearchIcon: true,
//                           suffixIcon: PaywellIcons.down,
//                           readOnly: true,
//                           controller: _passengerCountController,
//                           validator: (val) {
//                             if (_adultCountNotifier.value == 0) {
//                               return "${context.loc.flight.adultCountCannotBeZero}";
//                             }
//                             return null;
//                           },
//                           onTap: () {
//                             showTravellerInfoBottomSheet(
//                               context,
//                               _childrenCountNotifier,
//                               _adultCountNotifier,
//                             );
//                           },
//                           margin: EdgeInsets.only(
//                             left: CustomTheme.symmetricHozPadding,
//                             right: CustomTheme.symmetricHozPadding,
//                             bottom: 20.hp,
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 15.hp),
//                           child: Column(
//                             children: [
//                               CustomRoundedButtom(
//                                 title: context.loc.flight.searchFlight,
//                                 onPressed: () {
//                                   if (_formKey.currentState!.validate()) {
//                                     if (_adultCountNotifier.value != 0) {
//                                       Map<String, dynamic> body = {
//                                         "wallet_service": "FLIGHT_SEARCH",
//                                         "from":
//                                             _fromSectorNotifier.value!.value,
//                                         "to": _toSectorNotifier.value!.value,
//                                         "adult": _adultCountNotifier.value,
//                                         "nationality": "NP",
//                                         "trip_type": flightTypeIndex.value == 0
//                                             ? "O"
//                                             : "R",
//                                         "flight_date": _departureDateOneWay.text
//                                             .toString(),
//                                         "flight_type": "D",
//                                       };

//                                       if (flightTypeIndex.value == 1) {
//                                         body['return_date'] =
//                                             _returnDate.text.toString();
//                                       }

//                                       if (_childrenCountNotifier.value > 0) {
//                                         body['child'] =
//                                             _childrenCountNotifier.value;
//                                       }
//                                       RecentSearch _recentSearch = RecentSearch(
//                                           from: _fromSectorNotifier.value!,
//                                           to: _toSectorNotifier.value!);
//                                       WalletSharedPref.setRecentSearched(
//                                           _recentSearch.toJson());
//                                       context
//                                           .read<UseServiceCubit>()
//                                           .fetchDetails(
//                                             slug: Slugs.flights,
//                                             body: body,
//                                           );
//                                     }
//                                   }
//                                 },
//                               ),
//                               SizedBox(
//                                 height: 15.hp,
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   context
//                                       .read<FlightsTicketCubit>()
//                                       .downloadFlightTicket(id: 83318261);
//                                   // if (_flightsServices != null) {
//                                   //   NavigationService.push(
//                                   //     target: PendingFlightsListScreens(
//                                   //       services: _flightsServices!,
//                                   //     ),
//                                   //   );
//                                   // }
//                                 },
//                                 child: Container(
//                                   width: _width,
//                                   decoration: BoxDecoration(
//                                     color: CustomTheme.lightGray,
//                                     borderRadius: BorderRadius.circular(15.hp),
//                                   ),
//                                   padding: EdgeInsets.all(15.hp),
//                                   child: Center(
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               context.loc.flight
//                                                   .yourPendingBookings,
//                                               style: _textTheme.titleLarge!
//                                                   .copyWith(
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                             SizedBox(height: 5.hp),
//                                             Text(
//                                               context.loc.flight
//                                                   .continuePreviousBookings,
//                                               style: _textTheme.titleLarge,
//                                             ),
//                                           ],
//                                         ),
//                                         Icon(Icons.arrow_right),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 15.hp),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             } else {
//               return Container();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
