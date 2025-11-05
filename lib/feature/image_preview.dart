import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/feature/customerDetail/cubit/customer_detail_cubit.dart';
import 'package:ismart/feature/dashboard/homePage/widget/home_page_user_widget.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/profile/resources/cubits/image_upload_cubit.dart';

class ImagePreviewWidget extends StatefulWidget {
  const ImagePreviewWidget({Key? key, required this.selectedImage})
      : super(key: key);
  final File selectedImage;

  @override
  State<ImagePreviewWidget> createState() => _ImagePreviewWidgetState();
}

class _ImagePreviewWidgetState extends State<ImagePreviewWidget> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return PageWrapper(
      body: BlocListener<ImageUploadCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoading && _isLoading == false) {
            _isLoading = true;
            showLoadingDialogBox(context);
          }
          if (state is! CommonLoading && _isLoading) {
            _isLoading = false;
            NavigationService.pop();
          }
          if (state is CommonStateSuccess) {
            context.read<CustomerDetailCubit>().fetchCustomerDetail();
            NavigationService.pushReplacement(
              target: const DashboardPage(),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              "Preview Dashboard",
              style: _textTheme.displayMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            HomePageUserWidget(
              isPreview: true,
              selectedImage: widget.selectedImage,
            ),
            const Spacer(),
            CustomRoundedButtom(
              title: "Confirm",
              onPressed: () {
                context
                    .read<ImageUploadCubit>()
                    .uploadImage(imageFile: widget.selectedImage);
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
      ),
    );
  }
}
