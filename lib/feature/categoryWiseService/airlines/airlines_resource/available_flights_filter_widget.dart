import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/airlines/airlines_resource/filter_chip_widget.dart';

class AvailableFlightsFilterWidget extends StatefulWidget {
  AvailableFlightsFilterWidget({
    Key? key,
    required this.maxTicketPrice,
    required this.leastTicketPrice,
    required this.onApplyCallback,
    required this.airlinesList,
    required this.onResetFilterCallback,
    this.selectedTimeRange,
    required this.selectedAirlines,
    this.selectedPriceRange,
  }) : super(key: key);
  final int maxTicketPrice;
  final int leastTicketPrice;
  final Function(RangeValues?, RangeValues?, Set<String>) onApplyCallback;
  final List<String> airlinesList;

  final Function() onResetFilterCallback;

  final RangeValues? selectedTimeRange;
  final Set<String> selectedAirlines;
  final RangeValues? selectedPriceRange;

  @override
  State<AvailableFlightsFilterWidget> createState() =>
      _AvailableFlightsFilterWidgetState();
}

class _AvailableFlightsFilterWidgetState
    extends State<AvailableFlightsFilterWidget> {
  RangeValues? _currentPriceRange;
  RangeValues? _currentTimeRange;
  var _selectedAirlines = <String>{};
  @override
  void initState() {
    super.initState();

    _currentPriceRange = widget.selectedPriceRange ??
        RangeValues(widget.leastTicketPrice.toDouble(),
            widget.maxTicketPrice.toDouble());

    _currentTimeRange = widget.selectedTimeRange ?? RangeValues(1, 24);

    _selectedAirlines.addAll(widget.selectedAirlines);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    return PageWrapper(
      floatinActionButton: Container(
        width: _width,
        child: Row(
          children: [
            Expanded(
              child: CustomRoundedButtom(
                title: "context.loc.flight.reset",
                onPressed: () {
                  widget.onResetFilterCallback();
                  NavigationService.pop();
                },
                color: Colors.white,
                textColor: CustomTheme.primaryColor,
              ),
            ),
            SizedBox(
              width: 10.hp,
            ),
            Expanded(
              child: CustomRoundedButtom(
                title: "context.loc.apply",
                onPressed: () {
                  widget.onApplyCallback(
                      _currentPriceRange, _currentTimeRange, _selectedAirlines);
                  NavigationService.pop();
                },
              ),
            ),
          ],
        ),
      ),
      padding: EdgeInsets.zero,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CustomTheme.symmetricHozPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "context.loc.flight.price",
                style: _textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              RangeSlider(
                values: RangeValues(
                  _currentPriceRange!.start,
                  _currentPriceRange!.end,
                ),
                min: widget.leastTicketPrice.toDouble(),
                activeColor: CustomTheme.primaryColor,
                inactiveColor: CustomTheme.primaryColor.withOpacity(0.15),
                max: widget.maxTicketPrice.toDouble(),
                divisions: 100,
                labels: RangeLabels(
                  _currentPriceRange!.start.round().toString(),
                  _currentPriceRange!.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(
                    () {
                      _currentPriceRange = values;
                    },
                  );
                },
              ),
              Text(
                "context.loc.flight.time",
                style: _textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              RangeSlider(
                values: RangeValues(
                  _currentTimeRange!.start,
                  _currentTimeRange!.end,
                ),
                min: 1,
                activeColor: CustomTheme.primaryColor,
                inactiveColor: CustomTheme.primaryColor.withOpacity(0.15),
                max: 24,
                divisions: 100,
                labels: RangeLabels(
                  getTime(_currentTimeRange!.start.toInt()),
                  getTime(_currentTimeRange!.end.toInt()),
                ),
                onChanged: (RangeValues values) {
                  setState(
                    () {
                      _currentTimeRange = values;
                    },
                  );
                },
              ),
              Text(
                "context.loc.flight.airlines",
                style: _textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Wrap(
                children: List.generate(
                  widget.airlinesList.length,
                  (index) {
                    return FilterChipWidget(
                      chipText: widget.airlinesList[index],
                      onSelectionCallback: (val) {
                        if (val) {
                          _selectedAirlines.add(widget.airlinesList[index]);
                        } else {
                          _selectedAirlines.remove(widget.airlinesList[index]);
                        }
                        setState(() {});
                      },
                      isOptionSelected: widget.selectedAirlines.contains(
                        widget.airlinesList[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getTime(int value) {
  if (value <= 12) {
    return "${(value).truncate()} AM";
  } else {
    return "${(value - 11).truncate()} PM";
  }
}

class TimeFilterData {
  final String timeFrom;
  final String timeTo;
  TimeFilterData({required this.timeFrom, required this.timeTo});

  String getString() {
    return timeFrom + ":" + timeTo;
  }
}

extension ListExtension<E> on List<E> {
  void addAllUnique(Iterable<E> iterable) {
    for (var element in iterable) {
      if (!contains(element)) {
        add(element);
      }
    }
  }
}
