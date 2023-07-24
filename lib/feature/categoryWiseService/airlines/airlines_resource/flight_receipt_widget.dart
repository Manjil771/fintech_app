// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:paywell_wallet/common/cubits/data_state.dart';
// import 'package:paywell_wallet/common/enum/download_type_enums.dart';
// import 'package:paywell_wallet/common/icons/paywell_icons_icons.dart';
// import 'package:paywell_wallet/common/localization/paywell_localizations.dart';
// import 'package:paywell_wallet/common/model/utility_services.dart';
// import 'package:paywell_wallet/common/navigation/navigation_service.dart';
// import 'package:paywell_wallet/common/utils/size_utils.dart';
// import 'package:paywell_wallet/common/utils/snackbar.dart';
// import 'package:paywell_wallet/common/utils/wallet_config_service.dart';
// import 'package:paywell_wallet/common/widgets/buttons/custom_rounded_button.dart';
// import 'package:paywell_wallet/common/widgets/controllers/amount_summary_controller.dart';
// import 'package:paywell_wallet/common/widgets/dialog/loading_dialog.dart';
// import 'package:paywell_wallet/common/widgets/page_wrapper.dart';
// import 'package:paywell_wallet/features/flights/cubits/flight_ticket_download_cubit.dart';
// import 'package:paywell_wallet/features/flights/models/flights.dart';
// import 'package:paywell_wallet/features/flights/ui/widgets/flight_details_card.dart';

// class FlightsReceiptWidget extends StatefulWidget {
//   const FlightsReceiptWidget({
//     Key? key,
//     required this.outBoundFlight,
//     required this.passengerAndContactInfo,
//     required this.bookingID,
//     required this.validityTime,
//     this.inboundFlight,
//     required this.services,
//     required this.ids,
//   }) : super(key: key);
//   final Flight outBoundFlight;
//   final Flight? inboundFlight;
//   final String bookingID;
//   final UtilityServices services;
//   final List<String> ids;

//   final DateTime validityTime;
//   final Map passengerAndContactInfo;

//   @override
//   State<FlightsReceiptWidget> createState() => _FlightsReceiptWidgetState();
// }

// class _FlightsReceiptWidgetState extends State<FlightsReceiptWidget> {
//   final AmountSummaryController _amountSummaryController =
//       AmountSummaryController(showAmountTextField: false);
//   ValueNotifier<String> _promoCode = ValueNotifier("");

//   final TextEditingController _amountController = TextEditingController();

//   String remainingTime = "";

//   @override
//   void initState() {
//     super.initState();

//     double _amount = 0;
//     _amount += widget.outBoundFlight.fareTotal;

//     if (widget.inboundFlight != null) {
//       _amount += widget.inboundFlight!.fareTotal;
//     }
//     _amountController.value = TextEditingValue(text: _amount.toString());
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   bool _isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;
//     return PageWrapper(
//       padding: EdgeInsets.zero,
//       title: "Ticket Details",
//       onBackPressed: () {
//         NavigationService.popUntilFirstPage();
//       },
//       body: BlocListener<FlightsTicketCubit, WalletCommonState>(
//         listener: (context, state) {
//           if (state is WalletCommonLoading && _isLoading == false) {
//             _isLoading = true;
//             showLoadingDialogBox(context);
//           } else if (state is! WalletCommonLoading && _isLoading) {
//             _isLoading = false;
//             Navigator.pop(context);
//           }
//           if (state is WalletCommonStateSuccess<bool>) {
//             if (state.data) {
//               SnackBarUtils.showSuccessBar(
//                   context: context,
//                   message:
//                       "Flight ticket successfully downloaded. Please save the opened file.");
//             }
//           } else if (state is WalletCommonError) {
//             SnackBarUtils.showErrorBar(
//                 context: context, message: state.message);
//           }
//         },
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.hp),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 15.hp,
//                 ),
//                 InkWell(
//                   borderRadius: BorderRadius.circular(10),
//                   onTap: () {
//                     WalletConfigServices.config
//                         .onDownload(widget.bookingID, DownloadType.Flight);
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(10.hp),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.hp),
//                         border: Border.all(
//                           color: _theme.primaryColor,
//                         )),
//                     child: Column(
//                       children: [
//                         Icon(
//                           PaywellIcons.download,
//                           color: _theme.primaryColor,
//                           size: 20,
//                         ),
//                         Text(
//                           "Download Ticket",
//                           style: TextStyle(
//                             color: _theme.primaryColor,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15.hp,
//                 ),
//                 FlightDetailsCard(
//                   flightDetails: widget.outBoundFlight,
//                   title: context.loc.flight.departureFlight,
//                   showFooter: false,
//                 ),
//                 if (widget.inboundFlight != null)
//                   SizedBox(
//                     height: 30.hp,
//                   ),
//                 if (widget.inboundFlight != null)
//                   FlightDetailsCard(
//                     flightDetails: widget.inboundFlight!,
//                     title: context.loc.flight.returnFlight,
//                     showFooter: false,
//                   ),
//                 SizedBox(
//                   height: 20.hp,
//                 ),
//                 SizedBox(
//                   height: 10.hp,
//                 ),
//                 CustomRoundedButtom(
//                   title: context.loc.done,
//                   onPressed: () {
//                     NavigationService.popUntilFirstPage();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
