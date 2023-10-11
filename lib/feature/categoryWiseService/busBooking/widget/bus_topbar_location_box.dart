import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/util/size_utils.dart';

class BusTopBarLocationBox extends StatelessWidget {
  final String sectorFrom;
  final String sectorTo;
  final DateTime selectedDate;
  const BusTopBarLocationBox(
      {Key? key,
      required this.sectorFrom,
      required this.sectorTo,
      required this.selectedDate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  sectorFrom,
                  style: _textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600, color: _theme.primaryColor),
                ),
              ),
              Expanded(
                  child: SvgPicture.asset(
                Assets.busSideIcon,
                height: 20,
                color: _theme.primaryColor,
              )),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    sectorTo,
                    style: _textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: _theme.primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.hp),
        Text(
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
          style: _textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w600, color: _theme.primaryColor),
        ),
      ],
    );
  }
}
