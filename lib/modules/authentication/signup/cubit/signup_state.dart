part of 'signup_cubit.dart';

class SignupState extends Equatable {
  const SignupState({
    this.selectedTap = 0,
    this.inputId,
    this.inputPassword,
    this.inputCode,
    this.isNotDuplicateId,
    this.isCompletePassword,
    this.isCompleteCode,
    this.term = false,
    this.phoneNumber,
    this.error,
    this.errorMessage
  });

  final int selectedTap;
  final String? inputId;
  final String? inputPassword;
  final String? inputCode;
  final bool? isNotDuplicateId;
  final bool? isCompletePassword;
  final bool? isCompleteCode;
  final bool? term;
  final String? phoneNumber;
  final NetworkExceptions? error;
  final String? errorMessage;

  SignupState copyWith({
    int? selectedTap,
    String? inputId,
    String? inputPassword,
    String? inputCode,
    bool? isNotDuplicateId,
    bool? isCompletePassword,
    bool? isCompleteCode,
    bool? term,
    String? phoneNumber,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
      return SignupState(
          selectedTap: selectedTap ?? this.selectedTap,
          inputId: inputId ?? this.inputId,
          inputPassword: inputPassword ?? this.inputPassword,
          inputCode: inputCode ?? this.inputCode,
          isNotDuplicateId: isNotDuplicateId ?? this.isNotDuplicateId,
          isCompletePassword: isCompletePassword ?? this.isCompletePassword,
          isCompleteCode: isCompleteCode ?? this.isCompleteCode,
          term: term ?? this.term,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          error: error ?? this.error,
          errorMessage: errorMessage ?? this.errorMessage
      );
    }

  @override
  List<Object?> get props => [
    selectedTap, inputId, inputPassword, inputCode, isNotDuplicateId, isCompletePassword, term, isCompleteCode, phoneNumber,
    error, errorMessage
  ];
}