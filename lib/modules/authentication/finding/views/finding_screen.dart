import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';

import 'views.dart';

class FindingScreen extends StatefulWidget {
  static const String routeName = "/finding";

  @override
  _FindingScreenState createState() => _FindingScreenState();
}

class _FindingScreenState extends State<FindingScreen> {
 @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: FindingPage()
    );
  }
}