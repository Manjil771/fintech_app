import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';

class CustomRoundedButtom extends StatefulWidget {
  const CustomRoundedButtom({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
    this.padding,
    this.color,
    this.horizontalPadding = 12,
    this.verticalPadding = 12,
    this.fontSize = 14,
    this.textColor = Colors.white,
    this.borderColor = Colors.white,
    this.fontWeight = FontWeight.w700,
    this.horizontalMargin = 0,
    this.icon,
    this.iconColor,
    this.verificationAmount,
  }) : super(key: key);
  final String title;
  final Function()? onPressed;
  final bool isDisabled;
  final bool isLoading;
  final Color? color;
  final EdgeInsets? padding;
  final double horizontalPadding;
  final double verticalPadding;
  final double fontSize;
  final Color? textColor;
  final FontWeight fontWeight;
  final double horizontalMargin;
  final IconData? icon;
  final Color? iconColor;
  final Color? borderColor;
  final String? verificationAmount;

  @override
  CustomRoundedButtomState createState() => CustomRoundedButtomState();
}

class CustomRoundedButtomState extends State<CustomRoundedButtom> {
  @override
  Widget build(BuildContext context) {
    final _customerDetailRepo =
        RepositoryProvider.of<CustomerDetailRepository>(context);
    final currentBalance =
        _customerDetailRepo.selectedAccount.value?.availableBalance;
    print('This is the printed amount: ${currentBalance}');
    final _theme = Theme.of(context);
    print(_theme.primaryColor);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalMargin),
      child: Material(
        color: widget.isDisabled
            ? CustomTheme.lightGray
            : (widget.color ?? _theme.primaryColor),
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: widget.isDisabled
              ? null
              : () {
                  if (widget.verificationAmount == null ||
                      currentBalance == null) {
                    widget.onPressed?.call();
                    return;
                  }
                  final verificationAmountDouble =
                      double.tryParse(widget.verificationAmount!) ?? 0.0;
                  final currentBalanceDouble =
                      double.tryParse(currentBalance) ?? 0.0;
                  print(
                      'This is the printed amount is: ${verificationAmountDouble} and ${currentBalanceDouble}');

                  if (verificationAmountDouble <= currentBalanceDouble) {
                    widget.onPressed?.call();
                  } else {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(
                    //     backgroundColor: Colors.red,
                    //     content: Align(
                    //       alignment: Alignment.center,
                    //       child: Text(
                    //         "Insufficient Balance",
                    //         style: TextStyle(color: Colors.white, fontSize: 12),
                    //       ),
                    //     ),
                    //   ),
                    // );
                    showPopUpDialog(
                        context: context,
                        showCancelButton: false,
                        buttonText: 'Okay',
                        title: 'Insufficient Balance!',
                        message: 'Please add funds to proceed.',
                        buttonCallback: () async {
                          NavigationService.pop();
                        });
                  }
                },
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: widget.padding ??
                EdgeInsets.symmetric(
                  vertical: widget.verticalPadding,
                  horizontal: widget.horizontalPadding,
                ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: _theme.textTheme.displaySmall!.copyWith(
                      fontWeight: widget.fontWeight,
                      color: widget.isDisabled
                          ? CustomTheme.gray
                          : widget.textColor,
                      fontSize: widget.fontSize,
                    ),
                  ),
                  if (widget.icon != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.wp),
                      child: Icon(
                        widget.icon,
                        color: widget.iconColor ?? Colors.white,
                        size: 22,
                      ),
                    ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeOut,
                    child: widget.isLoading
                        ? Container(
                            height: 14,
                            width: 14,
                            margin: const EdgeInsets.only(left: 8),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: widget.isDisabled
                  ? null
                  : Border.all(
                      color: widget.borderColor ?? CustomTheme.primaryColor,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
