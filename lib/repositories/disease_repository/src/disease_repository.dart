import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/dio_client.dart';

class DiseaseRepository {
  final DioClient _dioClient;

  DiseaseRepository(this._dioClient);

  Future<ApiResult<List<dynamic>>> getDiseaseList(String symptom) async {
    try {
      var response = await _dioClient.get('/dev/api/v1/disease/${symptom}');
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
