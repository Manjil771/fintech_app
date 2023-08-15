import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_avliable_list_model.dart';
import 'package:ismart/feature/categoryWiseService/airlines/screen/passenger_detail_page.dart';
import 'package:ismart/feature/categoryWiseService/airlines/widgets/inbound_flight_design_widget.dart';
import 'package:ismart/feature/categoryWiseService/airlines/widgets/outbound_flight_design_widget.dart';
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

class _AvailableFlightWidgetState extends State<AvailableFlightWidget>
    with TickerProviderStateMixin {
  bool _isLoading = false;

  bool departure = true;
  bool arrival = true;
  Availability? departureFlight;
  Availability? arrivalFlight;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    double getTotalFare() {
      if (departureFlight != null && arrivalFlight != null) {
        double sum =
            (departureFlight?.totalFare ?? 0) + (arrivalFlight?.totalFare ?? 0);
        return sum;
      } else {
        return departureFlight?.totalFare ?? 0;
      }
    }

    return PageWrapper(
      showBackButton: true,
      body: BlocListener<UtilityPaymentCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoading && _isLoading == false) {
            _isLoading = true;
            showLoadingDialogBox(context);
          } else if (state is! CommonLoading && _isLoading) {
            _isLoading = false;
            NavigationService.pop();
          }
          if (state is CommonError) {
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
                      arrivalFlight: arrivalFlight,
                      totalFare: getTotalFare(),
                      service: widget.service,
                      adultCount: widget.adultCount,
                      childrenCount: widget.childrenCount,
                      departureFlight: departureFlight));
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
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: CustomRoundedButtom(
                        color: departure == true
                            ? CustomTheme.googleColor
                            : CustomTheme.darkGray,
                        title: "Departure",
                        onPressed: () {
                          setState(() {
                            departure = true;
                            arrival = false;
                          });
                        })),
                widget.flightDetail.detail.flightAvailability.inbound
                        .availability.isNotEmpty
                    ? Expanded(
                        child: CustomRoundedButtom(
                            color: departure == false
                                ? CustomTheme.googleColor
                                : CustomTheme.darkGray,
                            title: "Arrival",
                            onPressed: () {
                              arrival = true;
                              departure = false;
                              setState(() {});
                            }))
                    : Container(),
              ],
            ),
            Expanded(
              child: departure == true
                  ? OutBoundFlightsDesign(
                      selectedFlight: departureFlight,
                      onpress: (p0) {
                        departureFlight = p0;
                        arrival = true;
                        widget.flightDetail.detail.flightAvailability.inbound
                                .availability.isNotEmpty
                            ? departure = false
                            : departure = true;
                        setState(() {});
                      },
                      bound: widget
                          .flightDetail.detail.flightAvailability.outbound,
                    )
                  : InboundFlightDesign(
                      selectedFlight: arrivalFlight,
                      onpress: (p0) {
                        arrivalFlight = p0;
                        setState(() {});
                      },
                      bound:
                          widget.flightDetail.detail.flightAvailability.inbound,
                    ),
            ),
            departureFlight != null
                ? Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: CustomTheme.white),
                    padding: EdgeInsets.all(18),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: KeyValueTile(
                            axis: Axis.vertical,
                            title: "Departure",
                            value: departureFlight?.totalFare.toString() ?? "",
                          ),
                        ),
                        arrivalFlight != null
                            ? KeyValueTile(
                                axis: Axis.vertical,
                                title: "Return",
                                value:
                                    arrivalFlight?.totalFare.toString() ?? "",
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: KeyValueTile(
                            axis: Axis.vertical,
                            title: "Total",
                            value: getTotalFare().toString(),
                          ),
                        ),
                        Expanded(
                            child: CustomRoundedButtom(
                                title: "Book",
                                onPressed: () {
                                  if (widget
                                      .flightDetail
                                      .detail
                                      .flightAvailability
                                      .inbound
                                      .availability
                                      .isNotEmpty) {
                                    if (arrivalFlight != null &&
                                        departureFlight != null &&
                                        widget
                                            .flightDetail
                                            .detail
                                            .flightAvailability
                                            .inbound
                                            .availability
                                            .isNotEmpty) {
                                      context
                                          .read<UtilityPaymentCubit>()
                                          .makePayment(
                                              serviceIdentifier: "ARS",
                                              accountDetails: {},
                                              body: {
                                                "flightId":
                                                    departureFlight?.flightId ??
                                                        "",
                                                "returnFlightId":
                                                    arrivalFlight?.flightId ??
                                                        "",
                                                "amount": getTotalFare(),
                                              },
                                              apiEndpoint:
                                                  "/api/arsflightreservation",
                                              mPin: "");
                                    } else {
                                      showPopUpDialog(
                                        context: context,
                                        showCancelButton: false,
                                        message: departureFlight == null
                                            ? "Please Departure Select Flight"
                                            : "Please Select Return Flight",
                                        title: "Select",
                                        buttonCallback: () {
                                          NavigationService.pop();
                                        },
                                      );
                                    }
                                  } else {
                                    if (departureFlight != null &&
                                        widget
                                            .flightDetail
                                            .detail
                                            .flightAvailability
                                            .inbound
                                            .availability
                                            .isEmpty) {
                                      context
                                          .read<UtilityPaymentCubit>()
                                          .makePayment(
                                              serviceIdentifier: "ARS",
                                              accountDetails: {},
                                              body: {
                                                "flightId":
                                                    departureFlight?.flightId ??
                                                        "",
                                                "returnFlightId": "",
                                                "amount": getTotalFare(),
                                              },
                                              apiEndpoint:
                                                  "/api/arsflightreservation",
                                              mPin: "");
                                    }
                                  }
                                }))
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
