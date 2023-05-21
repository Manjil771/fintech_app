import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class StartUpApiProvider {
  StartUpApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.userRepository,
  });

  final ApiProvider apiProvider;
  final UserRepository userRepository;

  final String baseUrl;

  // fetchConfig() async {
  //   final url = "$baseUrl";
  //   return await apiProvider.get(
  //     url,
  //     token: userRepository.token,
  //   );
  // }
}
