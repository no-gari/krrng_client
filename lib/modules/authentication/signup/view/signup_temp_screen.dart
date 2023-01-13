import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:krrng_client/modules/authentication/signup/view/signup_temp_page.dart';
import 'package:krrng_client/repositories/authentication_repository/src/authentication_repository.dart';

class SignupTempScreen extends StatefulWidget {
  static String routeName = "/signup/temp/";

  @override
  _SignupTempScreenState createState() => _SignupTempScreenState();
}

class _SignupTempScreenState extends State<SignupTempScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SignupCubit>(
                create: (_) => SignupCubit(
                    RepositoryProvider.of<AuthenticationRepository>(context))),
          ],
          child: SignupTempPage(),
        ));
  }
}
