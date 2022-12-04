import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/hospital/cubit/hospital_cubit.dart';
import 'package:krrng_client/repositories/map_repository/map_repository.dart';
import 'hospital_page.dart';

class HospitalScreen extends StatelessWidget {
  static const String routeName = '/hospital';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HospitalCubit(RepositoryProvider.of<MapRepository>(context)),
      child: HospitalPage(),
    );
  }
}
