import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_sector_model.dart';
import 'package:ismart/feature/categoryWiseService/airlines/screen/available_flight_screen.dart';
import 'package:ismart/feature/categoryWiseService/airlines/screen/location_list_page.dart';
import 'package:ismart/feature/categoryWiseService/airlines/widgets/location_list_widget.dart';

import '../../../sendMoney/anyBank/screen/bank_list_page.dart';

class SearchFlightWidget extends StatefulWidget {
  SearchFlightWidget({Key? key}) : super(key: key);

  @override
  State<SearchFlightWidget> createState() => _SearchFlightWidgetState();
}

class _SearchFlightWidgetState extends State<SearchFlightWidget> {
  int _adultCount = 0;
  int _childrenCount = 0;
  String? _fromPlaceValue;
  final _dateController = TextEditingController();
  final _fromController = TextEditingController();
  var _modeController = TextEditingController();
  var _arriveDateController = TextEditingController();
  bool isRoundTrip = false;

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
        body: Column(
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
                              onBankSelected: (val) {
                                NavigationService.pop();

                                _fromController.text = val.toString();
                                _fromPlaceValue = val.toString();
                                setState(() {});
                              },
                            ));
                          },
                          child: Text(
                            'Select',
                            style: _textTheme.headlineMedium!.copyWith(
                                fontSize: 18,
                                color: CustomTheme.primaryColor,
                                fontWeight: FontWeight.bold),
                          )),
                      Text(
                        _fromPlaceValue.toString(),
                        style: _textTheme.titleSmall,
                      ),
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
                      Text(
                        'Kathmandu',
                        style: _textTheme.titleSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: _modeController,
              title: 'Flight Mode',
              readOnly: true,
              hintText: 'Single Trip',
              suffixIcon: Icons.abc,
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      if (isRoundTrip == false) {
                        isRoundTrip = true;
                        _modeController.text = 'Round Trip';
                      } else if (isRoundTrip == true) {
                        isRoundTrip = false;

                        _modeController.clear();
                      }
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
              controller: _dateController,
              validator: (value) =>
                  FormValidator.validateFieldNotEmpty(value, 'Departure Date'),
              readOnly: true,
              onTap: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022),
                  lastDate: DateTime.now().add(Duration(days: 30)),
                );
                setState(() {
                  _dateController.text =
                      "${date!.day}/${date.month}/${date.year}";
                });
              },
              suffixIcon: Icons.calendar_month_rounded,
              showSearchIcon: true,
            ),
            isRoundTrip
                ? CustomTextField(
                    title: 'Arrival Date',
                    hintText: "Select Date",
                    controller: _arriveDateController,
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
                        _arriveDateController.text =
                            "${date!.day}/${date.month}/${date.year}";
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
                                  if (_adultCount > 0) {
                                    _adultCount--;
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
                            _adultCount.toString(),
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
        onButtonPressed: () {
          NavigationService.push(
              target: AvailableFlightScreen(
            adultCount: _adultCount,
            childrenCount: _childrenCount,
          ));
        },
      ),
    );
  }
}
