import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/busBooking/widget/bus_topbar_location_box.dart';

class BusSeatsListWidget extends StatelessWidget {
  const BusSeatsListWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BusTopBarLocationBox(
          selectedDate: DateTime.now(),
          sectorFrom: "KATHMANDU",
          sectorTo: "POKHARA",
        ),
        SizedBox(height: 10.hp),
        Text(
          "Open Visit Nepal",
          style: _textTheme.titleLarge!.copyWith(
              color: _theme.primaryColor, fontWeight: FontWeight.bold),
        ),
        Text(
          "VIP SOFA SEAT - 7:00 AM",
          style: _textTheme.titleSmall,
        ),
        Divider(thickness: 1),
//TODO need to add seat for bus
      ],
    ));
  }
}
