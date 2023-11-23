import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_detail_box.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/setting/changeMpin/screen/change_mpin_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageWrapper(
        body: CommonContainer(
          showDetail: false,
          showTitleText: false,
          showRoundBotton: false,
          verticalPadding: 0,
          topbarName: "Settings",
          body: Column(
            children: [
              // CommonDetailBox(
              //     onBoxPressed: () {},
              //     leadingIcon: "assets/icons/modesettings.svg",
              //     detail: "Change to internet of sms mode",
              //     title: "Mode Settings"),
              // const Divider(
              //   thickness: 1,
              // ),
              // CommonDetailBox(
              //     leadingIcon: "assets/icons/user-cirlce-add-svgrepo-com 2.svg",
              //     onBoxPressed: () {},
              //     detail: "Add bank account",
              //     title: "Add Beneficiary"),
              // const Divider(
              //   thickness: 1,
              // ),
              // CommonDetailBox(
              //     leadingIcon: "assets/icons/user-cirlce-add-svgrepo-com 2.svg",
              //     onBoxPressed: () {},
              //     detail: "Add Favourite Account ",
              //     title: "Favourite Account"),
              // const Divider(thickness: 1),
              CommonDetailBox(
                  leadingImage: "assets/icons/pin-code-svgrepo-com 1.svg",
                  onBoxPressed: () {
                    NavigationService.push(target: const ChangeMpinPage());
                  },
                  detail: "Change mPin frequently to be secure",
                  title: "Change mPin"),
              // const Divider(thickness: 1),
              // CommonDetailBox(
              //     leadingImage: "assets/icons/Vector-3.svg",
              //     onBoxPressed: () {},
              //     detail: "OTP Validations",
              //     title: "Validations"),
              const Divider(thickness: 1),

              const CommonDetailBox(
                  leadingImage: "assets/icons/privacy policy.svg",
                  onBoxPressed: _launchUrl,
                  detail: "View complete privacy policy",
                  title: "Privacy Policy"),
              const Divider(thickness: 1),
              CommonDetailBox(
                onBoxPressed: () {
                  showPopUpDialog(
                    context: context,
                    message: "Are you sure you want to logout.",
                    title: "Alert",
                    buttonText: "Logout",
                    buttonCallback: () {
                      RepositoryProvider.of<UserRepository>(context).logout();
                      NavigationService.pushNamedAndRemoveUntil(
                        routeName: Routes.loginPage,
                      );
                    },
                  );
                },
                leadingImage: Assets.logoutIcon,
                title: "Logout",
                detail: "Logout from this application.",
              ),
              const Divider(thickness: 1),

              // CommonDetailBox(
              //     leadingIcon: "assets/icons/biometricsetup.svg",
              //     onBoxPressed: () {},
              //     detail: "Setup fingerprint, face id and pin.",
              //     title: "Biometrics Setup"),
            ],
          ),
        ),
      ),
    );
  }
}

final Uri _url = Uri.parse('https://devanasoft.com.np/PrivacyPolicy.html');
Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
