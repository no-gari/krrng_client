import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/hospital/cubit/hospital_cubit.dart';

class HospitalSearchPage extends StatefulWidget {
  const HospitalSearchPage({Key? key}) : super(key: key);

  static const String routeName = "/hospital/search";

  @override
  State<HospitalSearchPage> createState() => _HospitalSearchPageState();
}

class _HospitalSearchPageState extends State<HospitalSearchPage> {

  late HospitalCubit _hospitalCubit;

  @override
  void initState() {
    super.initState();
    _hospitalCubit = BlocProvider.of<HospitalCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("HospitalSearchPage"),
      ),
    );
  }

}