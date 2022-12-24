import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/disease/cubit/disease_cubit.dart';
import 'package:krrng_client/modules/hospital/cubit/hospital_cubit.dart';
import 'package:krrng_client/modules/search_result_branch/view/search_result_branch_page.dart';
import 'package:krrng_client/repositories/disease_repository/src/disease_repository.dart';

class SearchResultBranchScreen extends StatelessWidget {
  static String routeName = 'search-result-branch/';

  SearchResultBranchScreen({this.keyword});

  final String? keyword;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<HospitalCubit>(context),
        child: BlocProvider(
            create: (context) =>
                DiseaseCubit(RepositoryProvider.of<DiseaseRepository>(context)),
            child: SearchResultBranchPage(keyword: keyword)));
  }
}
