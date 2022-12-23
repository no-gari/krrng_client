part of 'disease_cubit.dart';

class DiseaseState extends Equatable {
  const DiseaseState(
      {this.disease,
      this.isLoaded,
      this.isLoading,
      this.error,
      this.errorMessage});

  final List<Disease>? disease;
  final bool? isLoaded;
  final bool? isLoading;
  final NetworkExceptions? error;
  final String? errorMessage;

  DiseaseState copyWith({
    List<Disease>? disease,
    bool? isLoaded,
    bool? isLoading,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
    return DiseaseState(
        disease: disease ?? this.disease,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props =>
      [disease, isLoaded, isLoading, error, errorMessage];
}
