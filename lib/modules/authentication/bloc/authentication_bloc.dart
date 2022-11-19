import 'package:krrng_client/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:krrng_client/repositories/user_repository/src/user_repository.dart';
import 'package:krrng_client/repositories/user_repository/models/user.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unauthenticated()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
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

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(AuthenticationStatusChanged event) async {
    if (event.status == AuthenticationStatus.unauthenticated) {
      AuthenticationState? status = await _tryGetUser();
      if (status == null) {
        return AuthenticationState.unauthenticated();
      } else {
        return status;
      }
    } else {
      return AuthenticationState.unknown(User.empty);
    }
  }

  Future<AuthenticationState?> _tryGetUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final access = pref.get('access');

    if (access == null) {
      ApiResult<User> apiResult = await _userRepository.getAnonymousUser();
      apiResult.when(success: (User? user) {
        return AuthenticationState.unknown(user!);
      }, failure: (NetworkExceptions? error) {
        return null;
      });
    } else {
      ApiResult<User> apiResult = await _userRepository.getUser();
      apiResult.when(success: (User? user) {
        return AuthenticationState.authenticated(user!);
      }, failure: (NetworkExceptions? error) {
        return null;
      });
    }
  }
}
