import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/feature/profile/resources/image_upload_repository.dart';

import '../../../../common/http/response.dart';

class ImageUploadCubit extends Cubit<CommonState> {
  ImageUploadCubit({required this.imageUploadRepository})
      : super(CommonInitial());
  final ImageUploadRepository imageUploadRepository;

  uploadImage({required File imageFile}) async {
    emit(CommonLoading());
    final _res = await imageUploadRepository.uploadImage(image: imageFile);
    if (_res.status == Status.Success) {
      emit(CommonStateSuccess(data: _res.data));
    } else {
      emit(
        CommonError(
            message: _res.message ?? "Error fetching data from server."),
      );
    }
  }
}
