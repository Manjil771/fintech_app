import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:local_auth/local_auth.dart';

class FingerPrintUtils {
  static Future<bool> verifyFingerPrint(
      {required BuildContext context, String reason = ""}) async {
    try {
      final _hasFingerPrint = await hasFingerPrint;
      if (_hasFingerPrint) {
        final localAuth = LocalAuthentication();
        final bool didAuthenticate = await localAuth.authenticate(
          localizedReason: reason.isNotEmpty
              ? reason
              : LocaleKeys.pleaseAuthenticateToVerifyPin.tr(),
          // options: const AuthenticationOptions(
          //   biometricOnly: true,
          //   sensitiveTransaction: true,
          //   stickyAuth: false,
          //   useErrorDialogs: true,
          // ),
        );
        return didAuthenticate;
      } else {
        return false;
      }
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Unable to verify")));
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> get hasFingerPrint async {
    try {
      final localAuth = LocalAuthentication();
      final bool canCheckBiometrics = await localAuth.canCheckBiometrics;
      final List<BiometricType> availableBiometrics =
          await localAuth.getAvailableBiometrics();
      return canCheckBiometrics && availableBiometrics.isNotEmpty;
    } on PlatformException catch (_) {
      return false;
    } catch (e) {
      return false;
    }
  }
}
