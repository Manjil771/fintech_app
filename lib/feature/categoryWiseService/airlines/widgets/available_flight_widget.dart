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
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_avliable_list_model.dart';
import 'package:ismart/feature/categoryWiseService/airlines/screen/passenger_detail_page.dart';
import 'package:ismart/feature/categoryWiseService/airlines/widgets/avaliable_flight_design_widget.dart';
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
  Availability? selectedFlight;
  bool _isLoading = false;
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

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
          verticalPadding: 0,
          showTitleText: false,
          title: "Available Flights",
          showRoundBotton: false,
          topbarName: 'Book Flight',
          body: Container(
            height: _height / 1.6,
            child: DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    onTap: (value) {
                      setState(() {});
                    },
                    labelColor: _theme.primaryColor,
                    unselectedLabelColor: CustomTheme.darkGray,
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    indicatorColor: _theme.primaryColor,
                    automaticIndicatorColorAdjustment: true,
                    tabs: [
                      Tab(text: 'Departure'),
                      Tab(text: 'Return'),
                    ],
                  ),
                  SizedBox(height: _height * 0.02),
                  Expanded(
                    child: TabBarView(
                      children: [
                        AvaliableFlightsDesign(
                          onpress: () {
                            DefaultTabController.of(context).animateTo(1);
                          },
                          bound: widget
                              .flightDetail.detail.flightAvailability.outbound,
                        ),
                        AvaliableFlightsDesign(
                          onpress: () {},
                          bound: widget
                              .flightDetail.detail.flightAvailability.inbound,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
