import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/profile/widget/profile_screen_tabbar_widget.dart';

class ProfileTabbarPage extends StatefulWidget {
  const ProfileTabbarPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabbarPage> createState() => _ProfileTabbarPageState();
}

class _ProfileTabbarPageState extends State<ProfileTabbarPage> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return const ProfileTabBarWidget();
  }
}
