import 'package:krrng_client/modules/search_result/view/hospital_search_result_page.dart';
import 'package:krrng_client/repositories/hospital_repository/models/enums.dart';
import 'package:krrng_client/modules/hospital/cubit/hospital_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HospitalSearchResultScreen extends StatelessWidget {
  static const String routeName = '/hospital-search-result';

  final HospitalPart? hospitalPart;

  HospitalSearchResultScreen({this.hospitalPart});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<HospitalCubit>(context),
        child: HospitalSearchResultPage(hospitalPart: this.hospitalPart));
  }
}
