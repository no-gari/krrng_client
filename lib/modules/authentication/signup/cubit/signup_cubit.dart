import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:krrng_client/repositories/authentication_repository/authentication_repository.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this._authenticationRepository) : super(const SignupState(selectedTap: 0));

  final AuthenticationRepository _authenticationRepository;


  void selectedTap(int tap) {
    emit(state.copyWith(selectedTap: tap));
  }
}