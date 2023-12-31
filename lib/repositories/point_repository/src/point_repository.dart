import 'package:krrng_client/repositories/point_repository/models/point_list.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/dio_client.dart';

class PointGetFailure implements Exception {}

class PointRepository {
  final DioClient _dioClient;

  PointRepository(this._dioClient);

  Future<ApiResult<PointList>> getPointList(String order) async {
    try {
      var response = await _dioClient
          .getWithAuth('/dev/api/v1/point/list/?order=${order}');
      return ApiResult.success(data: PointList.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
