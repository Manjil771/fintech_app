import 'package:flutter/material.dart';
import 'package:ismart/common/widget/common_button.dart';

void showYesNoPopUpDialog({
  required BuildContext context,
  required String message,
  required String title,
  required VoidCallback onYes,
  required VoidCallback onNo,
  String yesText = "Yes",
  String noText = "No",
}) {
  showGeneralDialog(
    barrierColor: Colors.black.withOpacity(0.5),
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: CustomRoundedButtom(
                          title: noText,
                          color: Colors.white,
                          textColor: Theme.of(context).primaryColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                            onNo();
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomRoundedButtom(
                          title: yesText,
                          onPressed: () {
                            Navigator.of(context).pop();
                            onYes();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
    barrierDismissible: false,
    barrierLabel: '',
    context: context,
    pageBuilder: (_, __, ___) => Container(),
  );
}
