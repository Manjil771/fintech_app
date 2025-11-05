import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class CreditCardAPIProvider {
  final ApiProvider apiProvider;
  final UserRepository userRepository;
  final String baseUrl;

  CreditCardAPIProvider({
    required this.apiProvider,
    required this.baseUrl,
    required this.userRepository,
  });

  getBanksList({required String apiEndpoint}) async {
    final url = "$baseUrl$apiEndpoint";

    return await apiProvider.get(
      Uri.parse(url),
      token: userRepository.token,
      userId: 0,
    );
  }

  getBankCharges({
    required String amount,
    required String bankId,
  }) async {
    final url =
        "$baseUrl/api/credit_card/charge?amount=$amount&bankCode=$bankId";

    return await apiProvider.get(
      Uri.parse(url),
      userId: 0,
      token: userRepository.token,
    );
  }
}
