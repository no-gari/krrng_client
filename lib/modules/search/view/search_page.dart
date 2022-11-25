import 'package:flutter/material.dart';
import '../components/hot_search_tile.dart';
import '../components/recent_search_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/search/cubit/search_cubit.dart';
import 'package:krrng_client/modules/search/cubit/recent_search_cubit.dart';
import 'package:krrng_client/modules/search/components/search_text_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late RecentSearchCubit _recentSearchCubit;
  late SearchCubit _searchCubit;
  late FocusNode _focusNode;
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _recentSearchCubit = BlocProvider.of<RecentSearchCubit>(context);
    _searchCubit = BlocProvider.of<SearchCubit>(context);
    _recentSearchCubit.getRecentSearchList();
    _searchCubit.getKeywords();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Expanded(
                            child: SearchTextField(
                                focusNode: _focusNode,
                                recentSearchCubit: _recentSearchCubit,
                                textEditingController: _textEditingController))
                      ]),
                      SizedBox(height: 30),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('최근 검색',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            GestureDetector(
                                onTap: () =>
                                    _recentSearchCubit.deleteAllRecentSearch(),
                                child: Text('전체삭제',
                                    style: TextStyle(fontSize: 13)))
                          ]),
                      SizedBox(height: 16),
                      BlocBuilder<RecentSearchCubit, RecentSearchState>(
                          builder: (context, searchState) {
                        if (searchState.isLoaded! &&
                            searchState.results!.isNotEmpty) {
                          return Wrap(children: [
                            for (var result in searchState.results!)
                              RecentSearchTile(
                                  recentSearchCubit: _recentSearchCubit,
                                  recentSearchState: searchState,
                                  index: searchState.results!.indexOf(result))
                          ]);
                        }
                        return Container();
                      }),
                      SizedBox(height: 50),
                      Text('인기 검색어',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      BlocBuilder<SearchCubit, SearchState>(
                          builder: (context, state) {
                        if (state.isLoaded && state.keywords!.isNotEmpty) {
                          return Wrap(children: [
                            for (var result in state.keywords!)
                              HotSearchTile(
                                  leading: (state.keywords!.indexOf(result) + 1)
                                      .toString(),
                                  title: result.keyword.toString()),
                          ]);
                        }
                        return Container();
                      })
                    ]))));
  }
}
