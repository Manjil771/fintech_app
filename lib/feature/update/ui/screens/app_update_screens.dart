import 'package:flutter/material.dart';
import 'package:ismart/feature/update/ui/widgets/app_update_widgets.dart';

class AppUpdateScreens extends StatelessWidget {
  final bool isForceUpdate;
  const AppUpdateScreens({
    Key? key,
    required this.isForceUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppUpdateWidgets(
      isForceUpdate: isForceUpdate,
    );
  }
}
