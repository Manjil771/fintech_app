import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/util/size_utils.dart';

class RowIconTextWidget extends StatelessWidget {
  const RowIconTextWidget({Key? key, required this.icon, required this.text})
      : super(key: key);

  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Row(
      children: [
        Icon(icon),
        SizedBox(
          width: 5.hp,
        ),
        Text(
          "$text",
          style: _textTheme.headline6!.copyWith(
            color: CustomTheme.darkGray,
          ),
        ),
      ],
    );
  }
}
