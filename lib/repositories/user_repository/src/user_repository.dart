import 'package:krrng_client/repositories/user_repository/models/user.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/dio_client.dart';

class UserGetFailure implements Exception {}

class UserRepository {
  final DioClient _dioClient;

  UserRepository(this._dioClient);

  Future<ApiResult<User>> getUser() async {
    try {
      var response = await _dioClient.getWithAuth('/dev/api/v1/user/profile/');

      return ApiResult.success(data: User.fromJson(response));
    } on Exception {
      throw UserGetFailure();
    }
  }

  Future<ApiResult<User>> updateUser() async {
    try {
      var response =
          await _dioClient.put('/api/v1/user/profile_change/', data: {});

      return ApiResult.success(
          data: User(
        nickname: response['nickname'],
        profileImage: response['profileImage'],
      ));
    } on Exception {
      throw UserGetFailure();
    }
  }
}
