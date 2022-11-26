// import 'package:krrng_client/modules/splash/splash_screen.dart';

import 'package:krrng_client/modules/splash/splash_screen.dart';

import 'modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/support/networks/dio_client.dart';
import 'package:krrng_client/modules/main/main_screen.dart';
import 'package:krrng_client/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'repositories/authentication_repository/src/authentication_repository.dart';
import 'routes.dart';

final GlobalKey<VRouterState> vRouterKey = GlobalKey<VRouterState>();

class AppView extends StatefulWidget {
  AppView({this.isFirstRun});

  bool? isFirstRun;

  @override
  State<StatefulWidget> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VRouter(
        theme: theme,
        debugShowCheckedModeBanner: false,
        key: vRouterKey,
        mode: VRouterMode.history,
        builder: (context, child) {
          DioClient.authenticationBloc =
              BlocProvider.of<AuthenticationBloc>(context);
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: buildMultiBlocListener(child));
        },
        initialUrl: widget.isFirstRun! == true
            ? SplashScreen.routeName
            : MainScreen.routeName,
        routes: routes);
  }

  MultiBlocListener buildMultiBlocListener(Widget child) {
    return MultiBlocListener(listeners: [
      BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          context.vRouter.to(MainScreen.routeName);
        }
      })
    ], child: child);
  }
}
