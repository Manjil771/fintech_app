import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/util/size_utils.dart';

class CommonGridViewContainer extends StatelessWidget {
  final bool isNetworkImage;
  final String containerImage;
  final String title;
  final Function()? onContainerPress;
  final EdgeInsets? margin;
  final double? height;
  final double? width;

  const CommonGridViewContainer(
      {super.key,
      required this.containerImage,
      this.isNetworkImage = false,
      this.margin = const EdgeInsets.all(8),
      required this.title,
      this.onContainerPress,
      this.height,
      this.width});
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _height = SizeUtils.height;

    return InkWell(
      onTap: onContainerPress,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: margin,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: CustomTheme.darkerBlack.withOpacity(0.07)),
        child: Column(children: [
          Container(
            width: width,
            padding: const EdgeInsets.all(12),
            height: height ?? _height * 0.08,
            child: isNetworkImage == true
                ? SvgPicture.network(containerImage)
                : SvgPicture.asset(
                    containerImage,
                    color: CustomTheme.darkerBlack.withOpacity(0.8),
                  ),
          ),
          SizedBox(height: _height * 0.01),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: CustomTheme.darkerBlack.withOpacity(0.6),
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ]),
      ),
    );
  }
}
