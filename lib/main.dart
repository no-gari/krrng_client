import 'package:krrng_client/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:krrng_client/support/networks/dio_client.dart';
import 'package:krrng_client/support/networks/map_client.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:krrng_client/app_view.dart';
import 'package:krrng_client/my_app.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(nativeAppKey: '8c5f6654bb59d371a5102877d47b96c3');
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("c028e613-8406-43a8-ba01-fbff5754aa95");
  await OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true);
  OneSignal.shared
      .promptUserForPushNotificationPermission()
      .then((accepted) => print("Accepted permission: $accepted"));
  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) async {
    try {
      var path = await result.notification.additionalData!["path"];
      var id = await result.notification.additionalData!["id"];
      vRouterKey.currentState!.toNamed(path, pathParameters: {'id': id});
    } catch (e, stacktrace) {}
  });

  setPathUrlStrategy();
  Bloc.observer = MyBlocObserver();
  DioClient dioClient = DioClient(Dio());
  MapClient mapClient = MapClient(Dio());

  bool firstRun = await IsFirstRun.isFirstRun();

  runApp(MyApp(
    authenticationRepository: AuthenticationRepository(dioClient),
    dioClient: dioClient,
    mapClient: mapClient,
    isFirstRun: firstRun,
  ));
}
