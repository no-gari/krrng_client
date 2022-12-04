import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/point/cubit/point_cubit.dart';
import 'package:krrng_client/repositories/point_repository/src/point_repository.dart';
import 'point_page.dart';

class PointScreen extends StatelessWidget {
  static const String routeName = '/point';

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => PointCubit(
                    RepositoryProvider.of<PointRepository>(context))),
          ],
          child: PointPage(),
        ));
  }
}
