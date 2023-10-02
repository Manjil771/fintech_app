import 'package:flutter/material.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';

class ScreenAppBar extends StatelessWidget {
  final String title;
  const ScreenAppBar({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return Container(
      color: _theme.primaryColor.withOpacity(0.05),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                NavigationService.pop();
              },
              icon: Icon(Icons.arrow_back)),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: _textTheme.titleLarge!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
