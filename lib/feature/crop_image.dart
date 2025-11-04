import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/image_preview.dart';

class CropImageView extends StatefulWidget {
  const CropImageView({Key? key, required this.selectedImage})
      : super(key: key);
  final File selectedImage;

  @override
  State<CropImageView> createState() => _CropImageViewState();
}

class _CropImageViewState extends State<CropImageView> {
  Uint8List? _croppedValue;

  @override
  void initState() {
    _croppedValue = widget.selectedImage.readAsBytesSync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return PageWrapper(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
            "Crop Image",
            style: _textTheme.displayMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Crop(
              image: widget.selectedImage.readAsBytesSync(),
              onCropped: (a) {
                if (a is CropSuccess) {
                  _croppedValue = a.croppedImage;
                }
              },
            ),
          ),
          const Spacer(),
          CustomRoundedButtom(
            title: "Confirm",
            onPressed: () {
              NavigationService.pop();
              NavigationService.push(
                target: ImagePreviewWidget(
                  selectedImage: File.fromRawPath(_croppedValue!),
                ),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          CustomRoundedButtom(
            title: "Cancel",
            onPressed: () {
              NavigationService.pop();
            },
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
