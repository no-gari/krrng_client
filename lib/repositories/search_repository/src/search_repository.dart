import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/dio_client.dart';

class SearchRepository {
  SearchRepository(this._dioClient);

  final DioClient _dioClient;

  Future<ApiResult<List>> getKeywords() async {
    try {
      var response = await _dioClient.get('/dev/api/v1/search/trending/');
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
