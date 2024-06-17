import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:share_plus/share_plus.dart';

class BalanceInquiryWidget extends StatefulWidget {
  const BalanceInquiryWidget({Key? key}) : super(key: key);

  @override
  State<BalanceInquiryWidget> createState() => _BalanceInquiryWidgetState();
}

class _BalanceInquiryWidgetState extends State<BalanceInquiryWidget> {
  ValueNotifier<CustomerDetailModel?> customerDetail = ValueNotifier(null);

  @override
  void initState() {
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
                    return Container(
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _detail.accountDetail.length,
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
                                                Text("Total Balance",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall),
                                                SizedBox(
                                                    height: _height * 0.005),
                                                Text(
                                                    "NPR ${_detail.accountDetail[index].actualBalance}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall),
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
                                                "Available Balance",
                                                "NPR " +
                                                    _detail.accountDetail[index]
                                                        .availableBalance),
                                            detailROw(
                                                context,
                                                "Actual Balance",
                                                "NPR " +
                                                    _detail.accountDetail[index]
                                                        .actualBalance),
                                            detailROw(context, "Member ID",
                                                "${_detail.accountDetail[index].clientCode}"),
                                            detailROw(context, "Account Type",
                                                "${_detail.accountDetail[index].accountType}"),
                                            detailROw(context, "Acc Number",
                                                "${_detail.accountDetail[index].mainCode}"),
                                            if (_detail.accountDetail[index]
                                                        .interestRate !=
                                                    "0" &&
                                                _detail.accountDetail[index]
                                                        .interestRate
                                                        .toString() !=
                                                    "N/A" &&
                                                _detail.accountDetail[index]
                                                        .interestRate
                                                        .toString()
                                                        .toLowerCase() !=
                                                    "null")
                                              Column(
                                                children: [
                                                  detailROw(
                                                      context,
                                                      "Interest Rate",
                                                      "${_detail.accountDetail[index].interestRate} %"),
                                                  detailROw(
                                                      context,
                                                      "Accured Interest",
                                                      "NPR ${_detail.accountDetail[index].accruedInterest}"),
                                                ],
                                              ),
                                            detailROw(
                                                context,
                                                "Acc Holder’s Name",
                                                "${_detail.accountDetail[index].accountHolderName}"),
                                            detailROw(context, "Branch",
                                                "${_detail.accountDetail[index].branchName}"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 150,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CommonGridViewContainer(
                                          onContainerPress: () async {
                                            final bankName = RepositoryProvider
                                                    .of<CoOperative>(context)
                                                .appTitle;
                                            await Share.share(
                                              'Account Holder Name: ${_detail.accountDetail[index].accountHolderName} \nAccount NUmber: ${_detail.accountDetail[index].mainCode} \nBank Name: $bankName \nBranch Name: ${_detail.accountDetail[index].branchName} ',
                                            );
                                          },
                                          isNetworkImage: false,
                                          containerImage:
                                              'assets/icons/share.svg',
                                          title: 'Share Account Details',
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
        topbarName: "Balance Inquiry",
        detail: "Details about your account is shown below.",
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
