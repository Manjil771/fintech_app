import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/size_utils.dart';

class TransactionDetailBox extends StatelessWidget {
  final bool isCredit;
  final String balance;
  final String title;

  final String desc;
  final String amount;
  final String dateTime;
  final Widget leadingImage;
  final String status;

  TransactionDetailBox(
      {Key? key,
      this.isCredit = false,
      required this.balance,
      required this.leadingImage,
      required this.desc,
      required this.amount,
      required this.dateTime,
      required this.status,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
              width: _width * 0.13,
              decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: leadingImage),
          SizedBox(width: _width * 0.04),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.bold)),
                Text(desc,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.labelLarge),
                Text(dateTime,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith()),
              ],
            ),
          ),
          SizedBox(width: _width * 0.04),
          SizedBox(
            width: _width * 0.2,
            child: Column(
              children: [
                Text(
                  "NPR $amount",
                  style: TextStyle(
                    fontFamily: "popinsemibold",
                    fontSize: 12,
                  ),
                ),
                Text(
                  status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "popinsemibold",
                    color:
                        status.toLowerCase().contains("Complete".toLowerCase())
                            ? CustomTheme.green
                            : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
