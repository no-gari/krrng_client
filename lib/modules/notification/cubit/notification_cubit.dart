import 'package:krrng_client/repositories/notification_repository/src/notification_repository.dart';
import 'package:krrng_client/repositories/notification_repository/models/notification.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this._notificationRepository)
      : super(const NotificationState(
          isLoading: true,
          isLoaded: false,
        ));

  final NotificationRepository _notificationRepository;

  Future<void> getNotificationList() async {
    ApiResult<List<dynamic>> apiResult =
        await _notificationRepository.getNotificationList();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
        notificationList:
            listResponse!.map((e) => Notification.fromJson(e)).toList(),
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      print(error);
    });
  }

  Future<void> deleteNotification(int id) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ApiResult<List<dynamic>> apiResult =
        await _notificationRepository.notificationDelete(id);

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
        notificationList:
            listResponse!.map((e) => Notification.fromJson(e)).toList(),
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      print(error);
    });
  }

  Future<void> readAllNotiifications() async {
    ApiResult<void> apiResult =
        await _notificationRepository.readlAllNotification();

    apiResult.when(success: (void response) {
      emit(state.copyWith(
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      print(error);
    });
  }
}
