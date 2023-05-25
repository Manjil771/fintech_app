import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/util/size_utils.dart';

class CommonDetailBox extends StatelessWidget {
  final String leadingIcon;
  final String trailingIcon;
  final double verticalPadding;
  final double horizontalPadding;

  final String title;
  final String detail;
  final VoidCallback onBoxPressed;

  const CommonDetailBox(
      {super.key,
      this.leadingIcon = Assets.brokerIcon,
      this.verticalPadding = 10.0,
      this.horizontalPadding = 20.0,
      required this.title,
      this.trailingIcon = Assets.forwardButtonIcon,
      this.detail = "",
      required this.onBoxPressed});

  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: InkWell(
        onTap: () {
          onBoxPressed.call();
        },
        child: Row(
          children: [
            SvgPicture.asset(
              leadingIcon,
              color: CustomTheme.darkerBlack,
              height: _height * 0.04,
            ),
            SizedBox(width: _width * 0.05),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  Text(detail, style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
            ),
            SizedBox(width: _width * 0.05),
            SvgPicture.asset(
              trailingIcon,
              color: CustomTheme.darkerBlack,
              height: _height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
