import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/busBooking/widget/bus_topbar_location_box.dart';

class BusSeatsListWidget extends StatelessWidget {
  final List seats;
  final columnNumber;
  const BusSeatsListWidget(
      {Key? key, required this.seats, required this.columnNumber})
      : super(key: key);
  getColor(index) {
    return seats[index]["bookingStatus"].toString().toLowerCase() != "no"
        ? CustomTheme.darkGray
        : CustomTheme.green;
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
        showBackButton: true,
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
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Assets.busSeatIcon,
                          height: 20.hp,
                          color: CustomTheme.green,
                        ),
                        SizedBox(width: 10.wp),
                        Text(
                          "Avaliable",
                          style: _textTheme.titleSmall!.copyWith(
                            color: CustomTheme.green,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Assets.busSeatIcon,
                          height: 20.hp,
                          color: CustomTheme.testAppColor,
                        ),
                        SizedBox(width: 10.wp),
                        Text(
                          "Selected",
                          style: _textTheme.titleSmall!.copyWith(
                            color: CustomTheme.testAppColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Assets.busSeatIcon,
                          height: 20.hp,
                          color: CustomTheme.darkGray,
                        ),
                        SizedBox(width: 10.wp),
                        Text(
                          "Booked",
                          style: _textTheme.titleSmall!.copyWith(
                            color: CustomTheme.darkGray,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text("FRONT", style: _textTheme.titleLarge),
            Expanded(
              child: GridView.builder(
                itemCount: seats.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columnNumber),
                itemBuilder: (context, index) {
                  return seats[index]["displayName"].toString() != "na"
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              Assets.busSeatIcon,
                              height: 20.hp,
                              color: getColor(index),
                            ),
                            Text(
                              seats[index]["displayName"],
                              style: _textTheme.titleSmall!
                                  .copyWith(color: getColor(index)),
                            ),
                          ],
                        )
                      : Container();
                },
              ),
            )
          ],
        ));
  }
}
