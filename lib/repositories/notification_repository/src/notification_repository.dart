import 'package:krrng_client/repositories/notification_repository/models/notification.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/dio_client.dart';

class NotificationGetFailure implements Exception {}

class NotificationRepository {
  final DioClient _dioClient;

  NotificationRepository(this._dioClient);

  Future<ApiResult<List<dynamic>>> getNotificationList() async {
    try {
      var response =
          await _dioClient.getWithAuth('/dev/api/v1/cs/notification/list/');
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<void>> readlAllNotification() async {
    try {
      var response =
          await _dioClient.getWithAuth('/dev/api/v1/cs/notification/read-all/');
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<List<dynamic>>> notificationDelete(int id) async {
    try {
      var response =
          await _dioClient.delete('/dev/api/v1/cs/notification/delete/${id}/');
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
