part of 'writing_review_cubit.dart';

class WritingReviewState extends Equatable {
  const WritingReviewState({
    this.disease,
    this.receiptImages,
    this.reviewContent,
    this.rates,
    this.error,
    this.errorMessage
  });

  final String? disease;
  final List<Asset>? receiptImages;
  final String? reviewContent;
  final int? rates;
  final NetworkExceptions? error;
  final String? errorMessage;

  WritingReviewState copyWith({
    String? disease,
    List<Asset>? receiptImages,
    String? reviewContent,
    int? rates,
    NetworkExceptions? error,
    String? errorMessage,
  }) {
    return WritingReviewState(
      disease: disease ?? this.disease,
      receiptImages: receiptImages ?? this.receiptImages,
      reviewContent: reviewContent ?? this.reviewContent,
      rates: rates ?? this.rates,
      error: error ?? this.error,
     errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [
    disease, receiptImages, reviewContent, rates
  ];
}