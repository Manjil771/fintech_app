import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/fonts.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/primary_account_box.dart';
import 'package:ismart/common/widget/scaffold_topbar.dart';
import '../util/size_utils.dart';

class CommonContainer extends StatelessWidget {
  final Widget body;
  final String accountTitle;
  final bool showAccountSelection;
  final String topbarName;
  final String title;
  final bool showDetail;
  final String buttonName;
  final String detail;
  final bool showBackBotton;
  final bool showRoundBotton;
  final bool showTitleText;
  final double verticalPadding;
  final double horizontalPadding;

  final Function()? onButtonPressed;
  const CommonContainer({
    required this.showDetail,
    this.accountTitle = "From Account",
    this.showAccountSelection = false,
    this.verticalPadding = 20.0,
    this.horizontalPadding = 20.0,
    this.showTitleText = true,
    this.showBackBotton = true,
    this.buttonName = "Button Name",
    this.showRoundBotton = true,
    required this.body,
    required this.topbarName,
    this.onButtonPressed,
    this.title = "",
    this.detail = "",
  });
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _height = SizeUtils.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          ScaffoldTopBar(name: topbarName, showBackButton: showBackBotton),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                showTitleText
                    ? Text(title,
                        style: _textTheme.displaySmall!
                            .copyWith(fontWeight: FontWeight.bold))
                    : Container(),
                showDetail
                    ? Text(
                        detail,
                        style: _textTheme.titleLarge,
                      )
                    : Container(),
                SizedBox(height: _height * 0.01),
                showAccountSelection
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            accountTitle,
                            style: TextStyle(
                              fontFamily: Fonts.poppin,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: CustomTheme.lightTextColor,
                            ),
                          ),
                          PrimaryAccountBox(),
                        ],
                      )
                    : Container(),
                SizedBox(height: _height * 0.01),
                body,
                SizedBox(height: _height * 0.03),
                showRoundBotton
                    ? CustomRoundedButtom(
                        title: buttonName, onPressed: onButtonPressed)
                    : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
