part of 'version_info_cubit.dart';

class VersionInfoState extends Equatable {
  const VersionInfoState(
      {this.version,
      this.isLoaded,
      this.isLoading,
      this.error,
      this.errorMessage});

  final num? version;
  final bool? isLoaded;
  final bool? isLoading;
  final NetworkExceptions? error;
  final String? errorMessage;

  VersionInfoState copyWith({
    num? version,
    bool? isLoaded,
    bool? isLoading,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
    return VersionInfoState(
        version: version ?? this.version,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props =>
      [isLoading, version, isLoaded, error, errorMessage];
}
