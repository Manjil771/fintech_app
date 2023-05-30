import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/common/util/size_utils.dart';

class PrimaryAccount extends StatelessWidget {
  const PrimaryAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return InkWell(
      onTap: () {
        // showDialog(context: context, builder: (context) => const AccountList());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.all(18),
        width: double.infinity,
        height: _width * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black45),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/Wallet amount.svg",
                  height: _height * 0.023,
                  color: _theme.primaryColor,
                ),
                SizedBox(width: _width * 0.03),
                Text(
                  "NPR 123546846",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "popinsemibold",
                      color: _theme.primaryColor),
                ),
                const Spacer(),
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
                Text("Ismart Bikash Bank Ltd.",
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
                  "ER65596565",
                  style: _textTheme.labelMedium,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
