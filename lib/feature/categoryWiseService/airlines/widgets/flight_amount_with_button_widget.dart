import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';

import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_avliable_list_model.dart';
import 'package:ismart/feature/categoryWiseService/airlines/screen/passenger_detail_page.dart';
import 'package:ismart/feature/categoryWiseService/airlines/widgets/flight_amount_column_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class FlightAmountWidgetWithButton extends StatelessWidget {
  FlightAmountWidgetWithButton({
    Key? key,
    required this.outBoundValues,
    required this.inBoundValues,
    required this.selectedInboundIndex,
    required this.selectedOutboundIndex,
    required this.isTwoWay,
    required this.services,
    required this.currentIndexNotifier,
    required this.bookingId,
    required this.totalPrice,
    required this.adultCount,
    required this.childrenCount,
    required this.onButtonPress,
  }) : super(key: key);
  final List<Flight> outBoundValues;
  final Function onButtonPress;
  final List<Flight> inBoundValues;
  final int selectedInboundIndex;
  final int selectedOutboundIndex;
  final bool isTwoWay;
  final int adultCount;
  final int childrenCount;
  final ValueNotifier<int> currentIndexNotifier;
  final String bookingId;
  final double totalPrice;
  final ServiceList services;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _width = SizeUtils.width;
    return

        // return BlocListener<UtilityPaymentCubit, CommonState>(
        //   listener: (context, state) {
        //     if (state is CommonLoading && _isLoading == false) {
        //       _isLoading = true;
        //       showLoadingDialogBox(context);
        //     } else if (state is! CommonLoading && _isLoading) {
        //       _isLoading = false;
        //       NavigationService.pop();
        //     }
        //     if (state is CommonError) {
        //       showPopUpDialog(
        //         context: context,
        //         message: state.message,
        //         title: "Error",
        //         showCancelButton: false,
        //         buttonCallback: () {
        //           NavigationService.pop();
        //         },
        //       );
        //     }

        //     if (state is CommonStateSuccess<UtilityResponseData>) {
        //       UtilityResponseData _response = state.data;
        //       if (_response.code == "M0000" ||
        //           _response.status.toLowerCase() == "Success".toLowerCase()) {
        //         NavigationService.push(
        //           target: PassengerDetailScreen(
        //             utilityResponseData: _response,
        //             arrivalFlight: inBoundValues[selectedInboundIndex],
        //             totalFare: totalPrice,
        //             service: services,
        //             adultCount: 1,
        //             childrenCount: 0,
        //             departureFlight: outBoundValues[selectedOutboundIndex],
        //           ),
        //         );
        //       } else {
        //         showPopUpDialog(
        //             context: context,
        //             message: _response.message,
        //             title: "Error",
        //             buttonCallback: () {
        //               NavigationService.pop();
        //             },
        //             showCancelButton: false);
        //       }
        //     }
        //   },
        Container(
      width: _width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.hp,
        vertical: 30.hp,
      ),
      child: Column(
        children: [
          Row(
            children: [
              FlightAmountDetailsColumnWidget(
                title: "Departure",
                price:
                    outBoundValues[selectedOutboundIndex].totalFare.toString(),
                cashBack:
                    outBoundValues[selectedOutboundIndex].cashBack.toString(),
              ),
              SizedBox(
                width: 10.hp,
              ),
              if (selectedInboundIndex != -1)
                FlightAmountDetailsColumnWidget(
                  title: "Return",
                  price:
                      inBoundValues[selectedInboundIndex].totalFare.toString(),
                  cashBack: inBoundValues[selectedInboundIndex].cashBack == null
                      ? "0.00"
                      : inBoundValues[selectedInboundIndex].cashBack.toString(),
                ),
              Container(
                height: 30.hp,
                child: VerticalDivider(
                  color: CustomTheme.darkGray,
                  thickness: 2.hp,
                  width: 20.hp,
                ),
              ),
              FlightAmountDetailsColumnWidget(
                title: "Total",
                price: "$totalPrice",
                cashBack: "0.00",
              ),
              SizedBox(
                width: 20.hp,
              ),
              Expanded(
                child: Container(
                  height: 45.hp,
                  child: CustomRoundedButtom(
                    padding: EdgeInsets.zero,
                    title: "Book",
                    onPressed: () {
                      if (isTwoWay && selectedInboundIndex == -1) {
                        currentIndexNotifier.value = 1;
                        // setState(() {});
                      } else {
                        onButtonPress();
                        //   context.read<UtilityPaymentCubit>().makePayment(
                        //       serviceIdentifier: "ARS",
                        //       accountDetails: {},
                        //       body: {
                        //         "flightId":
                        //             outBoundValues[selectedOutboundIndex]
                        //                 .flightId,
                        //         "returnFlightId":
                        //             selectedInboundIndex.isNegative
                        //                 ? ""
                        //                 : inBoundValues[selectedInboundIndex]
                        //                     .flightId,
                        //         "amount": totalPrice,
                        //       },
                        //       apiEndpoint: "/api/arsflightreservation",
                        //       mPin: "");
                      }
                    },
                    textColor: _theme.primaryColor,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.hp,
          ),
        ],
      ),
      // ),
    );
  }
}
