import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/fonts.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/primary_account_box.dart';
import 'package:ismart/common/widget/scaffold_topbar.dart';
import 'package:ismart/common/wrapper/bottom_sheet_wrapper.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/history/screen/recent_transaction_service_page.dart';
import 'package:ismart/feature/history/widget/recent_transaction_service_widget.dart';
import '../util/size_utils.dart';

class CommonContainer extends StatelessWidget {
  final Widget body;

  final String serviceCategoryId;
  final String associatedId;
  final bool showBottomSheet;
  final String accountTitle;
  final bool showAccountSelection;
  final String topbarName;
  final String title;
  final bool showDetail;
  final String buttonName;
  final String detail;
  final bool showBackBotton;
  final bool showRoundBotton;
  final bool showTitleText;
  final double verticalPadding;
  final double horizontalPadding;

  final Function()? onButtonPressed;
  const CommonContainer({
    this.serviceCategoryId = "",
    this.showDetail = false,
    this.showBottomSheet = false,
    this.accountTitle = "From Account",
    this.showAccountSelection = false,
    this.verticalPadding = 20.0,
    this.horizontalPadding = 20.0,
    this.showTitleText = true,
    this.showBackBotton = true,
    this.buttonName = "Button Name",
    this.showRoundBotton = true,
    required this.body,
    required this.topbarName,
    this.onButtonPressed,
    this.title = "",
    this.detail = "",
    this.associatedId = "",
  });
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;

    return PageWrapper(
      showAppBar: false,
      padding: EdgeInsets.zero,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.hp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScaffoldTopBar(name: topbarName, showBackButton: showBackBotton),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      showTitleText
                          ? Text(title,
                              style: _textTheme.displaySmall!
                                  .copyWith(fontWeight: FontWeight.bold))
                          : Container(),
                      showDetail
                          ? Text(
                              detail,
                              style: _textTheme.titleLarge,
                            )
                          : Container(),
                      SizedBox(height: _height * 0.01),
                      showAccountSelection
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  accountTitle,
                                  style: const TextStyle(
                                    fontFamily: Fonts.poppin,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: CustomTheme.lightTextColor,
                                  ),
                                ),
                                PrimaryAccountBox(),
                              ],
                            )
                          : Container(),
                      SizedBox(height: _height * 0.01),
                      body,
                      SizedBox(height: _height * 0.03),
                      showRoundBotton
                          ? CustomRoundedButtom(
                              title: buttonName, onPressed: onButtonPressed)
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
            if (showBottomSheet)
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => BottomSheetWrapper(
                        backgroundColor: CustomTheme.white,
                        showTopDivider: true,
                        title: "Recent Transaction",
                        child: Expanded(
                          child: RecentTransactionServiceScreen(
                            serviceCategoryId: serviceCategoryId,
                            associatedId: associatedId,
                          ),
                        )),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _theme.primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  width: _width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.hp, vertical: 10.hp),
                  child: Container(
                      child: Center(
                    child: Text(
                      "Recent Transaction",
                      style: _textTheme.labelLarge!
                          .copyWith(color: CustomTheme.white),
                    ),
                  )),
                ),
              )
          ],
        ),
      ),
    );
  }
}
