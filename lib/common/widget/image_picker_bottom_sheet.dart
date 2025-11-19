import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';

import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';

showImagePickerBottomSheet({
  required Function? onGalleryPressed,
  required Function? onCameraPressed,
  bool showCameraOption = true,
  bool showGalleryOption = true,
  String description = '',
  bool isVideo = false,
  bool videoCompressorSubscribe = true,
}) {
  return showModalBottomSheet(
    context: NavigationService.context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(36),
        topRight: Radius.circular(36),
      ),
    ),
    builder: (context) {
      return ImagePickerBottomSheet(
        onGalleryPressed: onGalleryPressed,
        onCameraPressed: onCameraPressed,
        showCameraOption: showCameraOption,
        showGalleryOption: showGalleryOption,
        description: description,
        isVideo: isVideo,
        videoCompressorSubscribe: videoCompressorSubscribe,
      );
    },
  );
}

class ImagePickerBottomSheet extends StatefulWidget {
  final Function? onGalleryPressed;
  final Function? onCameraPressed;
  final bool showCameraOption;
  final bool showGalleryOption;
  final String description;
  final bool isVideo;
  final bool videoCompressorSubscribe;

  const ImagePickerBottomSheet({
    this.onCameraPressed,
    this.onGalleryPressed,
    this.showCameraOption = true,
    this.showGalleryOption = true,
    required this.description,
    this.isVideo = false,
    required this.videoCompressorSubscribe,
  });

  @override
  _ImagePickerBottomSheetState createState() => _ImagePickerBottomSheetState();
}

class _ImagePickerBottomSheetState extends State<ImagePickerBottomSheet> {
  // Subscription? _subscription;
  final ValueNotifier<double> _progress = ValueNotifier<double>(0.0);
  @override
  void initState() {
    super.initState();
    // if (widget.videoCompressorSubscribe) {
    //   _subscription = VideoCompress.compressProgress$.subscribe((progress) {
    //     debugPrint('progress: $progress');
    //     setState(() {
    //       _progress = ValueNotifier<double>(progress);
    //     });
    //   });
    // }
  }

  @override
  void dispose() {
    super.dispose();
    // if (_subscription != null) {
    //   _subscription!.unsubscribe();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 24, bottom: 24),
            height: 4,
            width: 55,
            decoration: BoxDecoration(
              color: CustomTheme.lightGray.withOpacity(0.4),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Text(
            "Choose Option",
            style: _textTheme.labelLarge!.copyWith(
              color: CustomTheme.darkerBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 43),
          ValueListenableBuilder(
              valueListenable: _progress,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.showGalleryOption)
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (widget.onGalleryPressed != null) {
                              widget.onGalleryPressed!();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 40.hp),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: CustomTheme.gray,
                              ),
                              borderRadius: BorderRadius.circular(
                                30.hp,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.image_outlined,
                                  size: 54.hp,
                                  color: _theme.primaryColor,
                                ),
                                Text(
                                  "Gallery",
                                  style: _textTheme.titleSmall,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (widget.showCameraOption && widget.showGalleryOption)
                      const SizedBox(width: 20),
                    if (widget.showCameraOption)
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (widget.onCameraPressed != null) {
                              widget.onCameraPressed!();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 40.hp),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: CustomTheme.gray,
                              ),
                              borderRadius: BorderRadius.circular(
                                30.hp,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.camera_outlined,
                                  size: 54.hp,
                                  color: _theme.primaryColor,
                                ),
                                Text(
                                  "Camera",
                                  style: _textTheme.titleSmall,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              builder: (context, double value, Widget? child) {
                if (value > 0.0) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          "Wait",
                          style: _textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: CustomTheme.symmetricHozPadding,
                        ),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: LinearProgressIndicator(
                                  minHeight: 6,
                                  value: value / 100,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    CustomTheme.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              value.ceil().toString() + '%',
                              style: _textTheme.bodyMedium!.copyWith(
                                color: CustomTheme.lightGray,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }
                if (child != null) {
                  return child;
                } else {
                  return Container();
                }
              }),
          if (widget.description.isNotEmpty) const SizedBox(height: 30),
          if (widget.description.isNotEmpty)
            Text(
              widget.description,
              style: _textTheme.bodyLarge!.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: CustomTheme.lightGray,
              ),
            ),
          SizedBox(height: widget.description.isNotEmpty ? 30 : 60),
        ],
      ),
    );
  }
}
