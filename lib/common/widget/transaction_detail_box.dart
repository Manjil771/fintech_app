import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/size_utils.dart';

class TransactionDetailBox extends StatelessWidget {
  final bool isCredit;
  final String title;
  final String desc;
  final String amount;
  final String dateTime;
  final String imageUrl;
  final String status;

  const TransactionDetailBox(
      {Key? key,
      this.isCredit = true,
      required this.title,
      required this.desc,
      required this.amount,
      required this.dateTime,
      required this.imageUrl,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            width: _width * 0.12,
            height: _height * 0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Image.network(
              (RepositoryProvider.of<CoOperative>(context).baseUrl + imageUrl)
                  .replaceAll("//", "/"),
            ),
          ),
          SizedBox(width: _width * 0.05),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                Text(desc, style: Theme.of(context).textTheme.labelLarge),
                Text(dateTime, style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ),
          SizedBox(width: _width * 0.05),
          Column(
            children: [
              Text(
                "NPR $amount",
                style: TextStyle(
                    fontFamily: "popinsemibold",
                    fontSize: 16,
                    color: isCredit ? const Color(0xFF24BC7C) : Colors.red),
              ),
              Center(
                child: Text(
                  status,
                  style: TextStyle(
                    fontFamily: "popinsemibold",
                    color:
                        status.toLowerCase().contains("Success".toLowerCase())
                            ? Colors.green
                            : Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
