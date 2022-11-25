part of 'animal_list_cubit.dart';

class AnimalListState extends Equatable {
  const AnimalListState(
      {this.animals,
      this.isLoaded,
      this.isLoading,
      this.error,
      this.errorMessage});

  final List<Animal>? animals;
  final bool? isLoaded;
  final bool? isLoading;
  final NetworkExceptions? error;
  final String? errorMessage;

  AnimalListState copyWith({
    List<Animal>? animals,
    bool? isLoaded,
    bool? isLoading,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
    return AnimalListState(
        animals: animals ?? this.animals,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props =>
      [isLoading, animals, isLoaded, error, errorMessage];
}
