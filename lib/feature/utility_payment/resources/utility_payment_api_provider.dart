import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/util/url_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class UtilityPaymentAPIProvider {
  UtilityPaymentAPIProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.userRepository,
  });

  final ApiProvider apiProvider;
  final UserRepository userRepository;
  final String baseUrl;

  getTopup({
    required String serviceIdentifier,
    required String accountNumber,
    required String phoneNumber,
    required String amount,
    required String mpin,
  }) async {
    final _params = {
      "service_identifier": "$serviceIdentifier",
      "account_number": "$accountNumber",
      "phone_number": "$phoneNumber",
      "amount": "$amount",
      "mPin": "$mpin",
    };
    final url = UrlUtils.getUri(url: baseUrl + "/api/topup", params: _params);
    return await apiProvider.post(
      url.toString(),
      {},
      token: userRepository.token,
    );
  }

  fetchDetails(
      {required String serviceIdentifier,
      required Map<String, dynamic> accountDetails,
      required String apiEndpoint}) async {
    final _params = {
      ...accountDetails,
    };
    if (serviceIdentifier.isNotEmpty) {
      _params["service_identifier"] = "$serviceIdentifier";
    }

    final url = UrlUtils.getUri(
      url: baseUrl + "$apiEndpoint",
      params: _params,
    );

    return await apiProvider.get(
      url,
      token: userRepository.token,
      userId: 0,
    );
  }

  fetchInsuranceBill(
      {required String serviceIdentifier,
      required String apiEndpoint,
      required String username,
      required String dateOfBirth}) async {
    final _params = {
      "service_identifier": serviceIdentifier,
      "username": username,
      "dob": dateOfBirth,
    };

    final url = UrlUtils.getUri(url: baseUrl + "$apiEndpoint", params: _params);

    return await apiProvider.get(
      url,
      token: userRepository.token,
      userId: 0,
    );
  }

  payInsuranceBill({
    required String serviceIdentifier,
    required String accountNumber,
    required String amount,
    required String mpin,
    required String dob,
  }) async {
    final _params = {
      "service_identifier": serviceIdentifier,
      "amount": amount,
      "account_number": accountNumber,
      "mPin": mpin,
      "dob": dob,
    };

    final url =
        UrlUtils.getUri(url: baseUrl + "api/insurance/pay", params: _params);

    return await apiProvider.post(
      url.toString(),
      {},
      token: userRepository.token,
    );
  }

  buyDatapack({
    required String serviceIdentifier,
    required String accountNumber,
    required String phoneNumber,
    required String amount,
    required String mpin,
    required String code,
  }) async {
    final body = {"code": code};
    final _params = {
      "service_identifier": "$serviceIdentifier",
      "account_number": "$accountNumber",
      "phone_number": "$phoneNumber",
      "amount": "$amount",
      "mPin": "$mpin",
    };
    final url =
        UrlUtils.getUri(url: baseUrl + "/api/data_pack/pay", params: _params);
    return await apiProvider.post(
      url.toString(),
      body,
      token: userRepository.token,
    );
  }
}
