import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/eteller/widget/eteller_widget.dart';
import 'package:ismart/feature/payload/payload_page.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class EtellerPage extends StatelessWidget {
  final String payload;
  final String? remarks;
  const EtellerPage({Key? key, required this.payload, required this.remarks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String decryptAES(String encryptedText, String key) {
      try {
        key = (key + key).substring(0, 16);
        final iv = encrypt.IV.fromUtf8(key);
        final encryptKey = encrypt.Key.fromUtf8(key);

        final encrypter = encrypt.Encrypter(encrypt.AES(encryptKey,
            mode: encrypt.AESMode.cbc, padding: 'PKCS7'));

        final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
        print(" data is " + decrypted);

        return decrypted;
      } catch (e) {
        print('Error during decryption: $e');
        return "";
      }
    }

    return decryptAES(
                payload, RepositoryProvider.of<CoOperative>(context).clientCode)
            .toString()
            .contains("code")
        ? BlocProvider(
            create: (context) => UtilityPaymentCubit(
                utilityPaymentRepository:
                    RepositoryProvider.of<UtilityPaymentRepository>(context)),
            child: EtellerWidget(
                payload: decryptAES(payload,
                    RepositoryProvider.of<CoOperative>(context).clientCode)),
          )
        : PayloadPage(
            remarks: remarks,
            payload: payload,
          );
  }
}
