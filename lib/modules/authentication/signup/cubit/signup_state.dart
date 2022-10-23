part of 'signup_cubit.dart';

class SignupState extends Equatable {
  const SignupState({
    this.selectedTap,
    this.error,
    this.errorMessage
  });

  final int? selectedTap;
  final NetworkExceptions? error;
  final String? errorMessage;

  SignupState copyWith({
    int? selectedTap,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
      return SignupState(
          selectedTap: selectedTap ?? this.selectedTap,
          error: error ?? this.error,
          errorMessage: errorMessage ?? this.errorMessage
      );
    }

  @override
  List<Object?> get props => [selectedTap, error, errorMessage];
}