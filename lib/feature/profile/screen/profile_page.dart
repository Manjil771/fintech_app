import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/profile/resources/cubits/image_upload_cubit.dart';
import 'package:ismart/feature/profile/resources/image_upload_repository.dart';
import 'package:ismart/feature/profile/widget/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return BlocProvider(
      create: (context) => ImageUploadCubit(
        imageUploadRepository:
            RepositoryProvider.of<ImageUploadRepository>(context),
      ),
      child: const ProfileWidget(),
    );
  }
}
