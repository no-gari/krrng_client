import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'main_page.dart';

class MainScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: const MainPage());
  }
}
