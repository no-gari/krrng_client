import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/hospital/cubit/hospital_cubit.dart';
import 'package:krrng_client/modules/search_result/view/hospital_search_result_page.dart';
import 'package:krrng_client/repositories/hospital_repository/models/enums.dart';
import 'package:krrng_client/repositories/hospital_repository/src/hospital_repository.dart';
import 'package:krrng_client/repositories/map_repository/src/map_repository.dart';

class HospitalSearchResultScreen extends StatelessWidget {
  static const String routeName = '/hospital-search-result';

  final HospitalPart? hospitalPart;

  HospitalSearchResultScreen({this.hospitalPart});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HospitalCubit(
            RepositoryProvider.of<MapRepository>(context),
            RepositoryProvider.of<HospitalRepository>(context)),
        child: HospitalSearchResultPage(hospitalPart: this.hospitalPart));
  }
}
