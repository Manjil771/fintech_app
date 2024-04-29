import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_detail_box.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
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
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    bool showPrimaryAccount = false;

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
                              leadingImage: Assets.profileIcon,
                              title: _detail.accountDetail[index].accountType,
                              detail:
                                  "A/C : ${_detail.accountDetail[index].mainCode}",
                              onBoxPressed: () {
                                setState(() {
                                  showPrimaryAccount = !showPrimaryAccount;
                                });
                                print(showPrimaryAccount);
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
                                            "Member ID",
                                            "${_detail.accountDetail[index].clientCode}"),
                                      )
                                    ],
                                  ),
                                  if (_detail.accountDetail[index].interestRate
                                              .toString() !=
                                          "0.0" ||
                                      _detail.accountDetail[index].interestRate
                                              .toString() !=
                                          "0" ||
                                      _detail.accountDetail[index].interestRate
                                              .toString() !=
                                          "N/A")
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
                                    ),
                                  Row(
                                    children: [
                                      if (_detail.accountDetail[index]
                                              .accruedInterest
                                              .toString() !=
                                          "0")
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
    final Size size = MediaQuery.of(context).size;
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
