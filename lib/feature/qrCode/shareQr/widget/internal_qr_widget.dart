import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
// import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class InternalQrWidget extends StatelessWidget {
  final String qrPath;
  InternalQrWidget({Key? key, required this.qrPath}) : super(key: key);
  final detail =
      RepositoryProvider.of<CustomerDetailRepository>(NavigationService.context)
          .selectedAccount
          .value!;
  final repo = RepositoryProvider.of<CoOperative>(NavigationService.context);
  final _screenShotController = ScreenshotController();
  XFile? imageFile;

  takeScreenshot() async {
    final image = await _screenShotController.capture();
    final tempFile = await _createTempImageFile(image!);

    if (tempFile != null) {
      // Share.shareXFiles([XFile(tempFile.path)]);
    }
  }

  Future<XFile?> _createTempImageFile(Uint8List image) async {
    try {
      final directory = await getTemporaryDirectory();
      const tempFileName = 'screenshot.png';
      final tempFilePath = '${directory.path}/$tempFileName';

      await File(tempFilePath).writeAsBytes(image);

      return XFile(tempFilePath);
    } catch (e) {
      print('Error creating temp image file: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    return Column(
      children: [
        Screenshot(
          controller: _screenShotController,
          child: Container(
            margin: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: CustomTheme.darkerBlack)),
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Image.asset(
                  Assets.ismartLogo,
                  height: 5.h,
                ),
                CustomCachedNetworkImage(
                    url: repo.baseUrl + qrPath, fit: BoxFit.cover),
                Image.asset(Assets.ismartLogo, height: 10.h),
              ],
            ),
          ),
        ),
        KeyValueTile(
          title: "Name",
          value: detail.accountHolderName,
        ),
        KeyValueTile(
          title: "Account Number",
          value: detail.mainCode,
        ),
        SizedBox(height: _height * 0.02),
        CustomRoundedButtom(
          title: "Share",
          onPressed: () async {
            takeScreenshot();
          },
        )
      ],
    );
  }
}
// delete all items inside a folder form terminal