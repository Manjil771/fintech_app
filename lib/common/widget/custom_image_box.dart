import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';

// ignore: must_be_immutable
class CustomImageBox extends StatelessWidget {
  final String image;
  final double imageHeight;
  final String? title;
  final bool isSvgPicture;
  final void Function()? onPressed;
  final double borderRadius;
  Color backgroundColor;
  Color iconColor;
  final double verticalPadding;
  final double horizontalPadding;
  final double iconSize;
  final bool shadow;
  final bool isNetworkImage;
   CustomImageBox({
    Key? key,
    required this.image,
    this.imageHeight = 20,
    this.isSvgPicture = false,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = 50,
    this.backgroundColor = CustomTheme.lightGray,
    this.iconColor = CustomTheme.darkGray,
    this.horizontalPadding = 12,
    this.verticalPadding = 12,
    this.iconSize = 18,
    this.shadow = true,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          if (shadow)
            const BoxShadow(
              color: CustomTheme.shadowColor,
              offset: Offset(0, -1),
              blurRadius: 10,
            ),
        ],
      ),
      child: Material(
        color: backgroundColor,
        elevation: 0,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            width: 100.wp,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Column(
              children: [
                isNetworkImage == true
                    ? CustomCachedNetworkImage(
                        url: image, height: 20.hp, fit: BoxFit.fitHeight)
                    : SvgPicture.asset(
                        image,
                        height: 20.hp,
                        fit: BoxFit.fitHeight,
                      ),
                isSvgPicture == true
                    ? SvgPicture.network(image,
                        height: imageHeight.hp, fit: BoxFit.fitHeight)
                    : Container(),
                SizedBox(height: 5.hp),
                title != null
                    ? Text(
                        title.toString(),
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
