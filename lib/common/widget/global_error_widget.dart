import 'package:flutter/material.dart';
import 'package:ismart/common/util/snackbar_utils.dart';

void setErrorBuilder(BuildContext context) {
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    SnackBarUtils.showErrorBar(
        context: context, message: errorDetails.exception.toString());
    return Container(
      child: const Center(
        child: Text("An error occurred."),
      ),
    );
  };
}
