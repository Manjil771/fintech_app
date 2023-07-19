import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/file.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ExternalQrWidget extends StatefulWidget {
  final String qrPath;

  const ExternalQrWidget({super.key, required this.qrPath});
  @override
  _ExternalQrWidget createState() => _ExternalQrWidget();
}

class _ExternalQrWidget extends State<ExternalQrWidget> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  final ScreenshotController screenShotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;

    return Column(
      children: [
        Expanded(
          child: Screenshot(
            controller: screenShotController,
            child: SfPdfViewer.network(
              "${RepositoryProvider.of<CoOperative>(context).baseUrl}${widget.qrPath}",
            ),
          ),
        ),
        CustomRoundedButtom(
          title: "Share",
          onPressed: () async {
            screenShotController
                .capture(delay: Duration(milliseconds: 10))
                .then((capturedImage) async {
              final file = Image.memory(capturedImage!);
              if (file != null) {
                Share.share(file.toString());
              }
            });
            // await Share.share();
          },
        )
      ],
    );
  }
}
