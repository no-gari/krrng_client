import 'package:krrng_client/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:krrng_client/repositories/notification_repository/src/notification_repository.dart';
import 'package:krrng_client/repositories/search_repository/src/recent_search_repository.dart';
import 'package:krrng_client/repositories/notice_repository/src/notice_repository.dart';
import 'package:krrng_client/repositories/search_repository/src/search_repository.dart';
import 'package:krrng_client/repositories/point_repository/src/point_repository.dart';
import 'package:krrng_client/repositories/user_repository/src/user_repository.dart';
import 'package:krrng_client/repositories/animal_repository/animal_repository.dart';
import 'package:krrng_client/repositories/faq_repository/src/faq_repository.dart';
import 'package:krrng_client/repositories/map_repository/map_repository.dart';
import 'package:krrng_client/support/networks/map_client.dart';
import 'modules/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/app_view.dart';
import 'support/networks/dio_client.dart';
import 'package:flutter/cupertino.dart';

class MyApp extends StatelessWidget {
  const MyApp(
      {required this.authenticationRepository,
      required this.dioClient,
      required this.mapClient,
      required this.isFirstRun});

  final AuthenticationRepository authenticationRepository;
  final DioClient dioClient;
  final MapClient mapClient;
  final bool isFirstRun;

  @override
  Widget build(BuildContext context) {
    final AuthenticationRepository authenticationRepository =
        AuthenticationRepository(dioClient);
    final UserRepository userRepository = UserRepository(dioClient);
    final AnimalRepository animalRepository = AnimalRepository(dioClient);

    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: authenticationRepository),
          RepositoryProvider.value(value: userRepository),
          RepositoryProvider.value(value: animalRepository),
          RepositoryProvider(
              create: (context) => NotificationRepository(dioClient)),
          RepositoryProvider(create: (context) => SearchRepository(dioClient)),
          RepositoryProvider(create: (context) => SearchRepository(dioClient)),
          RepositoryProvider(create: (context) => NoticeRepository(dioClient)),
          RepositoryProvider(create: (context) => PointRepository(dioClient)),
          RepositoryProvider(create: (context) => MapRepository(mapClient)),
          RepositoryProvider(create: (context) => FAQRepository(dioClient)),
          RepositoryProvider(create: (context) => RecentSearchRepository()),
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(
                    authenticationRepository: authenticationRepository,
                    userRepository: userRepository,
                    // animalRepository: animalRepository
                  ))
        ], child: AppView(isFirstRun: this.isFirstRun)));
  }
}
