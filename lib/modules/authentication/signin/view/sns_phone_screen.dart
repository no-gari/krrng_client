import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/authentication/signin/view/sns_phone_page.dart';
import 'package:krrng_client/modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:krrng_client/repositories/authentication_repository/authentication_repository.dart';

class SnsPhoneScreen extends StatefulWidget {
  static String routeName = "/sns-phone";

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SnsPhoneScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: BlocProvider(
            create: (context) => SignupCubit(
                RepositoryProvider.of<AuthenticationRepository>(context)),
            child: SnsPhonePage()));
  }
}
