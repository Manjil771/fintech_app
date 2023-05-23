import 'package:flutter/material.dart';

import '../../../../../common/util/size_utils.dart';

class PaymentDetailWidget extends StatelessWidget {
  final String title;
  final String details;

  const PaymentDetailWidget(
      {super.key, required this.title, required this.details});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return Row(
      children: [
        SizedBox(
          width: _width * 0.32,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: "popin",
            ),
          ),
        ),
        Expanded(
          child: Text(
            details,
            style: const TextStyle(
              fontFamily: "popinmedium",
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
