import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';

showLoadingDialogBox(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const LoadingDialogBox();
    },
  );
}

class LoadingDialogBox extends StatelessWidget {
  const LoadingDialogBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Assets.logoImage,
                height: 80,
                width: 80,
              ),
              const SizedBox(height: 14),
              Text(
                "Loading...",
                style: _textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
