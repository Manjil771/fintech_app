import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/size_utils.dart';
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
    final _height = SizeUtils.height;

    return InkWell(
      onTap: onContainerPress,
      child: Container(
        width: 100.wp,
        // color: Colors.red.withOpacity(0.5),
        height: 130,
        margin: margin,
        child: Column(
          children: [
            Container(
              height: 80,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: _theme.primaryColor.withOpacity(0.05),
              ),
              child: CustomCachedNetworkImage(
                fit: BoxFit.contain,
                url: RepositoryProvider.of<CoOperative>(context).baseUrl +
                    imageUrl,
              ),
            ),
            SizedBox(height: 8.hp),
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
