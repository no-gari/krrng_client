import 'package:krrng_client/repositories/disease_repository/src/disease_repository.dart';
import 'package:krrng_client/modules/disease/cubit/disease_cubit.dart';
import 'package:krrng_client/modules/disease/page/disease_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class DiseaseScreen extends StatelessWidget {
  DiseaseScreen({this.symptom});

  final String? symptom;

  static String routeName = 'disease/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            DiseaseCubit(RepositoryProvider.of<DiseaseRepository>(context)),
        child: DiseasePage(symptom: symptom));
  }
}
