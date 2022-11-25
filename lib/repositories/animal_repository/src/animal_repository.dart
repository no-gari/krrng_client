import 'dart:async';

import 'package:krrng_client/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/dio_client.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';

import '../models/models.dart';

class AnimalRepository {
  final DioClient _dioClient;
  AnimalRepository(this._dioClient);

  final _controller = StreamController<AuthenticationStatus>();

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

  Future<ApiResult<Animal>> updateAnimalById(String Id, Map body) async {
    try {
      var response =
          await _dioClient.patch('/dev/api/v1/animal/${Id}/', data: body);

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Animal>> createAnimal(Map body) async {
    try {
      var response = await _dioClient.postWithAuth('/dev/api/v1/animal/create/',
          data: body);

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
