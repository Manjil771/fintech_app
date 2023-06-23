import 'package:flutter/material.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_detail_box.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/setting/changeMpin/screen/change_mpin_page.dart';

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
              CommonDetailBox(
                  leadingIcon: "assets/icons/user-cirlce-add-svgrepo-com 2.svg",
                  onBoxPressed: () {},
                  detail: "Add bank account",
                  title: "Add Beneficiary"),
              const Divider(
                thickness: 1,
              ),
              CommonDetailBox(
                  leadingIcon: "assets/icons/user-cirlce-add-svgrepo-com 2.svg",
                  onBoxPressed: () {},
                  detail: "Add Favourite Account ",
                  title: "Favourite Account"),
              const Divider(thickness: 1),
              CommonDetailBox(
                  leadingIcon: "assets/icons/pin-code-svgrepo-com 1.svg",
                  onBoxPressed: () {
                    NavigationService.push(target: ChangeMpinPage());
                  },
                  detail: "Change mPin frequently to be secure",
                  title: "Change mPin"),
              const Divider(thickness: 1),
              CommonDetailBox(
                  leadingIcon: "assets/icons/Vector-3.svg",
                  onBoxPressed: () {},
                  detail: "OTP Validations",
                  title: "Validations"),
              const Divider(thickness: 1),
              CommonDetailBox(
                  leadingIcon: "assets/icons/privacy policy.svg",
                  onBoxPressed: () {},
                  detail: "View complete privacy policy",
                  title: "Privacy Policy"),
              const Divider(thickness: 1),
              CommonDetailBox(
                  leadingIcon: "assets/icons/biometricsetup.svg",
                  onBoxPressed: () {},
                  detail: "Setup fingerprint, face id and pin.",
                  title: "Biometrics Setup"),
            ],
          ),
        ),
      ),
    );
  }
}
