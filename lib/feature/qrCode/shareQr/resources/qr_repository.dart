import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/qrCode/shareQr/resources/qr_api_provider.dart';

class QrRepository {
  final ApiProvider apiProvider;
  final CoOperative coOperative;
  final UserRepository userRepository;

  late QrApiProvider qrApiProvider;

  QrRepository({
    required this.apiProvider,
    required this.coOperative,
    required this.userRepository,
  }) {
    qrApiProvider = QrApiProvider(
        apiProvider: apiProvider,
        baseUrl: coOperative.baseUrl,
        coOperative: coOperative,
        userRepository: userRepository);
  }
  Future<DataResponse> generateQr(
      {required String customerName, required String customerId}) async {
    try {
      final _res = await qrApiProvider.generateQrCode(
          customerName: customerName, customerId: customerId);

      if (_res['data']['details'] != null) {
        // Parse Data from API

        return DataResponse.success(_res);
      } else {
        return DataResponse.error("Error");
      }
    } on CustomException catch (e) {
      if (e is SessionExpireErrorException) {
        rethrow;
      }
      return DataResponse.error(e.message!, e.statusCode);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
