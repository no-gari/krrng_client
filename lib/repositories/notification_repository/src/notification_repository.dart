import 'package:krrng_client/repositories/notification_repository/models/notification.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/support/networks/page_response.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/dio_client.dart';

class NotificationGetFailure implements Exception {}

class NotificationRepository {
  final DioClient _dioClient;

  NotificationRepository(this._dioClient);

  Future<ApiResult<PageResponse>> getNotification(int page) async {
    try {
      var response = await _dioClient.get('/api/notification?page=$page');
      return ApiResult.success(data: PageResponse.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Notification>> getNotificationDetail(int id) async {
    try {
      var response = await _dioClient.get('/api/notification/$id');
      return ApiResult.success(data: Notification.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
