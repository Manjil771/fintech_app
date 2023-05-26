import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/profile/generalInfoProfile/widget/general_info_profile_widget.dart';

class AccountListProfilePage extends StatelessWidget {
  const AccountListProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return const GeneralInfoProfileWidget();
  }
}
