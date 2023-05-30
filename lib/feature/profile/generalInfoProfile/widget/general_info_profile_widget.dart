import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_detail_box.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/authentication/ui/screens/login_page.dart';

class GeneralInfoProfileWidget extends StatefulWidget {
  const GeneralInfoProfileWidget({Key? key}) : super(key: key);

  @override
  State<GeneralInfoProfileWidget> createState() =>
      _GeneralInfoProfileWidgetState();
}

class _GeneralInfoProfileWidgetState extends State<GeneralInfoProfileWidget> {
  bool showPersonalDetail = false;

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
                onBoxPressed: () {
                  showPersonalDetail = !showPersonalDetail;
                  print(showPersonalDetail.toString());
                },
                leadingIcon: Assets.profileIcon,
                title: "Personal Details",
                detail: "Phone Number, Name , Address etc.",
              ),
              showPersonalDetail
                  ? Container(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      height: _height * 0.19,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: buildDetails(context, "Banking.svg",
                                    "Saving A/C", " A/C"),
                              ),
                              SizedBox(
                                width: _width * 0.4,
                                child: buildDetails(context, "clientcode.svg",
                                    "Client Code", "1234"),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: buildDetails(
                                    context,
                                    "accrued interest.svg",
                                    "Accrued Interest",
                                    "NPR tail[0].accruedInterest}"),
                              ),
                              SizedBox(
                                width: _width * 0.4,
                                child: buildDetails(
                                    context,
                                    "interest rate profile.svg",
                                    "Interest Rate",
                                    "{userController.accountDetail[0].interestRate}%"),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: buildDetails(
                                    context,
                                    "actual balance profile page.svg",
                                    "Actual Balance",
                                    "NPR ail[0].actualBalance}"),
                              ),
                              SizedBox(
                                width: _width * 0.4,
                                child: buildDetails(
                                    context,
                                    "money-send-svgrepo-com 1.svg",
                                    "Available Bal.",
                                    "NPR .availableBalance}"),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  : Container(),
              CommonDetailBox(
                onBoxPressed: () {},
                leadingIcon: Assets.logoutIcon,
                title: "Logout",
                detail: "Logout from this application.",
              ),
            ]),
          ),
        ],
      ),
    );
  }

  buildDetails(BuildContext context, images, title, value) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/$images",
          height: size.height * 0.025,
        ),
        SizedBox(width: size.width * 0.03),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        )
      ],
    );
  }
}
