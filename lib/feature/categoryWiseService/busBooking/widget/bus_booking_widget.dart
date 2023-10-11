import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/models/key_value.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/categoryWiseService/airlines/cubit/airlines_cubit.dart';
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_avliable_list_model.dart';
import 'package:ismart/feature/categoryWiseService/airlines/screen/available_flight_screen.dart';
import 'package:ismart/feature/categoryWiseService/airlines/widgets/location_list_widget.dart';
import 'package:ismart/feature/categoryWiseService/busBooking/screen/available_bus_page.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';

class BusBookingWidget extends StatefulWidget {
  final ServiceList service;

  const BusBookingWidget({Key? key, required this.service}) : super(key: key);

  @override
  State<BusBookingWidget> createState() => _BusBookingWidgetState();
}

class _BusBookingWidgetState extends State<BusBookingWidget> {
  final _departureDateController = TextEditingController();
  bool _isLoading = false;
  DateTime departureDate = DateTime.now();

  final ValueNotifier<KeyValue?> _selectedSectorFrom = ValueNotifier(null);
  final ValueNotifier<KeyValue?> _selectedSectorTo = ValueNotifier(null);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        showDetail: true,
        title: widget.service.service,
        detail: widget.service.instructions,
        topbarName: widget.service.serviceCategoryName,
        buttonName: 'Search Bus',
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

            if (state is CommonStateSuccess<SearchFlightResponse>) {
              SearchFlightResponse _response = state.data;

              if (_response.responseStatus.toLowerCase() ==
                  "Success".toLowerCase()) {
                // NavigationService.push(
                //   target: AvailableFlightPage(
                //     service: widget.service,
                //     adultCount: _adultCount,
                //     childrenCount: _childrenCount,
                //     flightDetail: _response,
                //     isTwoWay: isRoundTrip,
                //   ),
                // );
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: CustomTheme.lightGray),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          NavigationService.push(
                              target: FlightsSearchPage(
                            onChanged: (value) {
                              _selectedSectorFrom.value = value;
                            },
                            selectedValue: _selectedSectorFrom.value,
                          ));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From',
                              style: _textTheme.headlineSmall,
                            ),
                            ValueListenableBuilder<KeyValue?>(
                                valueListenable: _selectedSectorFrom,
                                builder: (context, val, child) {
                                  return Text(
                                    val != null ? val.title : 'Select',
                                    style: _textTheme.headlineMedium!.copyWith(
                                        fontSize: 14,
                                        color: CustomTheme.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  );
                                }),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SvgPicture.asset(
                          'assets/icons/airplane.svg',
                          height: 30,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          NavigationService.push(
                            target: FlightsSearchPage(
                              onChanged: (value) {
                                _selectedSectorTo.value = value;
                              },
                              selectedValue: _selectedSectorTo.value,
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To',
                              style: _textTheme.headlineSmall,
                            ),
                            ValueListenableBuilder<KeyValue?>(
                                valueListenable: _selectedSectorTo,
                                builder: (context, val, child) {
                                  return Text(
                                    val != null ? val.title : 'Select',
                                    style: _textTheme.headlineMedium!.copyWith(
                                        fontSize: 14,
                                        color: CustomTheme.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  title: 'Departure Date',
                  hintText: "Select Date",
                  controller: _departureDateController,
                  validator: (value) => FormValidator.validateFieldNotEmpty(
                    value,
                    'Departure Date',
                  ),
                  readOnly: true,
                  onTap: () async {
                    final DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 90)),
                    );
                    setState(() {
                      departureDate = date ?? DateTime.now();
                      _departureDateController.text =
                          "${date!.day}-${date.month}-${date.year}";
                    });
                  },
                  suffixIcon: Icons.calendar_month_rounded,
                  showSearchIcon: true,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        onButtonPressed: () {
          // if (_selectedSectorFrom.value != null &&
          //     _selectedSectorTo.value != null &&
          //     _formKey.currentState!.validate()) {
          NavigationService.push(
              target: AvailableBusPage(
                  selectedDate: DateTime.now(), service: widget.service));
          // } else {
          //   showPopUpDialog(
          //       context: context,
          //       message: "Select Select Sector",
          //       title: "Select Location",
          //       showCancelButton: false,
          //       buttonCallback: () {
          //         NavigationService.pop();
          //       });
          // }
        },
      ),
    );
  }
}
