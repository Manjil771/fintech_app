import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/account_list_box.dart';

import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';

class HomePageUserWidget extends StatefulWidget {
  const HomePageUserWidget({Key? key}) : super(key: key);

  @override
  State<HomePageUserWidget> createState() => _HomePageUserWidgetState();
}

class _HomePageUserWidgetState extends State<HomePageUserWidget> {
  bool showAmountDetail = false;
  ValueNotifier<CustomerDetailModel?> customerDetail = ValueNotifier(null);
  ValueNotifier<dynamic> accountDetail = ValueNotifier([]);

  @override
  void initState() {
    customerDetail = RepositoryProvider.of<CustomerDetailRepository>(context)
        .customerDetailModel;
    accountDetail =
        RepositoryProvider.of<CustomerDetailRepository>(context).accountsList;
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: CustomTheme.white),
        child: ValueListenableBuilder<CustomerDetailModel?>(
            valueListenable: customerDetail,
            builder: (context, val, _) {
              if (val != null) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      height: _height * 0.16,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              RepositoryProvider.of<CoOperative>(context)
                                  .bannerImage),
                          fit: BoxFit.fitWidth,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Welcome",
                            style: _textTheme.headlineMedium?.copyWith(
                              color: CustomTheme.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            val.fullName,
                            overflow: TextOverflow.ellipsis,
                            style: _textTheme.headlineMedium?.copyWith(
                              color: CustomTheme.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // const Spacer(),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AccountDetailBox(
                                            customerDetail: customerDetail,
                                          ));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "${val.accountDetail[0].accountType} A/C : ${val.accountDetail[0].mainCode}",
                                      style: _textTheme.titleSmall?.copyWith(
                                        color: CustomTheme.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: _width * 0.02),
                                    SvgPicture.asset(
                                      Assets.arrowRight,
                                      height: _height * 0.01,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Interest Rate: ${val.accountDetail[0].interestRate} %",
                                    style: _textTheme.titleSmall?.copyWith(
                                      color: CustomTheme.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Actual Balance",
                                style: _textTheme.titleSmall,
                              ),
                              Text(
                                showAmountDetail
                                    ? "NPR ${val.accountDetail[0].actualBalance}"
                                    : "XXXXXXXXX",
                                style: _textTheme.titleLarge,
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                showAmountDetail = !showAmountDetail;
                              });
                            },
                            child: SvgPicture.asset(
                              "assets/icons/akar-icons_eye-slashed.svg",
                              height: _height * 0.03,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Interest Accrued",
                                style: _textTheme.titleSmall,
                              ),
                              Text(
                                showAmountDetail
                                    ? "NPR ${val.accountDetail[0].accruedInterest}"
                                    : "XXXXXXXXX",
                                style: _textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            }));
  }
}
