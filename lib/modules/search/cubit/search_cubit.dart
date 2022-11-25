import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/repositories/search_repository/models/recommended_keyword.dart';
import 'package:krrng_client/repositories/search_repository/src/search_repository.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._searchRepository)
      : super(const SearchState(
          isLoading: true,
          isLoaded: false,
        ));

  final SearchRepository _searchRepository;

  Future<void> getKeywords() async {
    ApiResult<List> apiResult = await _searchRepository.getKeywords();

    apiResult.when(
        success: (List? listResponse) {
          emit(state.copyWith(
            keywords: listResponse!
                .map((keyword) => RecommendedKeyword.fromJson(keyword))
                .toList(),
            isLoading: false,
            isLoaded: true,
          ));
        },
        failure: (NetworkExceptions? error) {});
  }
}
