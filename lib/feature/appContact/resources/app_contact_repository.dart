import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/appContact/resources/app_contact_api_provider.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class AppContactRepository {
  ApiProvider apiProvider;
  late AppContactAPIProvider appContactAPIProvider;
  UserRepository userRepository;
  CustomerDetailRepository customerDetailRepository;
  CoOperative env;

  AppContactRepository({
    required this.env,
    required this.userRepository,
    required this.apiProvider,
    required this.customerDetailRepository,
  }) {
    appContactAPIProvider = AppContactAPIProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      userRepository: userRepository,
      coOperative: env,
    );
  }
  UtilityResponseData appContactDetail = UtilityResponseData(
      status: "",
      code: "",
      message: "",
      transactionIdentifier: "",
      details: []);
  String contactNumber = "9801132218";
  Future<DataResponse<UtilityResponseData>> fetchAppContact() async {
    try {
      final _res = await appContactAPIProvider.fetchAppContact();

      final UtilityResponseData _responseData =
          UtilityResponseData.fromJson(_res['data'] ?? {});
      appContactDetail = _responseData;
      final number = appContactDetail
          .findValue(primaryKey: "contactNumber")
          .toString()
          .toLowerCase();
      contactNumber =
          number.isEmpty || number == "null" ? "9801132219" : number;
      return DataResponse.success(_responseData);
    } on CustomException catch (e) {
      if (e is SessionExpireErrorException) {
        rethrow;
      }
      return DataResponse.error(e.message, e.statusCode);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
