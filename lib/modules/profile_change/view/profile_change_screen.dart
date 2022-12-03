import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/profile_change/view/profile_change_page.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/authentication/signin/cubit/signin_cubit.dart';
import 'package:krrng_client/repositories/authentication_repository/src/authentication_repository.dart';

class ProfileChangeScreen extends StatelessWidget {
  static const String routeName = '/profile-change';

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: MultiBlocProvider(providers: [
          BlocProvider<SignInCubit>(
              create: (_) => SignInCubit(
                  RepositoryProvider.of<AuthenticationRepository>(context)))
        ], child: ProfileChangePage()));
  }
}
