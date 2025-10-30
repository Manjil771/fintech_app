import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';

class RemitBoxDesign extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Function()? onContainerPress;
  final EdgeInsets? margin;
  final double? height;
  final double? width;

  const RemitBoxDesign(
      {super.key,
      required this.imageUrl,
      this.margin = const EdgeInsets.all(8),
      required this.title,
      this.onContainerPress,
      this.height,
      this.width});
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return InkWell(
      onTap: onContainerPress,
      child: Container(
        margin: margin,
        child: Column(
          children: [
            Container(
              height: 56,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: _theme.primaryColor.withOpacity(0.05),
              ),
              child: CustomCachedNetworkImage(
                fit: BoxFit.contain,
                url: imageUrl,
              ),
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: CustomTheme.darkerBlack.withOpacity(0.6),
                    fontSize: 11,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
