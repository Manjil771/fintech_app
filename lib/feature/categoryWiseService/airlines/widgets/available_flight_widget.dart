import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_error_dialog.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/categoryWiseService/airlines/cubit/airlines_cubit.dart';
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_avliable_list.dart';
import 'package:ismart/feature/categoryWiseService/airlines/screen/passenger_detail_page.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class AvailableFlightWidget extends StatefulWidget {
  final ServiceList service;

  final AvailableFlightModel flightDetail;

  const AvailableFlightWidget(
      {Key? key,
      required this.adultCount,
      required this.childrenCount,
      required this.flightDetail,
      required this.service})
      : super(key: key);
  final adultCount;
  final childrenCount;

  @override
  State<AvailableFlightWidget> createState() => _AvailableFlightWidgetState();
}

class _AvailableFlightWidgetState extends State<AvailableFlightWidget> {
  Availability? selectedFlight;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: BlocListener<UtilityPaymentCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoading && _isLoading == false) {
            _isLoading = true;
            showLoadingDialogBox(context);
          } else if (state is! CommonLoading && _isLoading) {
            _isLoading = false;
            NavigationService.pop();
          } else if (state is CommonError) {
            showPopUpDialog(
              context: context,
              message: state.message,
              title: "Error",
              showCancelButton: false,
              buttonCallback: () {
                NavigationService.pop();
              },
            );
          }

          if (state is CommonStateSuccess<UtilityResponseData>) {
            UtilityResponseData _response = state.data;
            if (_response.code == "M0000" ||
                _response.status.toLowerCase() == "Success".toLowerCase()) {
              NavigationService.push(
                  target: PassengerDetailScreen(
                      service: widget.service,
                      adultCount: widget.adultCount,
                      childrenCount: widget.childrenCount,
                      selectedFlight: selectedFlight));
            } else {
              showPopUpDialog(
                  context: context,
                  message: _response.message,
                  title: "Error",
                  buttonCallback: () {
                    NavigationService.pop();
                  },
                  showCancelButton: false);
            }
          }
        },
        child: CommonContainer(
          showDetail: false,
          title: "Available Flights",
          showRoundBotton: false,
          topbarName: 'Book Flight',
          body: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: []),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.flightDetail.detail.flightAvailability
                    .outbound.availability.length,
                itemBuilder: (context, index) {
                  final flight = widget.flightDetail.detail.flightAvailability
                      .outbound.availability[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        color: CustomTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(18)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: CustomTheme.gray,
                                  borderRadius: BorderRadius.circular(16)),
                              child: CustomCachedNetworkImage(
                                  url:
                                      "${RepositoryProvider.of<CoOperative>(context).baseUrl}ismart/airlinesPdfUrl/${flight.airlineImage}",
                                  fit: BoxFit.cover),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    flight.airline,
                                    style: _textTheme.displaySmall!
                                        .copyWith(fontSize: 14),
                                  ),
                                  Text(
                                    flight.arrivalTime +
                                        " - " +
                                        flight.departureTime,
                                    style: _textTheme.titleLarge,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 5),
                            Column(
                              children: [
                                Text('Ticket Price',
                                    style: _textTheme.titleLarge),
                                Text(
                                  flight.totalFare.toString(),
                                  style: _textTheme.displaySmall!
                                      .copyWith(fontSize: 16),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  flight.refundable == "T"
                                      ? "Refundable"
                                      : 'Non Refundable',
                                  style: _textTheme.titleSmall!.copyWith(
                                    fontSize: 14,
                                    color: CustomTheme.darkGray,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  child: CustomRoundedButtom(
                                      horizontalPadding: 0,
                                      verticalPadding: 5,
                                      color: Colors.transparent,
                                      textColor: CustomTheme.primaryColor,
                                      borderColor: Colors.transparent,
                                      fontSize: 14,
                                      title: 'Fare Summary',
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Wrap(
                                              children: [
                                                Text("Fare Summary",
                                                    style: _textTheme
                                                        .headlineSmall),
                                                KeyValueTile(
                                                    title: "Flight Detail",
                                                    value: flight.airline +
                                                        flight.flightNo),
                                                KeyValueTile(
                                                    title: "Time",
                                                    value: flight.flightDate
                                                            .toString() +
                                                        flight.departureTime +
                                                        "" +
                                                        flight.arrivalTime),
                                                KeyValueTile(
                                                    title: "Flight Type",
                                                    value: flight.aircraftType),
                                                KeyValueTile(
                                                    title: "Adult Fare",
                                                    value: flight.adultFare),
                                                flight.child == "0"
                                                    ? Container()
                                                    : KeyValueTile(
                                                        title: "Child Fare",
                                                        value:
                                                            flight.childFare),
                                                flight.infant == "0"
                                                    ? Container()
                                                    : KeyValueTile(
                                                        title: "Infant Fare",
                                                        value:
                                                            flight.infantFare),
                                                KeyValueTile(
                                                    title: "Fuel Charge",
                                                    value:
                                                        flight.fuelSurcharge),
                                                KeyValueTile(
                                                  title: "Ticket Type",
                                                  value:
                                                      flight.refundable == "T"
                                                          ? "Refundable"
                                                          : "Non Refundable",
                                                ),
                                                KeyValueTile(
                                                    title: "Free Baggage",
                                                    value: flight.freeBaggage),
                                                KeyValueTile(
                                                    title: "Total Fare",
                                                    value: "NPR" +
                                                        flight.totalFare
                                                            .toString()),
                                              ],
                                            );
                                          },
                                        );

                                        // showGeneralDialog(
                                        //   context: context,
                                        //   pageBuilder: (context, animation,
                                        //       secondaryAnimation) {
                                        //     return WillPopScope(
                                        //       onWillPop: () =>
                                        //           Future.value(false),
                                        //       child: Dialog(
                                        //         shape: RoundedRectangleBorder(
                                        //           borderRadius:
                                        //               BorderRadius.circular(30),
                                        //         ),
                                        //         child: Container(
                                        //           padding: EdgeInsets.symmetric(
                                        //             vertical: 30.hp,
                                        //             horizontal: 15.hp,
                                        //           ),
                                        //           child: Column(
                                        //             mainAxisSize:
                                        //                 MainAxisSize.min,
                                        //             crossAxisAlignment:
                                        //                 CrossAxisAlignment.start,
                                        //             children: [
                                        //               Text("Fare Summary",
                                        //                   style: _textTheme
                                        //                       .displaySmall),
                                        //               const SizedBox(height: 14),
                                        //               Container(
                                        //                 decoration: BoxDecoration(
                                        //                   borderRadius:
                                        //                       BorderRadius
                                        //                           .circular(5),
                                        //                   border: Border.all(
                                        //                       color: CustomTheme
                                        //                           .gray),
                                        //                 ),
                                        //                 child: Column(
                                        //                   children: [
                                        //                     Row(
                                        //                       mainAxisAlignment:
                                        //                           MainAxisAlignment
                                        //                               .spaceBetween,
                                        //                       children: [
                                        //                         Padding(
                                        //                           padding:
                                        //                               const EdgeInsets
                                        //                                       .only(
                                        //                                   left:
                                        //                                       10,
                                        //                                   top: 10,
                                        //                                   bottom:
                                        //                                       10),
                                        //                           child: Column(
                                        //                             crossAxisAlignment:
                                        //                                 CrossAxisAlignment
                                        //                                     .start,
                                        //                             children: [
                                        //                               Text(
                                        //                                 'Description',
                                        //                                 style: _textTheme
                                        //                                     .titleLarge,
                                        //                               ),
                                        //                               SizedBox(
                                        //                                 height: 5,
                                        //                               ),
                                        //                               Text(
                                        //                                 'Adult Fare',
                                        //                                 style: _textTheme
                                        //                                     .titleLarge,
                                        //                               ),
                                        //                               SizedBox(
                                        //                                 height: 5,
                                        //                               ),
                                        //                               Text(
                                        //                                 'Fuel Charge',
                                        //                                 style: _textTheme
                                        //                                     .titleLarge,
                                        //                               ),
                                        //                               SizedBox(
                                        //                                 height: 5,
                                        //                               ),
                                        //                               Text(
                                        //                                 'Fee & Tax',
                                        //                                 style: _textTheme
                                        //                                     .titleLarge,
                                        //                               ),
                                        //                             ],
                                        //                           ),
                                        //                         ),
                                        //                         Padding(
                                        //                           padding: const EdgeInsets
                                        //                                   .symmetric(
                                        //                               horizontal:
                                        //                                   0,
                                        //                               vertical:
                                        //                                   10),
                                        //                           child: Column(
                                        //                             crossAxisAlignment:
                                        //                                 CrossAxisAlignment
                                        //                                     .start,
                                        //                             children: [
                                        //                               Text(
                                        //                                 'Individual Cost',
                                        //                                 style: _textTheme
                                        //                                     .titleLarge,
                                        //                               ),
                                        //                               SizedBox(
                                        //                                 height: 5,
                                        //                               ),
                                        //                               Text(
                                        //                                 '1600',
                                        //                                 style: _textTheme
                                        //                                     .titleLarge,
                                        //                               ),
                                        //                               SizedBox(
                                        //                                 height: 5,
                                        //                               ),
                                        //                               Text(
                                        //                                 '0.0',
                                        //                                 style: _textTheme
                                        //                                     .titleLarge,
                                        //                               ),
                                        //                               SizedBox(
                                        //                                 height: 5,
                                        //                               ),
                                        //                               Text(
                                        //                                 '0.0',
                                        //                                 style: _textTheme
                                        //                                     .titleLarge,
                                        //                               ),
                                        //                             ],
                                        //                           ),
                                        //                         ),
                                        //                         Padding(
                                        //                           padding:
                                        //                               const EdgeInsets
                                        //                                       .only(
                                        //                                   right:
                                        //                                       10,
                                        //                                   top: 10,
                                        //                                   bottom:
                                        //                                       10),
                                        //                           child: Column(
                                        //                             crossAxisAlignment:
                                        //                                 CrossAxisAlignment
                                        //                                     .start,
                                        //                             children: [
                                        //                               Text(
                                        //                                 'Total',
                                        //                                 style: _textTheme
                                        //                                     .titleLarge,
                                        //                               ),
                                        //                               SizedBox(
                                        //                                 height: 5,
                                        //                               ),
                                        //                               Text(
                                        //                                 '1600',
                                        //                                 style: _textTheme
                                        //                                     .titleLarge,
                                        //                               ),
                                        //                               SizedBox(
                                        //                                 height: 5,
                                        //                               ),
                                        //                               Text(
                                        //                                 '0.0',
                                        //                                 style: _textTheme
                                        //                                     .titleLarge,
                                        //                               ),
                                        //                               SizedBox(
                                        //                                 height: 5,
                                        //                               ),
                                        //                               Text(
                                        //                                 '0.0',
                                        //                                 style: _textTheme
                                        //                                     .titleLarge,
                                        //                               ),
                                        //                             ],
                                        //                           ),
                                        //                         ),
                                        //                       ],
                                        //                     ),
                                        //                     Padding(
                                        //                       padding:
                                        //                           const EdgeInsets
                                        //                                   .symmetric(
                                        //                               horizontal:
                                        //                                   10,
                                        //                               vertical:
                                        //                                   20),
                                        //                       child: Row(
                                        //                         mainAxisAlignment:
                                        //                             MainAxisAlignment
                                        //                                 .spaceBetween,
                                        //                         children: [
                                        //                           Text(
                                        //                             'Grand Total',
                                        //                             style: _textTheme
                                        //                                 .headlineSmall,
                                        //                           ),
                                        //                           Text(
                                        //                             '16000',
                                        //                             style: _textTheme
                                        //                                 .headlineSmall!
                                        //                                 .copyWith(
                                        //                                     fontWeight:
                                        //                                         FontWeight.bold),
                                        //                           ),
                                        //                         ],
                                        //                       ),
                                        //                     ),
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //               const SizedBox(height: 20),
                                        //               Container(
                                        //                 width:
                                        //                     MediaQuery.of(context)
                                        //                         .size
                                        //                         .width,
                                        //                 child: Row(
                                        //                   children: [
                                        //                     Expanded(
                                        //                       child:
                                        //                           CustomRoundedButtom(
                                        //                         title: LocaleKeys
                                        //                             .done
                                        //                             .tr(),
                                        //                         onPressed: () {
                                        //                           NavigationService
                                        //                               .pop();
                                        //                         },
                                        //                       ),
                                        //                     ),
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     );
                                        //},
                                      }),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomRoundedButtom(
                              verticalPadding: 10,
                              // horizontalMargin: 40,
                              fontSize: 12,
                              title: 'Book Now',
                              onPressed: () {
                                selectedFlight = flight;
                                context.read<UtilityPaymentCubit>().makePayment(
                                    serviceIdentifier: "ARS",
                                    accountDetails: {},
                                    body: {
                                      "flightId": flight.flightId,
                                      "returnFlightId": "",
                                      "amount": flight.totalFare,
                                      "cashBack": flight.cashBack,
                                    },
                                    apiEndpoint: "/api/arsflightreservation",
                                    mPin: "");
                              },
                              textColor: CustomTheme.white,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
