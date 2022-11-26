part of 'point_cubit.dart';

class PointState extends Equatable {
  const PointState(
      {this.pointList,
      this.totalPoint,
      this.isLoaded,
      this.isLoading,
      this.error,
      this.errorMessage});

  final List<Point>? pointList;
  final int? totalPoint;
  final bool? isLoaded;
  final bool? isLoading;
  final NetworkExceptions? error;
  final String? errorMessage;

  PointState copyWith({
    List<Point>? pointList,
    int? totalPoint,
    bool? isLoaded,
    bool? isLoading,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
    return PointState(
        pointList: pointList ?? this.pointList,
        totalPoint: totalPoint ?? this.totalPoint,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props =>
      [isLoading, pointList, totalPoint, isLoaded, error, errorMessage];
}
