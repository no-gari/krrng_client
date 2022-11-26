import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/pet/cubit/pet_cubit.dart';
import 'package:krrng_client/modules/pet/view/pet_page.dart';
import 'package:krrng_client/repositories/animal_repository/animal_repository.dart';

class PetScreen extends StatelessWidget {
  static const String routeName = '/pet';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PetCubit(RepositoryProvider.of<AnimalRepository>(context)),
        child: PetRegisterPage()
    );
  }
}
