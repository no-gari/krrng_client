import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/dio_client.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';

class NoticeRepository {
  final DioClient _dioClient;
  NoticeRepository(this._dioClient);

  Future<ApiResult<List<dynamic>>> getNoticeList() async {
    try {
      var response = await _dioClient.get('/dev/api/v1/cs/notice/list/');
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<dynamic>> getAppVersion() async {
    try {
      var response = await _dioClient.get('/dev/api/v1/cs/app-version/');
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
