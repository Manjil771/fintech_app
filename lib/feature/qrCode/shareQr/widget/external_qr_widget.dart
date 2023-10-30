import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ExternalQrWidget extends StatefulWidget {
  final String qrPath;

  const ExternalQrWidget({super.key, required this.qrPath});

  @override
  _ExternalQrWidgetState createState() => _ExternalQrWidgetState();
}

class _ExternalQrWidgetState extends State<ExternalQrWidget> {
  final screenShotController = ScreenshotController();
  XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Screenshot(
            controller: screenShotController,
            child: buildWidget(),
          ),
        ),
        CustomRoundedButtom(
          title: "Share",
          onPressed: () async {
            takeScreenshot();
          },
        ),
      ],
    );
  }

  Widget buildWidget() {
    return SfPdfViewer.network(
      "${RepositoryProvider.of<CoOperative>(context).baseUrl}${widget.qrPath}",
    );
  }

  takeScreenshot() async {
    final image = await screenShotController.capture();
    final tempFile = await _createTempImageFile(image!);

    if (tempFile != null) {
      Share.shareFiles([tempFile.path]);
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
}
