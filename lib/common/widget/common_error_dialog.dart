import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';

showWalletErrorDialogBox({
  required BuildContext context,
  required String message,
  required String errorCode,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return LoadingDialogBox(message: message, errorCode: errorCode);
    },
  );
}

class LoadingDialogBox extends StatelessWidget {
  final String message;
  final String errorCode;
  const LoadingDialogBox({
    Key? key,
    required this.message,
    required this.errorCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.only(
            top: 10,
            left: CustomTheme.symmetricHozPadding,
            right: CustomTheme.symmetricHozPadding,
            bottom: 20,
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 50.hp),
                  Image.asset(
                    Assets.errorImage,
                    height: 110,
                  ),
                  SizedBox(height: 14.hp),
                  Text(
                    message,
                    style: _textTheme.titleLarge,
                  ),
                  if (errorCode.isNotEmpty && errorCode != "null" && kDebugMode)
                    Container(
                      padding: EdgeInsets.only(top: 5.hp),
                      child: Text(
                        "Error Code: $errorCode",
                        style: _textTheme.bodyLarge,
                      ),
                    ),
                  SizedBox(height: 20.hp),
                  CustomRoundedButtom(
                    title: LocaleKeys.done.tr(),
                    onPressed: () {
                      NavigationService.pop();
                    },
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 10.hp,
                child: Align(
                  child: Text(
                    "Error !!",
                    style: _textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
