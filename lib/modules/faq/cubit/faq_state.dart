part of 'faq_cubit.dart';

class FAQState extends Equatable {
  const FAQState(
      {this.faq, this.isLoaded, this.isLoading, this.error, this.errorMessage});

  final List<FAQMenu>? faq;
  final bool? isLoaded;
  final bool? isLoading;
  final NetworkExceptions? error;
  final String? errorMessage;

  FAQState copyWith({
    List<FAQMenu>? faq,
    bool? isLoaded,
    bool? isLoading,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
    return FAQState(
        faq: faq ?? this.faq,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [faq, isLoaded, isLoading, error, errorMessage];
}
