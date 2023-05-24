import 'package:flutter/material.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/scaffold_topbar.dart';

import '../util/size_utils.dart';

class CommonContainer extends StatelessWidget {
  final Widget body;
  final String topbarName;
  final String title;
  final String buttonName;

  final String detail;
  final bool showBackBotton;
  final bool showRoundBotton;

  final Function()? onButtonPressed;
  const CommonContainer({
    this.showBackBotton = true,
    this.buttonName = "Button Name",
    this.showRoundBotton = true,
    required this.body,
    required this.topbarName,
    this.onButtonPressed,
    required this.title,
    required this.detail,
  });
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _height = SizeUtils.height;
    return Column(
      children: [
        ScaffoldTopBar(name: topbarName, back: showBackBotton),
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12))),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(title, style: _textTheme.titleLarge),
              Text(
                detail,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: _height * 0.01),
              Text("Choose Service Provider", style: _textTheme.titleMedium),
              showRoundBotton
                  ? CustomRoundedButtom(title: buttonName, onPressed: () {})
                  : Container(),
            ],
          ),
        )
      ],
    );
  }
}
