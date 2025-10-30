import 'dart:io';

import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class ImageUploadApiProvider {
  final ApiProvider apiProvider;
  final String baseUrl;
  final UserRepository userRepository;
  const ImageUploadApiProvider({
    required this.apiProvider,
    required this.baseUrl,
    required this.userRepository,
  });

  uploadImage({required File imageFile}) async {
    final _url = baseUrl + "api/profilePicture/upload?image";
    return await apiProvider.upload(
      _url,
      imageFile,
      userId: 0,
      token: userRepository.token,
    );
  }
}
