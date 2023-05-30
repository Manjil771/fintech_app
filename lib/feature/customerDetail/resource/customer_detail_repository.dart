import 'package:flutter/foundation.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_api_provider.dart';

class CustomerDetailRepository {
  final ApiProvider apiProvider;
  late CustomerAPIProvider customerAPIProvider;
  final CoOperative coOperative;
  final UserRepository userRepository;

  CustomerDetailRepository({
    required this.apiProvider,
    required this.coOperative,
    required this.userRepository,
  }) {
    customerAPIProvider = CustomerAPIProvider(
      apiProvider: apiProvider,
      baseUrl: coOperative.baseUrl,
      coOperative: coOperative,
      userRepository: userRepository,
    );
  }

  ValueNotifier<CustomerDetailModel?> customerDetailModel = ValueNotifier(null);

  final ValueNotifier<List<AccountDetail>> accountsList = ValueNotifier([]);

  Future<DataResponse<CustomerDetailModel>> getCustomerDetail() async {
    try {
      final _res = await customerAPIProvider.fetchCustomerDetail();
      print(_res.toString());

      if (_res['data']['details'] != null) {
        // Parse Data from API

        final Map<String, dynamic> _userMap =
            Map<String, dynamic>.from(_res['data']?['details'] ?? {});

        if (_userMap.isEmpty) {
          return DataResponse.error("Error fetching data.");
        }
        CustomerDetailModel _user = CustomerDetailModel.fromJson(_userMap);

        customerDetailModel.value = _user;

        accountsList.value = _user.accountDetail;
        return DataResponse.success(_user);
      } else {
        return DataResponse.error("error message");
      }
    } on CustomException catch (e) {
      if (e is SessionExpireErrorException) {
        rethrow;
      }
      return DataResponse.error(e.message!, e.statusCode);
    } catch (e) {
      return DataResponse.error(e.toString());
    }

    // print("api is loading");
    // // final url = CoOperative().baseUrl;
    // const url =
    //     "http://103.198.9.222:1231/api/customerdetails?additionalDetails=true&getBalanceOfPrimaryOnly=true";
    // final dio = Dio();
    // try {
    //   print("api is trying");
    //   final response = await dio.get(url,
    //       options: Options(headers: {
    //         "Authorization": "Bearer c2e38469-2f1a-4ade-88ac-a87fc7c17cbe",
    //       }));
    // } catch (e) {
    //   print(e.toString());
    //   return e.toString();
    // }
  }
}
