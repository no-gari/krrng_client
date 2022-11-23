part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState(
      {this.keywords, required this.isLoaded, required this.isLoading});

  final List<RecommendedKeyword>? keywords;
  final bool isLoaded;
  final bool isLoading;

  @override
  List<Object?> get props => [
        keywords,
        isLoaded,
        isLoading,
      ];

  SearchState copyWith({
    List<RecommendedKeyword>? keywords,
    bool? isLoading,
    bool? isLoaded,
  }) {
    return SearchState(
        keywords: keywords ?? this.keywords,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading);
  }
}
