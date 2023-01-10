import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'review_image.dart';

part 'review.g.dart';

@JsonSerializable()
class Review extends Equatable {
  const Review({
    this.id,
    this.nickname,
    this.diagnosis,
    this.rates,
    this.content,
    this.likes,
    this.reviewImage,
    this.createdAt,
    this.isLike,
  });

  final int? id;
  final String? nickname;
  final String? diagnosis;
  final double? rates;
  final String? content;
  final int? likes;
  final List<ReviewImage>? reviewImage;
  final String? createdAt;
  final bool? isLike;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  @override
  List<Object?> get props => [
        id,
        nickname,
        diagnosis,
        rates,
        content,
        likes,
        reviewImage,
        createdAt,
        isLike
      ];
}
