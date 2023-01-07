import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/disease/cubit/disease_cubit.dart';
import 'package:krrng_client/modules/hospital/cubit/hospital_cubit.dart';
import 'package:krrng_client/modules/hospital_search/view/hostipal_search_page.dart';
import 'package:krrng_client/modules/search/cubit/recent_search_cubit.dart';
import 'package:krrng_client/repositories/disease_repository/src/disease_repository.dart';
import 'package:krrng_client/repositories/search_repository/src/recent_search_repository.dart';
import 'package:vrouter/vrouter.dart';

class HospitalSearchScreen extends StatelessWidget {
  static const String routeName = '/hospital-search-screen';

  @override
  Widget build(BuildContext context) {
    final disease = context.vRouter.pathParameters['disease'];
    final fromMap = context.vRouter.pathParameters['fromMap'];

    return BlocProvider.value(
        value: BlocProvider.of<HospitalCubit>(context),
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => RecentSearchCubit(
                      RepositoryProvider.of<RecentSearchRepository>(context))),
              BlocProvider(
                  create: (context) => DiseaseCubit(
                      RepositoryProvider.of<DiseaseRepository>(context))),
            ],
            child: HospitalSearchPage(
                disease: int.parse(disease!), fromMap: fromMap == 'true')));
  }
}
