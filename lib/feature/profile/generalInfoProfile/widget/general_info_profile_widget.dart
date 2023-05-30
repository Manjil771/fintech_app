import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_detail_box.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/authentication/ui/screens/login_page.dart';

class GeneralInfoProfileWidget extends StatelessWidget {
  const GeneralInfoProfileWidget({Key? key}) : super(key: key);
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
                  title: "Personal Details",
                  detail: "Phone Number, Name , Address etc.",
                ),
                const Divider(thickness: 1),
                CommonDetailBox(
                  onBoxPressed: () {
                    RepositoryProvider.of<UserRepository>(context).logout();
                    NavigationService.pushReplacement(
                        target: const LoginPage());
                  },
                  leadingIcon: Assets.logoutIcon,
                  title: "Logout",
                  detail: "Logout from this application.",
                ),
              ]),
            ),
          ],
        ));
  }
}
