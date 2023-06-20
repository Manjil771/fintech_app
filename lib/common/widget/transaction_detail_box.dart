import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/feature/history/models/recent_transaction_model.dart';

class TransactionDetailBox extends StatelessWidget {
  final RecentTransactionModel recentTransactionModel;
  final VoidCallback? onClickAction;
  const TransactionDetailBox(
      {Key? key, this.onClickAction, required this.recentTransactionModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return InkWell(
      onTap: () {
        if (onClickAction != null) {
          onClickAction!.call();
        }
      },
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                width: _width * 0.12,
                height: _height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: CustomCachedNetworkImage(
                  url: RepositoryProvider.of<CoOperative>(context).baseUrl +
                      recentTransactionModel.iconUrl.replaceFirst("/", ""),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: _width * 0.05),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(recentTransactionModel.service.toString(),
                        style: Theme.of(context).textTheme.labelMedium),
                    Text(
                      recentTransactionModel.destination,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              SizedBox(width: _width * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "NPR ${recentTransactionModel.totalAmount}",
                    style: const TextStyle(
                      fontFamily: "popinsemibold",
                      fontSize: 12,
                      color: Color(0xFF24BC7C),
                    ),
                  ),
                  Center(
                    child: Text(
                      recentTransactionModel.status,
                      style: const TextStyle(
                        fontFamily: "popinsemibold",
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
