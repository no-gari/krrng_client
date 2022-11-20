import 'package:krrng_client/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'finding_state.dart';

class FindingCubit extends Cubit<FindingState> {
  FindingCubit(this._authenticationRepository) : super(const FindingState());

  final AuthenticationRepository _authenticationRepository;

  void setKey(String? key) {
    emit(state.copyWith(key: key));
  }

  void setCode(String value) {
    emit(state.copyWith(code: value));
  }

  void setUserId(String value) {
    emit(state.copyWith(userId: value));
  }

  Future<void> requestCodeById(String phoneNumber) async {
    ApiResult<void> response = await _authenticationRepository.requestFindingCodeById(phoneNumber);

    response.when(success: (void result) {
      emit(state.copyWith(
          phoneNumber: phoneNumber
      ));
    }, failure: (NetworkExceptions? error) {
      if (error != null) {
        emit(state.copyWith(
            error: error,
            errorMessage: NetworkExceptions.getErrorMessage(error)
        ));
      }
    });
  }

  Future<void> requestCodeByPassword(String userId, String phoneNumber) async {
    ApiResult<void> response = await _authenticationRepository.requestFindingCodeByPassword(phoneNumber, userId);

    response.when(success: (void result) {
      emit(state.copyWith(
          userId: userId,
          phoneNumber: phoneNumber,
      ));
    }, failure: (NetworkExceptions? error) {
      if (error != null) {
        emit(state.copyWith(
            error: error,
            errorMessage: NetworkExceptions.getErrorMessage(error)
        ));
      }
    });
  }

  Future<void> confirmCodeById() async {
    ApiResult<Map> response = await _authenticationRepository.confirmCodeById(state.phoneNumber ?? "", state.code ?? "");

    response.when(success: (Map? result) {
      if (result != null) {
        final userId = result["userId"] as String?;

        emit(state.copyWith(
            isCompleteCode: true,
            userId: userId
        ));
      }

    }, failure: (NetworkExceptions? error) {
      if (error != null) {
        emit(state.copyWith(
            isCompleteCode: false,
            error: error,
            errorMessage: NetworkExceptions.getErrorMessage(error)
        ));
      }
    });
  }

  Future<void> confirmCodeByPassword() async {
    ApiResult<void> response = await _authenticationRepository.confirmCodeByPassword(state.phoneNumber ?? "", state.code ?? "");

    response.when(success: (void result) {
      emit(state.copyWith(
          isCompleteCode: true
      ));
    }, failure: (NetworkExceptions? error) {
      if (error != null) {
        emit(state.copyWith(
            isCompleteCode: false,
            error: error,
            errorMessage: NetworkExceptions.getErrorMessage(error)
        ));
      }
    });
  }

  Future<void> changePasswordPassword(String password) async {
    final phoneNumber = state.phoneNumber ?? "";

    ApiResult<void> response = await _authenticationRepository.changePassword(phoneNumber, password);

    response.when(success: (void result) {
      emit(state.copyWith(
          isCompletePassword: true
      ));
    }, failure: (NetworkExceptions? error) {
      if (error != null) {
        emit(state.copyWith(
            isCompletePassword: false,
            error: error,
            errorMessage: NetworkExceptions.getErrorMessage(error)
        ));
      }
    });
  }

  void confirmError() {
    print("confirmError");
    emit(state.copyWith(error: null, errorMessage: null));
  }
}
