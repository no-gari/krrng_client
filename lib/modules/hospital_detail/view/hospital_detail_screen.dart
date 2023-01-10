import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/hospital/cubit/hospital_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'hospital_detail_page.dart';

class HospitalDetailScreen extends StatelessWidget {
  HospitalDetailScreen({this.id});

  final int? id;

  static const String routeName = '/hospital-detail';

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: BlocProvider.value(
            value: BlocProvider.of<HospitalCubit>(context),
            child: HospitalDetailPage(id: id)));
  }
}
