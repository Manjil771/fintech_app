import 'dart:io';

import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/profile/resources/image_upload_api_provider.dart';

class ImageUploadRepository {
  ApiProvider apiProvider;
  CoOperative coOperative;
  late ImageUploadApiProvider imageUploadApiProvider;
  UserRepository userRepository;
  ImageUploadRepository({
    required this.userRepository,
    required this.apiProvider,
    required this.coOperative,
  }) {
    imageUploadApiProvider = ImageUploadApiProvider(
      apiProvider: apiProvider,
      userRepository: userRepository,
      baseUrl: coOperative.baseUrl,
    );
  }

  Future<DataResponse<bool>> uploadImage({required File image}) async {
    try {
      final _res = await imageUploadApiProvider.uploadImage(imageFile: image);

      Map<String, dynamic> _jsonResponse = Map.from(_res['data'] ?? {});
      if (_jsonResponse.isNotEmpty) {
        if (_jsonResponse['code'] == "M0000") {
          return DataResponse.success(true);
        }
      }

      return DataResponse.success(false);
    } on CustomException catch (e) {
      return DataResponse.error(e.message!);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
