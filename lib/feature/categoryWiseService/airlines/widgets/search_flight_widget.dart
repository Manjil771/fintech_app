import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/categoryWiseService/airlines/cubit/airlines_cubit.dart';
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_avliable_list.dart';
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_sector_model.dart';
import 'package:ismart/feature/categoryWiseService/airlines/screen/available_flight_screen.dart';
import 'package:ismart/feature/categoryWiseService/airlines/screen/location_list_airlines_page.dart';
import 'package:ismart/feature/categoryWiseService/airlines/widgets/location_list_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

import '../../../sendMoney/anyBank/screen/bank_list_page.dart';

class SearchFlightWidget extends StatefulWidget {
  final ServiceList service;

  SearchFlightWidget({Key? key, required this.service}) : super(key: key);

  @override
  State<SearchFlightWidget> createState() => _SearchFlightWidgetState();
}

class _SearchFlightWidgetState extends State<SearchFlightWidget> {
  int _adultCount = 1;
  int _childrenCount = 0;
  AirlinesSectorList fromPlace = AirlinesSectorList();
  AirlinesSectorList toPlace = AirlinesSectorList();
  final TextEditingController tripTypeController = TextEditingController();

  final _departureDateController = TextEditingController();
  final _arrivalDateController = TextEditingController();
  bool isRoundTrip = false;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        showTitleText: false,
        showDetail: false,
        topbarName: 'Book Flight',
        buttonName: 'Search Flight',
        body: BlocListener<AirlinesCubit, CommonState>(
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

            if (state is CommonStateSuccess<AvailableFlightModel>) {
              AvailableFlightModel _response = state.data;

              if (_response.responseStatus.toLowerCase() ==
                  "Success".toLowerCase()) {
                NavigationService.push(
                    target: AvailableFlightScreen(
                        service: widget.service,
                        adultCount: _adultCount,
                        childrenCount: _childrenCount,
                        flightDetail: _response));
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
            print("state is asjndkhjasgdhjsagd" + state.toString());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: CustomTheme.lightGray),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From',
                          style: _textTheme.headlineSmall,
                        ),
                        InkWell(
                            onTap: () {
                              NavigationService.push(
                                  target: LoationListFlightPage(
                                selectedLocation: (val) {
                                  NavigationService.pop();

                                  fromPlace = val;
                                  setState(() {});
                                },
                              ));
                            },
                            child: Text(
                              fromPlace.sectorName ?? 'Select',
                              style: _textTheme.headlineMedium!.copyWith(
                                  fontSize: 14,
                                  color: CustomTheme.primaryColor,
                                  fontWeight: FontWeight.bold),
                            )),
                        // Text(
                        //   fromPlace.sectorCode.toString(),
                        //   style: _textTheme.titleSmall,
                        // ),
                      ],
                    ),
                    Expanded(
                      child: SvgPicture.asset(
                        'assets/icons/airplane.svg',
                        height: 30,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'To',
                          style: _textTheme.headlineSmall,
                        ),
                        InkWell(
                            onTap: () {
                              NavigationService.push(
                                  target: LoationListFlightPage(
                                selectedLocation: (val) {
                                  NavigationService.pop();

                                  toPlace = val;
                                  setState(() {});
                                },
                              ));
                            },
                            child: Text(
                              toPlace.sectorName ?? 'Select',
                              style: _textTheme.headlineMedium!.copyWith(
                                  fontSize: 14,
                                  color: CustomTheme.primaryColor,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: tripTypeController
                  ..text = isRoundTrip ? "Round Trip" : "Single Trip",
                title: 'Flight Mode',

                readOnly: true,
                // hintText: 'Single Trip',
                suffixIcon: Icons.abc,
                trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        isRoundTrip = !isRoundTrip;
                      });
                    },
                    icon: Icon(
                      Icons.swap_vert_circle_outlined,
                      size: 40,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                title: 'Departure Date',
                hintText: "Select Date",
                controller: _departureDateController,
                validator: (value) => FormValidator.validateFieldNotEmpty(
                    value, 'Departure Date'),
                readOnly: true,
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022),
                    lastDate: DateTime.now().add(Duration(days: 90)),
                  );
                  setState(() {
                    _departureDateController.text =
                        "${date!.day}-${date.month}-${date!.year}";
                  });
                },
                suffixIcon: Icons.calendar_month_rounded,
                showSearchIcon: true,
              ),
              isRoundTrip
                  ? CustomTextField(
                      title: 'Arrival Date',
                      hintText: "Select Date",
                      controller: _arrivalDateController,
                      validator: (value) => FormValidator.validateFieldNotEmpty(
                          value, 'Departure Date'),
                      readOnly: true,
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime.now().add(Duration(days: 90)),
                        );
                        setState(() {
                          _arrivalDateController.text =
                              "${date!.year}-${date.month}-${date.day}";
                        });
                      },
                      suffixIcon: Icons.calendar_month_rounded,
                      showSearchIcon: true,
                    )
                  : Container(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Adult',
                        style: _textTheme.titleLarge,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: CustomTheme.darkGray),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: CustomTheme.lightGray,
                                  borderRadius: BorderRadius.circular(5)),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (_adultCount > 1) {
                                      _adultCount--;
                                    }
                                  });
                                },
                                icon: Icon(Icons.remove),
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              _adultCount.toString(),
                              style: _textTheme.headlineSmall!.copyWith(),
                            ),
                            SizedBox(width: 20),
                            Container(
                              decoration: BoxDecoration(
                                  color: CustomTheme.primaryColor,
                                  borderRadius: BorderRadius.circular(2)),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _adultCount++;
                                  });
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: CustomTheme.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Children',
                        style: _textTheme.titleLarge,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: CustomTheme.darkGray),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: CustomTheme.lightGray,
                                  borderRadius: BorderRadius.circular(5)),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (_childrenCount > 0) {
                                      _childrenCount--;
                                    }
                                  });
                                },
                                icon: Icon(Icons.remove),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              _childrenCount.toString(),
                              style: _textTheme.headlineSmall!.copyWith(),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: CustomTheme.primaryColor,
                                  borderRadius: BorderRadius.circular(2)),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _childrenCount++;
                                  });
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: CustomTheme.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        onButtonPressed: () {
          context.read<AirlinesCubit>().fetchFlight(accountDetails: {}, body: {
            "sectorFrom": fromPlace.sectorCode.toString(),
            "sectorTo": toPlace.sectorCode.toString(),
            "adultNumber": _adultCount,
            "childNumber": _childrenCount,
            "flightDate": _departureDateController.text,
            "returnDate": _arrivalDateController.text,
            "tripType": isRoundTrip ? "R" : "O",
            "nationality": "NP"
          });
        },
      ),
    );
  }
}
