import 'dart:async';

import 'package:dio/dio.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/dio_client.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';

import '../models/models.dart';

class AnimalRepository {
  final DioClient _dioClient;
  AnimalRepository(this._dioClient);

  Future<ApiResult<List<dynamic>>> getAnimals() async {
    try {
      var response = await _dioClient.getWithAuth('/dev/api/v1/animal/list/');
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Animal>> getAnimalById(String id) async {
    try {
      var response = await _dioClient.getWithAuth('/dev/api/v1/animal/${id}/');

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Animal>> updateAnimalById(int Id, Map body) async {
    try {
      var response =
          await _dioClient.patch('/dev/api/v1/animal/${Id}/', data: body);

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Animal>> createAnimal(Map<String, dynamic> body) async {
    try {
      var data = FormData.fromMap(body);
      var response = await _dioClient.postWithAuthForMultiPart('/dev/api/v1/animal/create/',
          data: data);

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult> deleteAnimalWithId(String Id) async {
    try {
      var response = await _dioClient.postWithAuth('/dev/api/v1/animal/${Id}/');

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
