import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/profile/generalInfoProfile/widget/general_info_profile_widget.dart';

class GeneralInfoProfilePage extends StatefulWidget {
  const GeneralInfoProfilePage({Key? key}) : super(key: key);

  @override
  State<GeneralInfoProfilePage> createState() => _GeneralInfoProfilePageState();
}

class _GeneralInfoProfilePageState extends State<GeneralInfoProfilePage> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return const GeneralInfoProfileWidget();
  }
}
