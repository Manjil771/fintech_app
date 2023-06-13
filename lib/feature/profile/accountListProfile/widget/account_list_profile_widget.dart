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
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';

class AccountListProfileWidget extends StatefulWidget {
  final ValueNotifier<CustomerDetailModel?> customerDetail;
  const AccountListProfileWidget({Key? key, required this.customerDetail})
      : super(key: key);

  @override
  State<AccountListProfileWidget> createState() =>
      _AccountListProfileWidgetState();
}

class _AccountListProfileWidgetState extends State<AccountListProfileWidget> {
  bool showPersonalDetail = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    final _detail = widget.customerDetail.value!;
    bool showPrimaryAccount = false;
    bool showSecondaryAccount = false;

    return PageWrapper(
      padding: EdgeInsets.zero,
      showAppBar: false,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: widget.customerDetail.value!.accountDetail.length,
                itemBuilder: (context, index) {
                  final _detail = widget.customerDetail.value!;

                  return Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ExpansionTile(
                          title: CommonDetailBox(
                              showTrailingIcon: false,
                              leadingIcon: Assets.profileIcon,
                              title: accountType[index],
                              detail:
                                  "A/C : ${_detail.accountDetail[index].mainCode}",
                              onBoxPressed: () {
                                //if (_detail.accountDetail[index] == 0) {
                                setState(() {
                                  showPrimaryAccount = !showPrimaryAccount;
                                });
                                print(showPrimaryAccount);
                                //}
                              }),
                          children: [
                            Container(
                              color: _theme.scaffoldBackgroundColor,
                              height: _height * 0.19,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: buildDetails(
                                            context,
                                            "Banking.svg",
                                            "Account Type",
                                            "${_detail.accountDetail[index].accountType} A/C"),
                                      ),
                                      SizedBox(
                                        width: _width * 0.4,
                                        child: buildDetails(
                                            context,
                                            "clientcode.svg",
                                            "Client Code",
                                            "${_detail.accountDetail[index].id}"),
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
                                            "NPR ${_detail.accountDetail[index].accruedInterest}"),
                                      ),
                                      SizedBox(
                                        width: _width * 0.4,
                                        child: buildDetails(
                                            context,
                                            "interest rate profile.svg",
                                            "Interest Rate",
                                            "${_detail.accountDetail[index].interestRate} %"),
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
                                            "NPR ${_detail.accountDetail[index].actualBalance}"),
                                      ),
                                      SizedBox(
                                        width: _width * 0.4,
                                        child: buildDetails(
                                            context,
                                            "money-send-svgrepo-com 1.svg",
                                            "Available Bal.",
                                            "NPR ${_detail.accountDetail[index].availableBalance}"),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  final List accountType = ["Primary Account", "Secondary Account"];

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
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        )
      ],
    );
  }
}
