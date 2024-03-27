import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/util/size_utils.dart';

class RemitBoxDesign extends StatelessWidget {
  final bool isNetworkImage;
  final String containerImage;
  final String title;
  final Function()? onContainerPress;
  final EdgeInsets? margin;
  final double? height;
  final double? width;

  const RemitBoxDesign(
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
        width: 100.wp,
        margin: margin,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: _theme.primaryColor.withOpacity(0.05),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: isNetworkImage == true
                    ? Image.network(
                        containerImage,
                        fit: BoxFit.fitWidth,
                      )
                    : Image.asset(
                        fit: BoxFit.fitWidth,
                        containerImage,
                      ),
              ),
            ),
            SizedBox(height: 8.hp),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: CustomTheme.darkerBlack.withOpacity(0.6),
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
