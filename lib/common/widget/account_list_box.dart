import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';

class AccountDetailBox extends StatefulWidget {
  ValueNotifier<CustomerDetailModel?> customerDetail;

  AccountDetailBox({super.key, required this.customerDetail});

  @override
  State<AccountDetailBox> createState() => _AccountDetailBoxState();
}

class _AccountDetailBoxState extends State<AccountDetailBox> {
  @override
  Widget build(BuildContext context) {
    final _customerDetailRepo =
        RepositoryProvider.of<CustomerDetailRepository>(context);
    int myIndex = 0;
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;

    return Container(
      child: ValueListenableBuilder<AccountDetail?>(
          valueListenable: _customerDetailRepo.selectedAccount,
          builder: (context, selectedAccount, _) {
            return ValueListenableBuilder<CustomerDetailModel?>(
              valueListenable: widget.customerDetail,
              builder: (context, val, _) {
                if (val != null) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 100, horizontal: 20),
                    padding: const EdgeInsets.all(18),
                    width: double.infinity,
                    height: _width * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: CustomTheme.white,
                      //color: myIndex == index ? const Color(cECF4FF) : const Color(cF4F4F9),
                      border: Border.all(color: Colors.black45),
                    ),
                    child: ListView.builder(
                        itemCount: val.accountDetail.length,
                        itemBuilder: (context, index) {
                          final account = val.accountDetail[index];
                          final _isSelectedAccount = account.accountNumber
                              .toLowerCase()
                              .contains(selectedAccount?.accountNumber ?? "");
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.all(18),
                                  width: double.infinity,
                                  height: _width * 0.35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: _isSelectedAccount
                                          ? CustomTheme.primaryColor
                                          : CustomTheme.gray,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            Assets.walletIcon,
                                            height: _height * 0.023,
                                            color: _theme.primaryColor,
                                          ),
                                          SizedBox(width: _width * 0.03),
                                          Text(
                                            "NPR ${account.actualBalance}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "popinsemibold",
                                                color: _theme.primaryColor),
                                          ),
                                          const Spacer(),
                                          myIndex == index
                                              ? Container(
                                                  width: _width * 0.2,
                                                  height: _width * 0.06,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: _theme.primaryColor,
                                                    // border: Border.all(color: Colors.black),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      "Primary",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            Assets.bankingIcon,
                                            height: _height * 0.023,
                                            color: _theme.primaryColor,
                                          ),
                                          SizedBox(width: _width * 0.03),
                                          Expanded(
                                            child: Text(account.accountType,
                                                style: _theme
                                                    .textTheme.labelLarge),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            Assets.personIcon,
                                            height: _height * 0.023,
                                            color: _theme.primaryColor,
                                          ),
                                          SizedBox(width: _width * 0.03),
                                          Text(
                                            account.mainCode,
                                            style: _textTheme.labelMedium,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }
                {
                  return Container();
                }
              },
            );
          }),
    );
  }
}
