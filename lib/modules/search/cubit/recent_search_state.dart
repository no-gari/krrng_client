part of 'recent_search_cubit.dart';

class RecentSearchState extends Equatable {
  const RecentSearchState(
      {required this.isLoaded, required this.isLoading, this.results});

  final bool? isLoading, isLoaded;
  final List<RecentSearch>? results;

  @override
  List<Object?> get props => [isLoaded, isLoading, results];

  RecentSearchState copyWith(
      {List<RecentSearch>? results, bool? isLoading, bool? isLoaded}) {
    return RecentSearchState(
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading,
        results: results ?? this.results);
  }
}
