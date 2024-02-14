import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/image_picker_utils.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/image_picker_bottom_sheet.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/image_preview.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class ProfilePictureWidget extends StatefulWidget {
  final String imageUrl;
  const ProfilePictureWidget({super.key, required this.imageUrl});

  @override
  State<ProfilePictureWidget> createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
  _handleImageUpload(File file) async {
    NavigationService.pop();

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      cropStyle: CropStyle.circle,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Crop Image',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    if (croppedFile != null) {
      NavigationService.push(
        target: ImagePreviewWidget(
          selectedImage: File(croppedFile.path),
        ),
      );
    }
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
        showBackButton: true,
        body: BlocListener<UtilityPaymentCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoading && _isLoading == false) {
              _isLoading = true;
              showLoadingDialogBox(context);
            } else if (state is! CommonLoading && _isLoading) {
              _isLoading = false;
              NavigationService.pop();
            }
            if (state is CommonError) {
              showPopUpDialog(
                context: context,
                message: state.message,
                title: "Error",
                showCancelButton: false,
                buttonCallback: () {
                  NavigationService.pop();
                },
              );
            }
            if (state is CommonStateSuccess<UtilityResponseData>) {
              final UtilityResponseData _res = state.data;
              if (_res.code == "M0000" ||
                  _res.status.toLowerCase() == "success") {
                showPopUpDialog(
                  context: context,
                  message: _res.message,
                  title: _res.status,
                  showCancelButton: false,
                  buttonCallback: () {
                    NavigationService.pushReplacementNamed(
                        routeName: Routes.dashboard);
                  },
                );
              } else {
                showPopUpDialog(
                  context: context,
                  message: _res.message,
                  title: _res.status,
                  showCancelButton: false,
                  buttonCallback: () {
                    NavigationService.pop();
                  },
                );
              }
            }
          },
          child: Column(
            children: [
              Container(
                height: SizeUtils.height / 2,
                width: double.infinity,
                child: widget.imageUrl.isEmpty
                    ? Image.asset(Assets.profilePicture)
                    : Image.network(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(height: 20.hp),
              Row(
                children: [
                  Expanded(
                      child: CustomRoundedButtom(
                    title: "Add Picture",
                    onPressed: () {
                      showImagePickerBottomSheet(
                        onGalleryPressed: () async {
                          final res = await ImagePickerUtils.getGallery();
                          if (res != null) {
                            _handleImageUpload(res);
                          }
                        },
                        onCameraPressed: () async {
                          final res = await ImagePickerUtils.getCamera();
                          if (res != null) {
                            _handleImageUpload(res);
                          }
                        },
                      );
                    },
                  )),
                  if (widget.imageUrl.isNotEmpty)
                    Expanded(
                      child: CustomRoundedButtom(
                        color: CustomTheme.googleColor,
                        onPressed: () {
                          context.read<UtilityPaymentCubit>().deleteReq(
                              serviceIdentifier: "",
                              accountDetails: {},
                              apiEndpoint: "api/delete/customerProfileImage",
                              mPin: "");
                        },
                        title: "Remove Picture",
                      ),
                    )
                ],
              )
            ],
          ),
        ));
  }
}
