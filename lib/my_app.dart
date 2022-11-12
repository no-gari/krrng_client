import 'package:krrng_client/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:krrng_client/repositories/map_repository/map_repository.dart';
import 'package:krrng_client/repositories/notification_repository/src/notification_repository.dart';
import 'package:krrng_client/repositories/address_repository/src/address_repository.dart';
import 'package:krrng_client/repositories/product_repository/src/product_repository.dart';
import 'package:krrng_client/repositories/coupon_repository/src/coupon_repository.dart';
import 'package:krrng_client/repositories/search_repository/src/search_repository.dart';
import 'package:krrng_client/repositories/order_repository/src/order_repository.dart';
import 'package:krrng_client/repositories/store_repository/src/store_repository.dart';
import 'package:krrng_client/repositories/brand_repository/src/brand_repository.dart';
import 'package:krrng_client/repositories/user_repository/src/user_repository.dart';
import 'package:krrng_client/repositories/cart_repository/src/cart_repository.dart';
import 'package:krrng_client/support/networks/map_client.dart';
import 'repositories/mypage_repository/src/mypage_repository.dart';
import 'modules/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'support/networks/dio_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:krrng_client/app_view.dart';

class MyApp extends StatelessWidget {
  const MyApp(
      {required this.authenticationRepository, required this.dioClient, required this.mapClient});

  final AuthenticationRepository authenticationRepository;
  final DioClient dioClient;
  final MapClient mapClient;

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = UserRepository(dioClient);

    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepository>(
              create: (context) => authenticationRepository),
          RepositoryProvider(create: (context) => UserRepository(dioClient)),
          RepositoryProvider(
              create: (context) => NotificationRepository(dioClient)),
          RepositoryProvider(create: (context) => ProductRepository(dioClient)),
          RepositoryProvider(create: (context) => AddressRepository(dioClient)),
          RepositoryProvider(create: (context) => SearchRepository(dioClient)),
          RepositoryProvider(create: (context) => CouponRepository(dioClient)),
          RepositoryProvider(create: (context) => SearchRepository(dioClient)),
          RepositoryProvider(create: (context) => MypageRepository(dioClient)),
          RepositoryProvider(create: (context) => StoreRepository(dioClient)),
          RepositoryProvider(create: (context) => OrderRepository(dioClient)),
          RepositoryProvider(create: (context) => BrandRepository(dioClient)),
          RepositoryProvider(create: (context) => CartRepository(dioClient)),
          RepositoryProvider(create: (context) => MapRepository(mapClient))
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(
                  authenticationRepository: authenticationRepository,
                  userRepository: userRepository))
        ], child: AppView()));
  }
}
