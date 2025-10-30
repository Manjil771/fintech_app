import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';

class SelectHistoryOptions extends StatefulWidget {
  const SelectHistoryOptions({super.key});

  @override
  State<SelectHistoryOptions> createState() => _SelectHistoryOptionsState();
}

class _SelectHistoryOptionsState extends State<SelectHistoryOptions> {
  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      showDetail: false,
      topbarName: "History",
      showTitleText: false,
      showRoundBotton: false,
      showBackBotton: false,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            // height: _height * 0.7,
            child: Container(
                child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) => CommonGridViewContainer(
                onContainerPress: () {
                  NavigationService.pushNamed(routeName: onPress[index]);
                },
                margin: const EdgeInsets.all(8),
                containerImage: images[index],
                title: itemName[index],
              ),
            )),
          ),
        ],
      ),
    );
  }

  final itemName = [
    LocaleKeys.fullStatement.tr(),
    "Recent Transaction",
  ];
  final images = [
    Assets.statement,
    Assets.historyIcon,
  ];
  final onPress = [
    Routes.chooseAccountFullStatement,
    Routes.recentTransactionScreen,
  ];
}
