import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/util/size_utils.dart';

class NoDataScreen extends StatelessWidget {
  final String title;
  final String details;

  const NoDataScreen({Key? key, required this.title, required this.details})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          Assets.errorImage,
          height: _height * 0.4,
        ),
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: _textTheme.displayLarge,
          ),
        ),
        Text(
          details,
          textAlign: TextAlign.center,
          style: _textTheme.headlineSmall,
        ),
      ],
    );
  }
}
