import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/util/url_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

class ReceiveMoneyAPIProvider {
  final ApiProvider apiProvider;
  final CoOperative coOperative;
  final String baseUrl;

  final UserRepository userRepository;

  const ReceiveMoneyAPIProvider({
    required this.apiProvider,
    required this.baseUrl,
    required this.coOperative,
    required this.userRepository,
  });

  Future<dynamic> fetchBanksList({required String type}) async {
    final _uri =
        UrlUtils.getUri(url: coOperative.baseUrl + "api/load_from_bank/$type");

    return await apiProvider.get(
      _uri,
      token: userRepository.token,
      userId: 0,
    );
  }

  Future<dynamic> loadBankRequest({
    required String bankCode,
    required String amount,
    required String remarks,
    required String accountNumber,
  }) async {
    final _body = {
      "accountNo": accountNumber,
      "amount": amount,
      "bankCode": bankCode,
      "remarks": remarks,
    };
    final _url = coOperative.baseUrl + "/api/load_from_bank/payment/";
    final url = UrlUtils.getUri(url: _url, params: _body);
    return await apiProvider.get(
      url,
      token: userRepository.token,
      userId: 0,
    );
  }

  Future<dynamic> loadFromKhalti({
    required String amount,
    required String remarks,
    required String accountNumber,
  }) async {
    final _body = {
      "accountNo": accountNumber,
      "amount": amount,
      "remarks": remarks,
    };
    final _url = coOperative.baseUrl + "/api/load_from_bank/auth/payment/";
    final url = UrlUtils.getUri(url: _url, params: _body);
    return await apiProvider.post(
      url.toString(),
      {},
      token: userRepository.token,
    );
  }

  Future<dynamic> completeKhaltiTxn({
    required String amount,
    required String status,
    required String transaction_id,
    required String pidx,
  }) async {
    final _body = {
      "status": status,
      "amount": amount,
      "pidx": pidx,
      "transaction_id": transaction_id,
    };
    final _url = coOperative.baseUrl + "/api/npay/kl/";
    final url = UrlUtils.getUri(url: _url, params: _body);
    return await apiProvider.post(
      url.toString(),
      {},
      token: userRepository.token,
    );
  }
}
