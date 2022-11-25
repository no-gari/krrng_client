import 'package:krrng_client/modules/search/cubit/search_cubit.dart';
import 'package:krrng_client/repositories/search_repository/src/recent_search_repository.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/search/cubit/recent_search_cubit.dart';
import 'package:krrng_client/modules/search/view/search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:krrng_client/repositories/search_repository/src/search_repository.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => RecentSearchCubit(
                    RepositoryProvider.of<RecentSearchRepository>(context))),
            BlocProvider(
                create: (context) => SearchCubit(
                    RepositoryProvider.of<SearchRepository>(context))),
          ],
          child: SearchPage(),
        ));
  }
}
