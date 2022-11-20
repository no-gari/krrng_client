import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'setting_page.dart';

class SettingScreen extends StatelessWidget {
  static const String routeName = '/setting';

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: BlocProvider.of<AuthenticationBloc>(context), child: SettingPage());
  }
}
