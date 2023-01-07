import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/pet/cubit/kind_cubit.dart';
import 'package:krrng_client/modules/pet/cubit/pet_cubit.dart';
import 'package:krrng_client/modules/pet/view/pet_page.dart';
import 'package:krrng_client/repositories/animal_repository/animal_repository.dart';
import 'package:vrouter/vrouter.dart';

class PetScreen extends StatelessWidget {
  static const String routeName = '/pet';

  @override
  Widget build(BuildContext context) {
    final editValue = context.vRouter.pathParameters["editValue"];
    final id = context.vRouter.pathParameters["id"];

    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => PetCubit(
              RepositoryProvider.of<AnimalRepository>(context),
              BlocProvider.of<AuthenticationBloc>(context),
              editValue != 'false',
              id)),
      BlocProvider(
          create: (context) =>
              KindCubit(RepositoryProvider.of<AnimalRepository>(context))),
    ], child: PetPage());
  }
}
