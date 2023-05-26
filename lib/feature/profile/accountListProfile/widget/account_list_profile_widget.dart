import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_detail_box.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class AccountListProfileWidget extends StatelessWidget {
  const AccountListProfileWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
        padding: EdgeInsets.zero,
        showAppBar: false,
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                  color: CustomTheme.white,
                  borderRadius: BorderRadius.circular(12)),
              child: Column(children: [
                CommonDetailBox(
                  onBoxPressed: () {},
                  leadingIcon: Assets.profileIcon,
                  title: "Primary Account",
                  detail: "Account No : SA00987",
                ),
                const Divider(thickness: 1),
                CommonDetailBox(
                  onBoxPressed: () {},
                  leadingIcon: Assets.profileIcon,
                  title: "Secondary Account",
                  detail: "Account No : SA0065.",
                ),
              ]),
            ),
          ],
        ));
  }
}
