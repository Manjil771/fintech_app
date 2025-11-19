import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_api_provider.dart';
import 'package:ismart/feature/statement/fullStatement/resources/full_statement_repository.dart';

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

  final ValueNotifier<AccountDetail?> selectedAccount = ValueNotifier(null);

  Future<DataResponse<CustomerDetailModel>> getCustomerDetail(
      {required bool isCalledAtStartup}) async {
    try {
      final _res = await customerAPIProvider.fetchCustomerDetail();

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

        if (isCalledAtStartup) {
          selectedAccount.value = accountsList.value.firstWhere(
              (account) => account.primary == 'true',
              orElse: () => accountsList.value.first);
        } else {
         final AccountDetail? _currentAccount = selectedAccount.value;

          if (_currentAccount != null) {
           final List<AccountDetail> __ = accountsList.value
                .where((element) =>
                    element.accountNumber == _currentAccount.accountNumber)
                .toList();
            if (__.isNotEmpty) {
              selectedAccount.value = __.first;
            }
          }
        }

        RepositoryProvider.of<FullStatementRepository>(
                NavigationService.context)
            .getFullStatement(
          pdfDownload: false,
          accountNumber: selectedAccount.value?.accountNumber ?? "",
          fromDate: DateTime.now().subtract(const Duration(days: 365)),
          toDate: DateTime.now(),
        );
        return DataResponse.success(_user);
      } else {
        return DataResponse.error("Error fetching customer detail.");
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
