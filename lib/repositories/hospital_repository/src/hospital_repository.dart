import 'package:dio/dio.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:krrng_client/repositories/hospital_repository/models/hospital_detail.dart';
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

  Future<ApiResult<List<Hospital>>> hospitalSearch(
      LatLng latLng, int part, HospitalFilter filter, String keyword) async {
    Map<String, dynamic> body = {
      "keyword": keyword,
      "userLatitude": latLng.latitude,
      "userLongitude": latLng.longitude,
      "bestPart": part,
      "disease": 0,
      "filter": filter.toString().split('.')[1]
    };
    try {
      var response = await _dioClient.get('/dev/api/v1/hospital/search',
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

  Future<ApiResult<dynamic>> getHospitalDetail(
      LatLng latLng, int id, bool isAuthenticated) async {
    Map<String, dynamic> body = {
      "userLatitude": latLng.latitude,
      "userLongitude": latLng.longitude
    };
    try {
      var response = isAuthenticated == true
          ? await _dioClient.getWithAuth('/dev/api/v1/hospital/detail/${id}/',
              queryParameters: body)
          : await _dioClient.get('/dev/api/v1/hospital/detail/${id}/',
              queryParameters: body);
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<List<dynamic>>> getMyReviews() async {
    try {
      var response =
          await _dioClient.getWithAuth('/dev/api/v1/review/my-list/');
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Map>> createReview(FormData data) async {
    try {
      var response = await _dioClient
          .postWithAuthForMultiPart('/dev/api/v1/review/create/', data: data);
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<dynamic>> updateIsLike(int id) async {
    try {
      var response =
          await _dioClient.put('/dev/api/v1/review/${id}/update-like/');
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
