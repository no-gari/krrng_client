import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:krrng_client/repositories/hospital_repository/models/models.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/dio_client.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';

class HospitalRepository {
  final DioClient _dioClient;

  HospitalRepository(this._dioClient);

  Future<ApiResult<List<Hospital>>> getHospitals(
      LatLng latLng, int part, HospitalFilter filter, int disease) async {
    Map<String, dynamic> body = {
      "userLatitude": latLng.latitude,
      "userLongitude": latLng.longitude,
      "bestPart": part,
      "disease": disease,
      "filter": filter.toString().split('.')[1]
    };
    try {
      var response = await _dioClient.get('/dev/api/v1/hospital/list',
          queryParameters: body);
      if (response is List<dynamic>) {
        var hospitalResponse =
            response.map((e) => Hospital.fromJson(e)).toList();
        return ApiResult.success(data: hospitalResponse);
      } else {
        return ApiResult.success(data: []);
      }
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
