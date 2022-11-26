part of 'notice_cubit.dart';

class NoticeState extends Equatable {
  const NoticeState(
      {this.noticeList,
      this.totalPoint,
      this.isLoaded,
      this.isLoading,
      this.error,
      this.errorMessage});

  final List<Notice>? noticeList;
  final int? totalPoint;
  final bool? isLoaded;
  final bool? isLoading;
  final NetworkExceptions? error;
  final String? errorMessage;

  NoticeState copyWith({
    List<Notice>? noticeList,
    int? totalPoint,
    bool? isLoaded,
    bool? isLoading,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
    return NoticeState(
        noticeList: noticeList ?? this.noticeList,
        totalPoint: totalPoint ?? this.totalPoint,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props =>
      [isLoading, noticeList, totalPoint, isLoaded, error, errorMessage];
}
