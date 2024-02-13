import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/image_picker_utils.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/cusom_rounded_image.dart';
import 'package:ismart/common/widget/image_picker_bottom_sheet.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';

import 'package:ismart/feature/image_preview.dart';
import 'package:ismart/feature/profile/screen/profile_picture_screen.dart';

import 'package:ismart/feature/profile/screen/profile_screen_tabbar_page.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

import '../../../app/theme.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  ValueNotifier<CustomerDetailModel?> customerDetail = ValueNotifier(null);

  @override
  void initState() {
    customerDetail = RepositoryProvider.of<CustomerDetailRepository>(context)
        .customerDetailModel;
  }

  // _handleImageUpload(File file) async {
  //   NavigationService.pop();

  //   CroppedFile? croppedFile = await ImageCropper().cropImage(
  //     sourcePath: file.path,
  //     aspectRatioPresets: [
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.ratio3x2,
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.ratio16x9
  //     ],
  //     cropStyle: CropStyle.circle,
  //     uiSettings: [
  //       AndroidUiSettings(
  //           toolbarTitle: 'Crop Image',
  //           toolbarColor: Colors.deepOrange,
  //           toolbarWidgetColor: Colors.white,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false),
  //       IOSUiSettings(
  //         title: 'Crop Image',
  //       ),
  //       WebUiSettings(
  //         context: context,
  //       ),
  //     ],
  //   );
  //   if (croppedFile != null) {
  //     NavigationService.push(
  //       target: ImagePreviewWidget(
  //         selectedImage: File(croppedFile.path),
  //       ),
  //     );
  //   }

  //   // );
  //   // showPopUpDialog(
  //   //   context: context,
  //   //   message: "Are you sure you want to upload image?",
  //   //   title: "Upload Profile Picture",
  //   //   buttonCallback: () {
  //   //     context.read<ImageUploadCubit>().uploadImage(imageFile: file);
  //   //     NavigationService.pop();
  //   //   },
  //   // );
  // }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
        showBackButton: true,
        body: BlocBuilder<UtilityPaymentCubit, CommonState>(
            builder: (context, state) {
          // if (state is CommonLoading && !_isLoading) {
          //   _isLoading = true;
          //   showLoadingDialogBox(context);
          // } else if (state is! CommonLoading && _isLoading) {
          //   _isLoading = false;
          //   NavigationService.pop();
          // }

          if (state is CommonStateSuccess<UtilityResponseData>) {
            final res = state.data;
            final List details = [
              res.findValueString("contactNumber"),
              res.findValueString("registerUrl"),
              res.findValueString("address"),
              res.findValueString("email"),
            ];
            return ValueListenableBuilder<CustomerDetailModel?>(
                valueListenable: customerDetail,
                builder: (context, val, _) {
                  if (val != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // IconButton(
                        //   onPressed: () {
                        //     NavigationService.pop();
                        //   },
                        //   icon: const Icon(Icons.arrow_back),
                        // ),
                        Container(
                          decoration: BoxDecoration(
                              color: CustomTheme.white,
                              borderRadius: BorderRadius.circular(18)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 30),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      NavigationService.push(
                                          target: ProfilePictureScreen(
                                        imageUrl: val.imageUrl,
                                      ));
                                      // showImagePickerBottomSheet(
                                      //   onGalleryPressed: () async {
                                      //     final res = await ImagePickerUtils
                                      //         .getGallery();
                                      //     if (res != null) {
                                      //       _handleImageUpload(res);
                                      //     }
                                      //     // NavigationService.pop();
                                      //   },
                                      //   onCameraPressed: () async {
                                      //     final res = await ImagePickerUtils
                                      //         .getCamera();
                                      //     if (res != null) {
                                      //       _handleImageUpload(res);
                                      //     }
                                      //     // NavigationService.pop();
                                      //   },
                                      // );
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color: _theme.primaryColor),
                                                shape: BoxShape.circle),
                                            child: val.imageUrl.isEmpty
                                                ? const CircleAvatar(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: CircleAvatar(
                                                        radius: 15,
                                                        child: Icon(
                                                          Icons
                                                              .add_a_photo_rounded,
                                                          size: 15,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    radius: 50,
                                                    backgroundImage: AssetImage(
                                                        Assets.profilePicture),
                                                  )
                                                : CustomRoundedImage(
                                                    height: 100,
                                                    image: val.imageUrl,
                                                    width: 100,
                                                  )),
                                        // SizedBox(height: 5.hp),
                                        // Text(
                                        //   "Upload Image",
                                        //   style: _textTheme.titleSmall!
                                        //       .copyWith(
                                        //           fontWeight: FontWeight.bold,
                                        //           fontSize: 11,
                                        //           color: _theme.primaryColor),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 15.wp),
                              Expanded(
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        val.fullName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                      if (val.email.toString().isNotEmpty)
                                        Text(
                                          val.email,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      Text(
                                        val.addressOne,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: _height * 0.01),
                        Expanded(
                            child: ProfileTabbarPage(
                          details: details,
                          customerDetail: customerDetail,
                        ))
                      ],
                    );
                  } else {
                    return Container();
                  }
                });
          } else {
            return Container();
          }
        }));
  }
}
