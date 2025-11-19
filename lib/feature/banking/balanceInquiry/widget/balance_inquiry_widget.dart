import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:share_plus/share_plus.dart';

class BalanceInquiryWidget extends StatefulWidget {
  const BalanceInquiryWidget({Key? key}) : super(key: key);

  @override
  State<BalanceInquiryWidget> createState() => _BalanceInquiryWidgetState();
}

class _BalanceInquiryWidgetState extends State<BalanceInquiryWidget> {
  ValueNotifier<CustomerDetailModel?> customerDetail = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    customerDetail = RepositoryProvider.of<CustomerDetailRepository>(context)
        .customerDetailModel;
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _height = SizeUtils.height;

    Widget _getCoOpLogo() {
      final String _coOpLogo =
          RepositoryProvider.of<CoOperative>(context).coOperativeLogo;

      if (_coOpLogo.contains("https://")) {
        return Image.network(
          _coOpLogo,
          height: _height * 0.055,
        );
      } else {
        return Image.asset(
          _coOpLogo,
          height: _height * 0.055,
        );
      }
    }

    return PageWrapper(
      body: CommonContainer(
        showDetail: true,
        showRoundBotton: false,
        body: Column(
          children: [
            Container(
              child: ValueListenableBuilder(
                valueListenable: customerDetail,
                builder: (context, value, child) {
                  if (value != null) {
                    final _detail = customerDetail.value!;
                    final List<AccountDetail> showValidAccount = _detail
                        .accountDetail
                        .where((element) =>
                            element.accountType.toLowerCase() == "saving" ||
                            element.accountType.toLowerCase() == "current" ||
                            element.accountType.toLowerCase() == "fixeddeposit")
                        .toList();
                    return Container(
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: showValidAccount.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    // color: const Color(0xFFF3F3F3),
                                    border:
                                        Border.all(color: _theme.primaryColor),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    LocaleKeys.totalbalance
                                                        .tr(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall),
                                                SizedBox(
                                                    height: _height * 0.005),
                                                Text(
                                                  "${LocaleKeys.NPR.tr()} ${showValidAccount[index].actualBalance}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall,
                                                ),
                                              ],
                                            ),
                                            _getCoOpLogo(),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(16.0),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          color: _theme.scaffoldBackgroundColor,
                                          border: Border.all(
                                              color: _theme.primaryColor),
                                        ),
                                        child: Column(
                                          children: [
                                            detailROw(
                                                context,
                                                LocaleKeys.availablebalance
                                                    .tr(),
                                                LocaleKeys.NPR.tr() +
                                                    showValidAccount[index]
                                                        .availableBalance
                                                        .toString()),
                                            detailROw(
                                                context,
                                                LocaleKeys.actualbalance.tr(),
                                                LocaleKeys.NPR.tr() +
                                                    showValidAccount[index]
                                                        .actualBalance),
                                            detailROw(
                                                context,
                                                LocaleKeys.memberID.tr(),
                                                "${showValidAccount[index].clientCode}"),
                                            detailROw(
                                                context,
                                                LocaleKeys.accNumber.tr(),
                                                "${showValidAccount[index].mainCode}"),
                                            detailROw(context, "Acc Type",
                                                "${(showValidAccount[index].accountTypeDescription.isEmpty) ? showValidAccount[index].accountType : showValidAccount[index].accountTypeDescription}"),
                                            if (showValidAccount[index]
                                                        .interestRate !=
                                                    "0" ||
                                                showValidAccount[index]
                                                        .interestRate
                                                        .toString() !=
                                                    "N/A")
                                              if ((double.tryParse(
                                                          showValidAccount[
                                                                  index]
                                                              .interestRate) ??
                                                      0) >
                                                  0.1)
                                                detailROw(
                                                    context,
                                                    LocaleKeys.interestRate
                                                        .tr(),
                                                    "${showValidAccount[index].interestRate} %"),
                                            if ((double.tryParse(
                                                        showValidAccount[index]
                                                            .accruedInterest) ??
                                                    0) >
                                                0.1)
                                              detailROw(
                                                context,
                                                LocaleKeys.accuredInterest.tr(),
                                                "${LocaleKeys.NPR.tr()} ${showValidAccount[index].accruedInterest}",
                                              ),
                                            detailROw(
                                                context,
                                                LocaleKeys.accountHolderName
                                                    .tr(),
                                                "${showValidAccount[index].accountHolderName}"),
                                            detailROw(
                                                context,
                                                LocaleKeys.branch.tr(),
                                                "${showValidAccount[index].branchName}"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CommonGridViewContainer(
                                          onContainerPress: () async {
                                            final bankName = RepositoryProvider
                                                    .of<CoOperative>(context)
                                                .appTitle;
                                            await Share.share(
                                              'Account Holder Name: ${showValidAccount[index].accountHolderName} \nAccount Number: ${showValidAccount[index].mainCode} \nCoop Name: ${customerDetail.value?.bank} \nBranch Name: ${showValidAccount[index].branchName} ',
                                            );
                                          },
                                          isNetworkImage: false,
                                          containerImage:
                                              'assets/icons/share.svg',
                                          title: LocaleKeys.shareAccount.tr(),
                                        ),
                                      ),
                                      Expanded(child: Container()

                                          // CommonGridViewContainer(
                                          //     isNetworkImage: false,
                                          //     containerImage: Assets.statement,
                                          //     title: 'Download \nStatements'),
                                          ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
        topbarName: LocaleKeys.balanceinquiry.tr(),
        detail: LocaleKeys.detailAboutBalance.tr(),
      ),
    );
  }

  detailROw(context, title, detail) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                width: 130,
                child:
                    Text(title, style: Theme.of(context).textTheme.titleSmall)),
            Expanded(
                child: Align(
              alignment: Alignment.centerRight,
              child:
                  Text(detail, style: Theme.of(context).textTheme.titleSmall),
            )),
          ],
        ),
        SizedBox(
          height: SizeUtils.height * 0.02,
        )
      ],
    );
  }
}
