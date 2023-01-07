part of 'writing_review_cubit.dart';

class WritingReviewState extends Equatable {
  const WritingReviewState(
      {this.isComplete,
      this.disease,
      this.receiptImages,
      this.writingImages,
      this.reviewContent,
      this.rates,
      this.error,
      this.errorMessage,
      this.reviews});

  final bool? isComplete;
  final String? disease;
  final List<Asset>? receiptImages;
  final List<Asset>? writingImages;
  final String? reviewContent;
  final int? rates;
  final NetworkExceptions? error;
  final String? errorMessage;
  final List<Review>? reviews;

  WritingReviewState copyWith(
      {bool? isComplete,
      String? disease,
      List<Asset>? receiptImages,
      List<Asset>? writingImages,
      String? reviewContent,
      int? rates,
      NetworkExceptions? error,
      String? errorMessage,
      List<Review>? reviews}) {
    return WritingReviewState(
      isComplete: isComplete ?? this.isComplete,
      disease: disease ?? this.disease,
      receiptImages: receiptImages ?? this.receiptImages,
      writingImages: writingImages ?? this.writingImages,
      reviewContent: reviewContent ?? this.reviewContent,
      rates: rates ?? this.rates,
      error: error ?? this.error,
      errorMessage: errorMessage ?? this.errorMessage,
      reviews: reviews ?? this.reviews,
    );
  }

  @override
  List<Object?> get props => [
        isComplete,
        disease,
        receiptImages,
        writingImages,
        reviewContent,
        rates,
        reviews
      ];
}
