import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/authentication/finding/cubit/finding_cubit.dart';
import 'package:krrng_client/repositories/authentication_repository/authentication_repository.dart';
import 'package:vrouter/vrouter.dart';

import 'views.dart';

class FindingScreen extends StatefulWidget {
  static const String routeName = "/finding";

  @override
  _FindingScreenState createState() => _FindingScreenState();
}

class _FindingScreenState extends State<FindingScreen> {

  late FindingCubit _findingCubit;

  @override
  void initState() {
    super.initState();
    _findingCubit = FindingCubit(RepositoryProvider.of<AuthenticationRepository>(context));

  }

 @override
  Widget build(BuildContext context) {
   final key = context.vRouter.queryParameters["key"];
   _findingCubit.setKey(key);

    return BlocProvider.value(
        value: _findingCubit,
        child: FindingPage()
    );
  }
}