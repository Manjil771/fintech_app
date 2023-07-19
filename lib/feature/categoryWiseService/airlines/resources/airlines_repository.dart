import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_sector_model.dart';
import 'package:ismart/feature/categoryWiseService/airlines/resources/airlines_api_provider.dart';
import 'package:ismart/feature/statement/fullStatement/model/full_statement_model.dart';
import 'package:ismart/feature/statement/fullStatement/resources/full_statement_api_provider.dart';

class AirlinesRepository {
  final ApiProvider apiProvider;
  late AirlinesAPIProvider airlinesAPIProvider;
  final CoOperative coOperative;
  final UserRepository userRepository;

  AirlinesRepository({
    required this.apiProvider,
    required this.coOperative,
    required this.userRepository,
  }) {
    airlinesAPIProvider = AirlinesAPIProvider(
      apiProvider: apiProvider,
      baseUrl: coOperative.baseUrl,
      coOperative: coOperative,
      userRepository: userRepository,
    );
  }

  Future<DataResponse<List<AirlinesSectorList>>> getAirlinesLocation() async {
    try {
      final _res = await airlinesAPIProvider.fetchAFlightLoaction();

      if (_res['data']['details'] != null) {
        final _userMap = _res['data']?['details'] ?? [];

        if (_userMap.isEmpty) {
          return DataResponse.error("Error fetching data.");
        }

        return DataResponse.success(_userMap);
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
  }
}
