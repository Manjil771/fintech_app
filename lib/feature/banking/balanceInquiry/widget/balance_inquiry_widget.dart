import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';

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
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
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
                      height: _height * 0.6,
                      child: ListView.builder(
                          itemCount: _detail.accountDetail.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                // color: const Color(0xFFF3F3F3),
                                border: Border.all(color: _theme.primaryColor),
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
                                            SizedBox(height: _height * 0.005),
                                            Text(
                                                "NPR ${_detail.accountDetail[index].actualBalance}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall),
                                          ],
                                        ),
                                        Image.asset(
                                          RepositoryProvider.of<CoOperative>(
                                                  context)
                                              .coOperativeLogo,
                                          height: _height * 0.055,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: _theme.scaffoldBackgroundColor,
                                      border: Border.all(
                                          color: _theme.primaryColor),
                                    ),
                                    child: Column(
                                      children: [
                                        detailROw(context, "Client Code",
                                            "${_detail.accountDetail[index].clientCode}"),
                                        detailROw(context, "Accured Interest",
                                            "NPR ${_detail.accountDetail[index].accruedInterest}"),
                                        detailROw(context, "Acc Number",
                                            "${_detail.accountDetail[index].mainCode}"),
                                        detailROw(context, "Interest Rate",
                                            "${_detail.accountDetail[index].interestRate} %"),
                                        detailROw(context, "Acc Holder’s Name",
                                            "${_detail.accountDetail[index].accountHolderName}"),
                                        detailROw(context, "Branch",
                                            "${_detail.accountDetail[index].branchName}"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
        topbarName: "Banking",
        title: "Balance Inquiry",
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
