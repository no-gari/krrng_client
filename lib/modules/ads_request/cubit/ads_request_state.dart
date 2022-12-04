part of 'ads_request_cubit.dart';

class AdsRequestState extends Equatable {
  const AdsRequestState(
      {this.isLoaded, this.isLoading, this.error, this.errorMessage});

  final bool? isLoaded;
  final bool? isLoading;
  final NetworkExceptions? error;
  final String? errorMessage;

  AdsRequestState copyWith({
    bool? isLoaded,
    bool? isLoading,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
    return AdsRequestState(
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [isLoaded, isLoading, error, errorMessage];
}
