import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/env.dart';

import '../../../common/util/size_utils.dart';

class DashBoardUserWidget extends StatefulWidget {
  const DashBoardUserWidget({Key? key}) : super(key: key);

  @override
  State<DashBoardUserWidget> createState() => _DashBoardUserWidgetState();
}

class _DashBoardUserWidgetState extends State<DashBoardUserWidget> {
  bool showAmountDetail = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18), color: CustomTheme.white),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            height: _height * 0.16,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(CoOperativeValue.development.bannerImage),
                fit: BoxFit.fitWidth,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "popinsemibold",
                  ),
                ),
                const Text(
                  "...",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "popinsemibold",
                  ),
                ),
                // const Spacer(),
                Row(
                  children: [
                    InkWell(
                      child: Row(
                        children: [
                          const Text(
                            "Saving A/C : 0007122",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: "popin",
                            ),
                          ),
                          SizedBox(width: _width * 0.02),
                          SvgPicture.asset(
                            "assets/icons/downarrow.svg",
                            height: _height * 0.01,
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Interest Rate: 8.00%",
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: "popin",
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
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      showAmountDetail ? "NPR 123453.98" : "XXXXXXXXX",
                      style: Theme.of(context).textTheme.titleMedium,
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
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      showAmountDetail ? "5083.98" : "XXXXXXXXX",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
