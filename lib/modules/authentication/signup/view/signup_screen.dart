import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:krrng_client/repositories/authentication_repository/authentication_repository.dart';

import 'views.dart';

class SignupScreen extends StatefulWidget {
  static String routeName = "/signup";

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignupScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => SignupCubit(
        RepositoryProvider.of<AuthenticationRepository>(context)),
      child: SignupPage(),
    );
  }
}