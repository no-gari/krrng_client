import 'package:krrng_client/modules/disease/cubit/disease_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class DiseasePage extends StatefulWidget {
  DiseasePage({this.symptom});

  final String? symptom;

  @override
  State<DiseasePage> createState() => _DiseasePageState();
}

class _DiseasePageState extends State<DiseasePage> {
  late DiseaseCubit _diseaseCubit;

  @override
  void initState() {
    super.initState();
    _diseaseCubit = BlocProvider.of<DiseaseCubit>(context);
    _diseaseCubit.getDiseaseList(widget.symptom!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: true),
        body:
            BlocBuilder<DiseaseCubit, DiseaseState>(builder: (context, state) {
          if (state.isLoaded == true) {
            return SafeArea(
                child: SingleChildScrollView(
                    child: Column(children: [
              for (var item in state.disease!)
                ListTile(onTap: () {}, title: Text(item.name.toString()))
            ])));
          }
          return Center(
              child: Image.asset('assets/images/indicator.gif',
                  width: 100, height: 100));
        }));
  }
}
