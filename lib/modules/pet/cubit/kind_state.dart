part of 'kind_cubit.dart';

class KindState extends Equatable {
  const KindState(
      {this.sortAnimals, this.isLoaded, this.error, this.errorMessage});

  final List<SortAnimal>? sortAnimals;
  final bool? isLoaded;
  final NetworkExceptions? error;
  final String? errorMessage;

  KindState copyWith({
    List<SortAnimal>? sortAnimals,
    bool? isLoaded,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
    return KindState(
        sortAnimals: sortAnimals ?? this.sortAnimals,
        isLoaded: isLoaded ?? this.isLoaded,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [sortAnimals, isLoaded, error, errorMessage];
}
