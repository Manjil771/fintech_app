import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/transaction_limit/ui/widgets/semi_progress_bar.dart';

class TransactionLimitCard extends StatelessWidget {
  // final TransactionType type;
  final String title;
  final double maxLimit;
  final double remaining;
  final String valueUnit;
  final bool isCount;
  const TransactionLimitCard({
    Key? key,
    required this.maxLimit,
    required this.remaining,
    required this.title,
    required this.valueUnit,
    this.isCount = true,
  }) : super(key: key);

  // String get maxLimitTitle {
  //   if (type == TransactionType.Daily) {
  //     return isCount
  //         ? LocaleKeys.maxLimitInCount.tr()
  //         : LocaleKeys.maxLimitToTransfer.tr();
  //   } else {
  //     return isCount
  //         ? LocaleKeys.maxLimitInCount.tr()
  //         : LocaleKeys.maxLimitToTransfer.tr();
  //   }
  // }

  // String get maxLimitValueUnit {
  //   if (type == TransactionType.Daily) {
  //     return isCount ? LocaleKeys.timesPerDay.tr() : LocaleKeys.perDay.tr();
  //   } else {
  //     return isCount
  //         ? LocaleKeys.timePerMonth.tr()
  //         : "/${LocaleKeys.month.tr()}";
  //   }
  // }

  // String get remainingLimitTitle {
  //   if (type == TransactionType.Daily) {
  //     return isCount
  //         ? LocaleKeys.remainingLimitInCount.tr()
  //         : LocaleKeys.remainingLimitTransfer.tr();
  //   } else {
  //     return isCount
  //         ? LocaleKeys.remainingLimitInCount.tr()
  //         : LocaleKeys.remainingLimitTransfer.tr();
  //   }
  // }

  // String get remainingLimitValueUnit {
  //   if (type == TransactionType.Daily) {
  //     return isCount ? LocaleKeys.timeToday.tr() : LocaleKeys.today.tr();
  //   } else {
  //     return isCount ? LocaleKeys.times.tr() : "";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.hp,
        horizontal: 14.wp,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomTheme.primaryColor.withOpacity(0.15),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SemiCircleProgressBar(
                title: title,
                valueUnit: valueUnit,
                maxValue: maxLimit,
                minValue: 0,
                isCount: isCount,
                width: constraints.maxWidth,
                current: maxLimit - remaining,
              );
            },
          ),
          SizedBox(height: 20.hp),
          // TransactionInfoChip(
          //   title: maxLimitTitle,
          //   value: isCount ? maxLimit.format() : maxLimit.formatInRupee(),
          //   valueUnit: maxLimitValueUnit,
          // ),
          SizedBox(height: 10.hp),
          // TransactionInfoChip(
          //   title: remainingLimitTitle,
          //   value: isCount ? remaining.format() : remaining.formatInRupee(),
          //   valueUnit: remainingLimitValueUnit,
          // ),
        ],
      ),
    );
  }
}
