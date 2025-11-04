import 'package:flutter/services.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/url_utils.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:vpn_connection_detector/vpn_connection_detector.dart';

class UtilityPaymentAPIProvider {
  UtilityPaymentAPIProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.userRepository,
    required this.coOperative,
  });

  final ApiProvider apiProvider;
  final UserRepository userRepository;
  final String baseUrl;
  final CoOperative coOperative;

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

  makePayment({
    required String serviceIdentifier,
    required Map<String, dynamic> accountDetails,
    required Map<String, dynamic> body,
    required String apiEndpoint,
    required mPin,
  }) async {
    final _params = {
      ...accountDetails,
    };
    if (serviceIdentifier.isNotEmpty) {
      _params["service_identifier"] = "$serviceIdentifier";
    }
    if (mPin.isNotEmpty) {
      _params["mPin"] = "$mPin";
    }

    final url = UrlUtils.getUri(
      url: baseUrl + "$apiEndpoint",
      params: _params,
    );

    if (serviceIdentifier == "ARS") {
      body['mobilePin'] = mPin;
    }

    return await apiProvider.post(
      url.toString(),
      body,
      token: userRepository.token,
    );
  }

  deleteReq({
    required String serviceIdentifier,
    required Map<String, dynamic> accountDetails,
    required String apiEndpoint,
    required mPin,
  }) async {
    final _params = {
      ...accountDetails,
    };
    if (serviceIdentifier.isNotEmpty) {
      _params["service_identifier"] = "$serviceIdentifier";
    }
    if (mPin.isNotEmpty) {
      _params["mPin"] = "$mPin";
    }

    final url = UrlUtils.getUri(
      url: baseUrl + "$apiEndpoint",
      params: _params,
    );

    return await apiProvider.delete(
      userId: 0,
      url.toString(),
      token: userRepository.token,
    );
  }

  fetchDetails(
      {required String serviceIdentifier,
      required Map<String, dynamic> accountDetails,
      Map<String, dynamic>? extraHeaders,
      required String apiEndpoint}) async {
    final _params = {
      ...accountDetails,
    };
    final bool isVpnConnected = await VpnConnectionDetector.isVpnActive();
    if (isVpnConnected) {
      showPopUpDialog(
          showCancelButton: false,
          context: NavigationService.context,
          buttonText: 'Exit',
          title: 'Possible VPN detected!',
          message:
              'To protect your account and ensure secure transactions, please turn off your VPN and try again.',
          buttonCallback: () async {
            SystemNavigator.pop();
          });
    }
    if (serviceIdentifier.isNotEmpty) {
      _params["service_identifier"] = "$serviceIdentifier";
    }

    final url = UrlUtils.getUri(url: baseUrl + "$apiEndpoint", params: _params);

    return await apiProvider.get(
      url,
      token: userRepository.token,
      userId: 0,
      extraHeaders: extraHeaders,
    );
  }

/* Fetch details post */
  fetchDetailsPost(
      {required String serviceIdentifier,
      required Map<String, dynamic> accountDetails,
      Map<String, dynamic>? extraHeaders,
      required String apiEndpoint}) async {
    final _params = {
      ...accountDetails,
    };
    final Map<String, dynamic> queryParams = {};
    if (serviceIdentifier.isNotEmpty) {
      _params["service_identifier"] = "$serviceIdentifier";
    }

    final url = UrlUtils.getUri(url: baseUrl + "$apiEndpoint", params: _params);

    return await apiProvider.postReq(
      url.toString(),
      _params,
      token: userRepository.token,
      userId: 0,
      extraHeaders: extraHeaders,
      queryParameters: queryParams,
    );
  }

  getCharges({
    required Map<String, dynamic> accountDetails,
    required String apiEndpoint,
  }) async {
    final _params = {
      ...accountDetails,
    };
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
}
