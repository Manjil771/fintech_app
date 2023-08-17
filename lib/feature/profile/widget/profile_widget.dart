import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/image_picker_utils.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/image_picker_bottom_sheet.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/profile/screen/profile_screen_tabbar_page.dart';

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

  _handleImageUpload(File file) {
    showPopUpDialog(
      context: context,
      message: "Are you sure you want to upload image?",
      title: "Upload Profile Picture",
      buttonCallback: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: ValueListenableBuilder<CustomerDetailModel?>(
          valueListenable: customerDetail,
          builder: (context, val, _) {
            if (val != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      NavigationService.pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: CustomTheme.white,
                        borderRadius: BorderRadius.circular(18)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 30),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showImagePickerBottomSheet(
                              onGalleryPressed: () async {
                                final res = await ImagePickerUtils.getGallery();
                                if (res != null) {
                                  _handleImageUpload(res);
                                }
                                NavigationService.pop();
                              },
                              onCameraPressed: () async {
                                final res = await ImagePickerUtils.getCamera();
                                if (res != null) {
                                  _handleImageUpload(res);
                                }
                                NavigationService.pop();
                              },
                            );
                          },
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(Assets.profilePicture),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  val.fullName,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                Text(
                                  val.email,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  val.addressOne,
                                  style: Theme.of(context).textTheme.titleSmall,
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
                    customerDetail: customerDetail,
                  ))
                ],
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
