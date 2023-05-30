import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/util/size_utils.dart';

class AccountDetailBox extends StatelessWidget {
  final String accountBalance;
  final String branchName;
  final String accountNumber;
  bool isPrimaryAccount = false;

  AccountDetailBox(
      {super.key,
      required this.accountBalance,
      required this.branchName,
      required this.accountNumber});
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _height = SizeUtils.height;
    final _white = SizeUtils.width;

    return MaterialButton(
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: _theme.scaffoldBackgroundColor),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  Assets.walletIcon,
                  height: _height * 0.03,
                ),
                SizedBox(width: _white * 0.03),
                Text("NPR $accountBalance"),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Primary",
                      style: TextStyle(
                          color: CustomTheme.white,
                          backgroundColor: _theme.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: _height * 0.01),
            Row(
              children: [
                SvgPicture.asset(
                  Assets.bankingIcon,
                  height: _height * 0.03,
                ),
                SizedBox(width: _white * 0.03),
                Text(branchName),
              ],
            ),
            SizedBox(height: _height * 0.01),
            Row(
              children: [
                SvgPicture.asset(
                  Assets.personIcon,
                  height: _height * 0.03,
                ),
                SizedBox(width: _white * 0.03),
                Text(accountNumber),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
