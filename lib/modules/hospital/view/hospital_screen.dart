import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/disease/cubit/disease_cubit.dart';
import 'package:krrng_client/modules/hospital/cubit/hospital_cubit.dart';
import 'package:krrng_client/modules/search/cubit/recent_search_cubit.dart';
import 'package:krrng_client/repositories/disease_repository/src/disease_repository.dart';
import 'package:krrng_client/repositories/hospital_repository/src/hospital_repository.dart';
import 'package:krrng_client/repositories/map_repository/map_repository.dart';
import 'package:krrng_client/repositories/search_repository/src/recent_search_repository.dart';
import 'hospital_page.dart';

class HospitalScreen extends StatelessWidget {
  static const String routeName = '/hospital';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => RecentSearchCubit(
                RepositoryProvider.of<RecentSearchRepository>(context))),
        BlocProvider(
            create: (context) => HospitalCubit(
                RepositoryProvider.of<MapRepository>(context),
                RepositoryProvider.of<HospitalRepository>(context))),
        BlocProvider(
            create: (context) =>
                DiseaseCubit(RepositoryProvider.of<DiseaseRepository>(context)))
      ],
      child: HospitalPage(),
    );
  }
}
