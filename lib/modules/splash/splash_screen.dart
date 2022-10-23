import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:krrng_client/modules/authentication/signin/view/signin_page.dart';
import 'package:krrng_client/modules/authentication/signin/view/signin_screen.dart';
import 'package:krrng_client/modules/main/main_screen.dart';
import 'package:krrng_client/repositories/authentication_repository/authentication_repository.dart';
import 'package:vrouter/vrouter.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        if (state.status == AuthenticationStatus.authenticated) {
          context.vRouter.to(MainScreen.routeName, isReplacement: true);
        } else {
          context.vRouter.to(SigninScreen.routeName, isReplacement: true);
        }
      },
    );
  }
}

