part of 'animal_cubit.dart';

class AnimalState extends Equatable {
  const AnimalState(
      {this.animal,
      this.isLoaded,
      this.isLoading,
      this.error,
      this.errorMessage});

  final Animal? animal;
  final bool? isLoaded;
  final bool? isLoading;
  final NetworkExceptions? error;
  final String? errorMessage;

  AnimalState copyWith({
    Animal? animal,
    bool? isLoaded,
    bool? isLoading,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
    return AnimalState(
        animal: animal ?? this.animal,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [isLoading, animal, isLoaded, error, errorMessage];
}
