import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:flutter/material.dart';

class OnboardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return PageWrapper(
      body: Center(
        child: Text(
          "Onboarding page",
          style: _textTheme.titleLarge,
        ),
      ),
    );
  }
}
