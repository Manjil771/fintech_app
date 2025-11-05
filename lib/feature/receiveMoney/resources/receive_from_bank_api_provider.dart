import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class ReceiveFromBankAPIProvider {
  final ApiProvider apiProvider;
  final UserRepository userRepository;
  final String baseUrl;

  ReceiveFromBankAPIProvider({
    required this.apiProvider,
    required this.baseUrl,
    required this.userRepository,
  });

  getBanksList() async {
    final url = "$baseUrl/api/load_from_bank/mbanks";
    // final url = "https://www.mbank.com.np/api/load_from_bank/ebanks";

    return await apiProvider.get(
      Uri.parse(url),
      token: userRepository.token,
      userId: 0,
    );
  }

  // //getcharge
  // getBankCharges({
  //   required String amount,
  //   required String bankId,
  // }) async {
  //   final url =
  //       "$baseUrl/api/ips/scheme/charge?amount=$amount&destinationBankId=$bankId";

  //   return await apiProvider.post(
  //     url,
  //     {},
  //     token: userRepository.token,
  //   );
  // }

  // getWalletBalance({
  //   required String payloadData,
  // }) async {
  //   final url = "$baseUrl/corewallet/api/v1/LoggedIn/";
  //   final payload = {
  //     "function_name": "GetBalance",
  //     "data": "$payloadData",
  //   };

  //   return await apiProvider.post(
  //     url,
  //     payload,
  //     token: userRepository.token,
  //   );
  // }

  // loadFund({
  //   required String payloadData,
  // }) async {
  //   final url = "$baseUrl/api/load_from_bank/payment/";
  //   final payload = {
  //     "function_name": "LoadFund",
  //     "data": "$payloadData",
  //   };

  //   return await apiProvider.post(
  //     url,
  //     payload,
  //     token: userRepository.token,
  //   );
  // }

  // loadFundReceipt({
  //   required String payloadData,
  // }) async {
  //   final url = "$baseUrl/corewallet/api/v1/LoggedIn/";
  //   final payload = {
  //     "function_name": "LoadFundReceipt",
  //     "data": "$payloadData",
  //   };

  //   return await apiProvider.post(
  //     url,
  //     payload,
  //     token: userRepository.token,
  //   );
  // }

  receiveMoneyFromBank({
    required Map<String, dynamic> payloadData,
  }) async {
    final url = "$baseUrl" "api/load_from_bank/payment";
    // final url = "$baseUrl/api/load_from_bank/payment/ebanks";

    // Uri _uri = UrlUtils.getUri(url: url, params: payloadData);

    return await apiProvider.post(
      url,
      payloadData,
      token: userRepository.token,
    );
  }
}
