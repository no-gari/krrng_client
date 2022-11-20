part of 'finding_cubit.dart';

class FindingState extends Equatable {
  const FindingState({this.key, this.phoneNumber, this.userId, this.code, this.isCompleteCode, this.isCompletePassword, this.error, this.errorMessage});

  final String? key;
  final String? phoneNumber;
  final String? userId;
  final String? code;
  final bool? isCompleteCode;
  final bool? isCompletePassword;
  final NetworkExceptions? error;
  final String? errorMessage;

  FindingState copyWith({
    String? key,
    String? phoneNumber,
    String? userId,
    String? code,
    bool? isCompleteCode,
    bool? isCompletePassword,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
    return FindingState(
        key: key ?? this.key,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        userId: userId ?? this.userId,
        code: code ?? this.code,
        isCompleteCode: isCompleteCode ?? this.isCompleteCode,
        isCompletePassword: isCompletePassword ?? this.isCompletePassword,
        error: error,
        errorMessage: errorMessage);
  }

  @override
  List<Object?> get props => [key, phoneNumber, userId, code, isCompleteCode, isCompletePassword, error, errorMessage];
}
