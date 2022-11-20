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

  Future<ApiResult<List<Animal>>> getAnimals() async {
    try {
      var response = await _dioClient.getWithAuth('/dev/api/v1/animal/list/') as List<Map<String, dynamic>>;
      final result = response.map((e) => Animal.fromJson(e)).toList() ;
      return ApiResult.success(data: result);
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
}