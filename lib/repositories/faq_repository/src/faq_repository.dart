import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/dio_client.dart';

class FAQRepository {
  final DioClient _dioClient;
  FAQRepository(this._dioClient);

  Future<ApiResult<List<dynamic>>> getFAQList() async {
    try {
      var response = await _dioClient.get('/dev/api/v1/cs/faq-menu/list/');
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
