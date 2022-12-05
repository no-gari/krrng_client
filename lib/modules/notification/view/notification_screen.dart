import 'package:krrng_client/repositories/notification_repository/src/notification_repository.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/notification/cubit/notification_cubit.dart';
import 'package:krrng_client/modules/notification/view/notification_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: BlocProvider(
            create: (context) => NotificationCubit(
                RepositoryProvider.of<NotificationRepository>(context)),
            child: NotificationPage()));
  }
}
