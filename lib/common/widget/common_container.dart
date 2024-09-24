import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/fonts.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/primary_account_box.dart';
import 'package:ismart/common/widget/scaffold_topbar.dart';
import 'package:ismart/common/wrapper/bottom_sheet_wrapper.dart';
import 'package:ismart/feature/history/models/recent_transaction_model.dart';
import 'package:ismart/feature/history/screen/recent_transaction_service_page.dart';

import '../util/size_utils.dart';

class CommonContainer extends StatelessWidget {
  final bool? validateMobileBankingStatus;
  final Widget body;
  final String? serviceName;
  final String serviceCategoryId;
  final String? serviceId;

  final String associatedId;
  final bool showRecentTransaction;
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
  final VoidCallback? onBackPressed;

  final Function(RecentTransactionModel)? onRecentTransactionPressed;

  final Function()? onButtonPressed;
  const CommonContainer({
    this.serviceCategoryId = "",
    this.showDetail = false,
    this.showRecentTransaction = false,
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
    this.serviceName,
    this.onRecentTransactionPressed,
    this.serviceId = "",
    this.onBackPressed,
    this.validateMobileBankingStatus = true,
  });
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _height = SizeUtils.height;

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
            ScaffoldTopBar(
                name: topbarName,
                showBackButton: showBackBotton,
                onBackPressed: onBackPressed ?? () => NavigationService.pop()),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (title.isNotEmpty)
                                  Text(title,
                                      style: _textTheme.displaySmall!.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                if (detail.isNotEmpty)
                                  Text(
                                    detail,
                                    style: _textTheme.titleLarge,
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
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
                                PrimaryAccountBox(
                                  validateMobileBankingStatus:
                                      validateMobileBankingStatus,
                                ),
                              ],
                            )
                          : Container(),
                      if (showRecentTransaction)
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
                                    serviceId: "",
                                    onRecentTransactionPressed: (a) {
                                      NavigationService.pop();
                                    },
                                    serviceCategoryId: serviceCategoryId,
                                    associatedId: associatedId,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (showRecentTransaction)
                                RecentTransactionServiceScreen(
                                    serviceId: serviceId ?? "",
                                    onRecentTransactionPressed:
                                        onRecentTransactionPressed ?? (v) {},
                                    service: serviceName,
                                    serviceCategoryId: serviceCategoryId,
                                    associatedId: associatedId),
                            ],
                          ),
                        ),
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
          ],
        ),
      ),
    );
  }
}
