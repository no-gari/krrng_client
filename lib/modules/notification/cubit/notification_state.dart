part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  const NotificationState(
      {this.notificationList,
      this.totalPoint,
      this.isLoaded,
      this.isLoading,
      this.error,
      this.errorMessage});

  final List<Notification>? notificationList;
  final int? totalPoint;
  final bool? isLoaded;
  final bool? isLoading;
  final NetworkExceptions? error;
  final String? errorMessage;

  NotificationState copyWith({
    List<Notification>? notificationList,
    int? totalPoint,
    bool? isLoaded,
    bool? isLoading,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
    return NotificationState(
        notificationList: notificationList ?? this.notificationList,
        totalPoint: totalPoint ?? this.totalPoint,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props =>
      [isLoading, notificationList, totalPoint, isLoaded, error, errorMessage];
}
