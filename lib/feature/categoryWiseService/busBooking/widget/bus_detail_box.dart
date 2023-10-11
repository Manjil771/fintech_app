import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/fonts.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/feature/categoryWiseService/busBooking/widget/bus_booking_widget.dart';
import 'package:ismart/feature/categoryWiseService/busBooking/widget/bus_seat_widget.dart';

class BusDetailBox extends StatelessWidget {
  const BusDetailBox({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return InkWell(
      onTap: () {
        NavigationService.push(target: BusSeatsListWidget());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          // color: _theme.primaryColor.withOpacity(0.4)),
          color: CustomTheme.white,
        ),
        // padding: EdgeInsets.all(18),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Open Vist Nepal",
                          style: _textTheme.titleSmall!.copyWith(
                              color: _theme.primaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        Text("VIP sofa Seater" " - " "7:00 AM",
                            style: _textTheme.titleSmall!.copyWith(
                                color: CustomTheme.darkGray,
                                fontSize: 11,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Text(
                    "Seat \n45",
                    style: _textTheme.titleSmall!.copyWith(
                        color: _theme.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Text(
                      "Transaparent Roof, Air Suspension , Charging Port, Rel ec  asd tromic push seat , Luxurious sofa seat hi hello test writing a brown fox jump over a crazy dag ",
                      style: _textTheme.titleSmall!.copyWith(
                          // color: CustomTheme.darkGray,
                          fontSize: 11,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                      color: _theme.primaryColor),
                  child: Text(
                    "Rs. 1200",
                    style: _textTheme.titleSmall!
                        .copyWith(color: CustomTheme.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
