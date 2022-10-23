import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:krrng_client/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:krrng_client/repositories/authentication_repository/authentication_repository.dart';
import 'signin_page.dart';

class SigninScreen extends StatefulWidget {
  static const String routeName = "/login";

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SignInCubit>(
                create: (_) => SignInCubit(
                    RepositoryProvider.of<AuthenticationRepository>(context))),
          ],
          child: SigninPage(),
        ));
  }
}
