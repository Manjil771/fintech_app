import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/dashboard/widgets/dashboard_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return const DashBoardWidget();
    // return FGBGNotifier(
    //   onEvent: (FGBGType value) {
    //     print(value);
    //     if (value == FGBGType.background) {
    //       RepositoryProvider.of<UserRepository>(context).logout();
    //     }
    //   },
    //   child: const DashBoardWidget(),
    // );
  }
}
