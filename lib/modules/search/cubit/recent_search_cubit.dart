import 'package:krrng_client/repositories/search_repository/src/recent_search_repository.dart';
import 'package:krrng_client/repositories/search_repository/models/recent_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'recent_search_state.dart';

class RecentSearchCubit extends Cubit<RecentSearchState> {
  RecentSearchCubit(this._recentSearchRepository)
      : super(const RecentSearchState(isLoading: true, isLoaded: false));

  final RecentSearchRepository _recentSearchRepository;

  Future<void> getRecentSearchList() async {
    var recentSearchList =
        await _recentSearchRepository.getRecentSearchKeywords();
    emit(state.copyWith(
        isLoaded: true, isLoading: false, results: recentSearchList));
  }

  Future<void> addRecentSearch(RecentSearch recentSearch) async {
    var favoriteList =
        await _recentSearchRepository.addRecentSearch(recentSearch);
    emit(state.copyWith(
        isLoaded: true, isLoading: false, results: favoriteList));
  }

  Future<void> deleteRecentSearch(RecentSearch recentSearch) async {
    var favoriteList =
        await _recentSearchRepository.deleteRecentSearch(recentSearch);
    emit(state.copyWith(
        isLoaded: true, isLoading: false, results: favoriteList));
  }

  Future<void> deleteAllRecentSearch() async {
    var favoriteList = await _recentSearchRepository.deleteAllRecentSearch();
    emit(state.copyWith(
        isLoaded: true, isLoading: false, results: favoriteList));
  }
}
