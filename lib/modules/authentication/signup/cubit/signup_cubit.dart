import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:krrng_client/repositories/authentication_repository/authentication_repository.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this._authenticationRepository) : super(const SignupState());

  final AuthenticationRepository _authenticationRepository;

  void selectedTap(int tap) {
    emit(state.copyWith(selectedTap: tap));
  }

  void completePassword(bool isCompletePassword, String? password) {
    emit(state.copyWith(
        isCompletePassword: isCompletePassword,
        inputPassword: password
    ));
  }

  void setTerms(bool isAllow) {
    emit(state.copyWith(
      term: isAllow
    ));
  }

  void setInputCode(String code) {
    emit(state.copyWith(
      inputCode: code
    ));
  }

  Future<void> duplicateId(String id) async {
    ApiResult<void> response = await _authenticationRepository.duplicateId(id);

    response.when(success: (void result) {
      emit(state.copyWith(
          isNotDuplicateId: true,
          inputId: id
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          isNotDuplicateId: false,
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

  Future<void> requestCode(String phoneNumber) async {
    ApiResult<void> response = await _authenticationRepository.requestSignupCode(phoneNumber);

    response.when(success: (void result) {
      emit(state.copyWith(
          phoneNumber: phoneNumber
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

  Future<void> confirmCode(String code) async {
    ApiResult<void> response = await _authenticationRepository.confirmCode(state.phoneNumber ?? "", code);

    response.when(success: (void result) {
      emit(state.copyWith(
        isCompleteCode: true
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          isCompleteCode: false,
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

  Future<void> signup() async {

    final userId = state.inputId ?? "";
    final password = state.inputPassword ?? "";
    final phoneNumber = state.phoneNumber ?? "";
    ApiResult<Map> response = await _authenticationRepository.signup(userId, password, phoneNumber);

    response.when(success: (Map? result) async {
      final accessToken = result?["access"] as String;
      final refreshToken = result?["refresh"] as String;

      final SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('access', accessToken);
      pref.setString('refresh', refreshToken);

    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }
}