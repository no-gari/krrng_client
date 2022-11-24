import 'package:krrng_client/repositories/animal_repository/animal_repository.dart';
import 'package:krrng_client/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:krrng_client/repositories/user_repository/src/user_repository.dart';
import 'package:krrng_client/repositories/user_repository/models/user.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown(User.empty)) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationUserChanged) {
      yield await _mapAuthenticationUserChangedToState(event.user);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
    }
  }

  Future<AuthenticationState> _mapAuthenticationUserChangedToState(
    User user,
  ) async {
    return AuthenticationState.authenticated(user);
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.authenticated:
        AuthenticationState? status = await _tryGetUser();
        return status!;
      default:
        return const AuthenticationState.unauthenticated();
    }
  }

  Future<AuthenticationState?> _tryGetUser() async {
    try {
      AuthenticationState authenticationState =
          const AuthenticationState.unknown(User.empty);
      ApiResult<User> apiResult = await _userRepository.getUser();
      apiResult.when(success: (User? user) {
        authenticationState = AuthenticationState.authenticated(user!);
      }, failure: (NetworkExceptions? error) {
        authenticationState = AuthenticationState.unauthenticated();
      });
      return authenticationState;
    } on Exception {
      _authenticationRepository.logOut();
    }
  }

// AuthenticationBloc({
//   required AuthenticationRepository authenticationRepository,
//   required UserRepository userRepository,
//   required AnimalRepository animalRepository
// })  : _authenticationRepository = authenticationRepository,
//       _userRepository = userRepository,
//       _animalRepository = animalRepository,
//       super(const AuthenticationState.unauthenticated()) {
//   _authenticationStatusSubscription = _authenticationRepository.status.listen(
//     (status) => add(AuthenticationStatusChanged(status)),
//   );
//   // _userStateSubscription = _userStateSubscription.
// }
//
// final AuthenticationRepository _authenticationRepository;
// final UserRepository _userRepository;
// final AnimalRepository _animalRepository;
//
// late StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;
// // late StreamSubscription<AuthenticationStatus> _userStateSubscription;
//
// @override
// Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
//   if (event is AuthenticationStatusChanged) {
//     yield await _mapAuthenticationStatusChangedToState(event);
//   } else if (event is AuthenticationUserChanged) {
//     yield await _mapAuthenticationUserChangedToState(event.user);
//   } else if (event is AuthenticationLogoutRequested) {
//     _authenticationRepository.logOut();
//   }
// }
//
// Future<AuthenticationState> _mapAuthenticationUserChangedToState(User user) async {
//   print("_mapAuthenticationUserChangedToState");
//   final state = await _getAnimals(user, this.state);
//   print("result: ${state}");
//   return state;
// }
//
// /*
// * _mapAuthenticationStatusChangedToState -> auth repo stream에서 구독한 status 값을 구독한다.
// * 이떄, tryGetUer()로직을 통해 state를 set 해야함.
// * // 생각하는 방법 1. auth repo에서 state를 따로 파서 stream 따로 관리
// * // 생각하는 방법 2. _mapAuthenticationUserChangedToState 로직 돌 때 state 이벤트 방출
// * */
// Future<AuthenticationState> _mapAuthenticationStatusChangedToState(AuthenticationStatusChanged event)
// async {
//   print("_mapAuthenticationStatusChangedToState ${event}");
//
//   AuthenticationState status = await _tryGetUser();
//   return status;
// }
//
// Future<AuthenticationState> _tryGetUser() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   final access = pref.get('access');
//
//   if (access == null) {
//     ApiResult<User> apiResult = await _userRepository.getAnonymousUser();
//     apiResult.when(success: (User? response) {
//       final user = response!;
//       this.add(AuthenticationUserChanged(user));
//       return AuthenticationState.unknown(user);
//     }, failure: (NetworkExceptions? error) {
//       return AuthenticationState.unauthenticated();
//     });
//   } else {
//     ApiResult<User> apiResult = await _userRepository.getUser();
//     apiResult.when(success: (User? response) {
//       final user = response!;
//       this.add(AuthenticationUserChanged(user));
//       return AuthenticationState.authenticated(user);
//     }, failure: (NetworkExceptions? error) {
//       return AuthenticationState.unauthenticated();
//     });
//   }
//
//   return AuthenticationState.unauthenticated();
// }

// state 값에 따라 getAnimal을 한다. 이때, 기존 state - user의 값을 업데이트 해준다.
// Future<AuthenticationState> _getAnimals(User user, AuthenticationState state) async {
//
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   final access = pref.get('access');
//
//   if (access != null) {
//     ApiResult<List<Animal>> apiResult = await _animalRepository.getAnimals();
//
//     apiResult.when(success: (List<Animal>? response) {
//       if (response != null) {
//         final updateUser = user.copyWith(animals: response);
//         return AuthenticationState.authenticated(updateUser);
//       } else {
//         return AuthenticationState.authenticated(user);
//       }
//     }, failure: (NetworkExceptions? error) {
//       return AuthenticationState.authenticated(user);
//     });
//   } else {
//     return state;
//   }
//
//   return state;
// }
}
