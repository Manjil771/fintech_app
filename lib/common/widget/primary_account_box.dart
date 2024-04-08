import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/account_list_box.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';

class PrimaryAccountBox extends StatefulWidget {
  @override
  State<PrimaryAccountBox> createState() => _PrimaryAccountBoxState();
}

class _PrimaryAccountBoxState extends State<PrimaryAccountBox> {
  bool showAmount = true;

  @override
  Widget build(BuildContext context) {
    final _customerDetailRepo =
        RepositoryProvider.of<CustomerDetailRepository>(context);
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return ValueListenableBuilder<AccountDetail?>(
        valueListenable: _customerDetailRepo.selectedAccount,
        builder: (context, selectedAcc, _) {
          return InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const AccountDetailBox(),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              padding: const EdgeInsets.all(18),
              width: double.infinity,
              height: _width * 0.35,
              decoration: BoxDecoration(
                color: _theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(color: _theme.scaffoldBackgroundColor, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        showAmount
                            ? "XXXXXXX"
                            : "NPR ${selectedAcc?.availableBalance}",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "popinsemibold",
                            color: _theme.primaryColor),
                      ),
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                showAmount = !showAmount;
                              });
                            },
                            child: Icon(
                              showAmount
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            )),
                      ),
                      const Spacer(),
                      if (selectedAcc?.primary.toString() == "true")
                        Container(
                          width: _width * 0.2,
                          height: _width * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: _theme.primaryColor,
                            // border: Border.all(color: Colors.black),
                          ),
                          child: const Center(
                            child: Text(
                              "Primary",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/Banking.svg",
                        height: _height * 0.023,
                        color: _theme.primaryColor,
                      ),
                      SizedBox(width: _width * 0.03),
                      Text("${selectedAcc?.accountType}",
                          style: _theme.textTheme.labelLarge),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/Account Number.svg",
                        height: _height * 0.023,
                        color: _theme.primaryColor,
                      ),
                      SizedBox(width: _width * 0.03),
                      Text(
                        "${selectedAcc?.mainCode}",
                        style: _textTheme.labelMedium,
                      ),
                      const Spacer(),
                      RotatedBox(
                        quarterTurns: 5,
                        child: SvgPicture.asset(
                          Assets.arrowRight,
                          height: _height * 0.02,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
