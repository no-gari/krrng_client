import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:krrng_client/repositories/map_repository/models/mapResponse.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authenticationRepository) : super(const SignInState());

  final AuthenticationRepository _authenticationRepository;

  Future<void> signInWithSns(
      {required String code,
      required String email,
      required String nickname,
      String? socialType}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ApiResult<Map> apiResult = await _authenticationRepository.signInWithSns(
        code: code, email: email, nickname: nickname, socialType: socialType);

    print('================cubit====================');

    apiResult.when(success: (Map? response) {
      prefs.setString('access', response!['access']);
      prefs.setString('refresh', response['refresh']);
      _authenticationRepository.logIn();
      emit(state.copyWith(auth: true, errorMessage: ''));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

  Future<void> signInWithEmail(
      {required String userId, required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ApiResult<Map> apiResult = await _authenticationRepository.signInWithEmail(
        userId: userId, password: password);

    apiResult.when(success: (Map? response) {
      prefs.setString('access', response!['access']);
      prefs.setString('refresh', response['refresh']);
      _authenticationRepository.logIn();
      emit(state.copyWith(auth: true, errorMessage: ''));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

  Future<bool?> updateProfile(
      {required String? profileImage,
      required String? birthday,
      required String? nickname,
      required String? sexChoices}) async {
    MultipartFile? image = profileImage == null
        ? null
        : await MultipartFile.fromFile(profileImage);

    Map<String, dynamic> body = {
      "profileImage": image,
      "birthday": birthday,
      "nickname": nickname,
      "sexChoices": sexChoices
    };

    var response = await _authenticationRepository.updateUser(body);

    response.when(success: (Map? mapResponse) {
      return true;
    }, failure: (NetworkExceptions? error) {
      return false;
    });
  }

  Future<void> updatePasswordSetting({required String? password}) async {
    var response =
        await _authenticationRepository.changePassworInSetting(password!);

    response.when(success: (void result) {
      return true;
    }, failure: (NetworkExceptions? error) {
      return false;
    });
  }

  void errorMsg() {
    emit(state.copyWith(errorMessage: ""));
  }
}
